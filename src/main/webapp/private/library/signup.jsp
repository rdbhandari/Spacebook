<%@ include file="db_conn.jsp"%>
<%@ include file="constants.jsp"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>
<%@ page import = "org.apache.commons.io.FilenameUtils" %>

<%
   	File file ;
   	int maxFileSize = 307382; //153600
   	int maxMemSize =  169544; //500 KB
  
   	
	String contentType = request.getContentType();
   	//System.out.print(contentType);	
   	
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize); 
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("C:\\temp"));
      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      
      String uid = null;
      String defaultImage = "d00000.jpg";
      String ip_uemail = "", ip_uname = "", dp_img = defaultImage;
      String ip_upswd = "", ip_udob = "", ip_ugender = "";
      Integer isNewDp = 0;
      
      try { 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);
         // Process the uploaded file items
         Iterator i = fileItems.iterator();
			
         while ( i.hasNext () ) {
            FileItem fi = (FileItem)i.next();
            //System.out.println(fi.getFieldName() + " = " + fi.getString());
            
            if ( !fi.isFormField ()) {
            	if(fi.getSize() > 1 && fi.getSize() < (100 * 1024)){
            		
            		dp_img = FilenameUtils.getExtension(fi.getName());            		
            		dp_img = "D_"+System.currentTimeMillis()+"."+dp_img;
            		
                    // Write the file
                    if( dp_img.lastIndexOf("\\") >= 0 ) {
                       	file = new File( filePath + 
                    	dp_img.substring( dp_img.lastIndexOf("\\"))) ;
                    } else {
                       	file = new File( filePath + 
                    	dp_img.substring(dp_img.lastIndexOf("\\")+1)) ;
                    }                    
                    fi.write( file ) ;
                    isNewDp = 1;
            	}            	
               
            }else{
            	if(fi.getFieldName().equals("uid"))
            		uid = fi.getString();
            	else if(fi.getFieldName().equals("ip_uemail"))
            		ip_uemail = fi.getString();
            	else if (fi.getFieldName().equals("ip_uname"))
            		ip_uname = fi.getString();
            	else if(fi.getFieldName().equals("ip_upswd"))
            		ip_upswd = fi.getString();
            	else if (fi.getFieldName().equals("ip_udob"))
            		ip_udob = fi.getString();
            	else if(fi.getFieldName().equals("ip_ugender"))
            		ip_ugender = fi.getString();
            }
         }
         
         
         // DB INSERT
         PreparedStatement pstmt = null;
         if(uid == null){
	        	pstmt = con.prepareStatement("INSERT INTO user(u_email,u_name,u_dob,u_gender,u_pswd, u_img) VALUES (?,?,?,?,?,?)");
	 			
	 			pstmt.setString(1, ip_uemail);
	 			pstmt.setString(2, ip_uname);
	 			pstmt.setString(3, ip_udob);
	 			pstmt.setString(4, ip_ugender);
	 			pstmt.setString(5, ip_upswd);
	 			pstmt.setString(6, dp_img);
		}else{
			// FECTH OLD FILE AND DELETE : IF NEW IMGAE IS ADDED/CHANGED
	         if (isNewDp == 1){
	        	 PreparedStatement pstmt_fetch_img = null;
	        	 pstmt_fetch_img = con.prepareStatement("SELECT u_img FROM user WHERE u_id = ?");
	        	 pstmt_fetch_img.setString(1, uid);
	        	 
	        	 ResultSet rs= pstmt_fetch_img.executeQuery();
	   			 rs.next();
	   			 
	   			 String old_img = rs.getString("u_img");
	   			 
				// CHECK : Default image will not be deleted
	   			 if (!old_img.equals(defaultImage)){
	   				 
	   				File old_file = new File (filePath + old_img);
	   				
	   				if(old_file.delete())
	   					System.out.println("Old File Deleted");
	   				else
	   					System.out.println("Error In Deleting Old File");
	   			    } 
	   			pstmt = con.prepareStatement("UPDATE user SET u_name = ?, u_img = ?, u_dob = ?, u_gender = ?, u_pswd = ? WHERE u_id = ?");
	 			pstmt.setString(1, ip_uname);
	 			pstmt.setString(2, dp_img);
	 			pstmt.setString(3, ip_udob);
	 			pstmt.setString(4, ip_ugender);
	 			pstmt.setString(5, ip_upswd);
	 			pstmt.setString(6, uid);
	         }else{
	        	 pstmt = con.prepareStatement("UPDATE user SET u_name = ?, u_dob = ?, u_gender = ?, u_pswd = ? WHERE u_id = ?");
		 			pstmt.setString(1, ip_uname);
		 			pstmt.setString(2, ip_udob);
		 			pstmt.setString(3, ip_ugender);
		 			pstmt.setString(4, ip_upswd);
		 			pstmt.setString(5, uid);
	         }
	         
			}
		if(pstmt.executeUpdate() > 0 && uid == null){
				response.sendRedirect("http://localhost:8080/Spacebook/");
		}else{
				session.setAttribute("u_name", ip_uname);				
				session.setAttribute("u_img", dp_img);
				
				response.sendRedirect("http://localhost:8080/Spacebook/me.jsp");
			}
      
      } catch(Exception ex) {
    	  response.sendRedirect("http://localhost:8080/Spacebook/");
    	 System.out.println(ex);
      }
   }
%>