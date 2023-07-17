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
   	int maxMemSize = 169544; //500 KB
   	String pdesc = "", pid = null, p_img = null;
   	
   	String contentType = request.getContentType();	
   	
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
      
      Integer isNewPostImage = 0;
      
      try { 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);
         // Process the uploaded file items
         Iterator i = fileItems.iterator();
		
         while ( i.hasNext () ) {
            FileItem fi = (FileItem)i.next();
            
            
            if ( !fi.isFormField ()) {
            	if(fi.getSize() > 1 && fi.getSize() < (10000 * 1024)){
            		p_img = FilenameUtils.getExtension(fi.getName());            		
            		p_img = "P_"+session.getAttribute("u_id").toString()+"_"+System.currentTimeMillis()+"."+p_img;
            		
                    // Write the file
                    if( p_img.lastIndexOf("\\") >= 0 ) {
                       	file = new File( filePath + 
                    	p_img.substring( p_img.lastIndexOf("\\"))) ;
                    } else {
                       	file = new File( filePath + 
                    	p_img.substring(p_img.lastIndexOf("\\")+1)) ;
                    }                    
                    fi.write( file ) ;
                    isNewPostImage = 1;
            	}            	
               
            }else{
            	 if(fi.getFieldName().equals("pdesc"))
            		pdesc = fi.getString();
            	else if (fi.getFieldName().equals("pid")){
            		if(fi.getSize() < 1){
            			pid = null;
            		}else{
            			pid = fi.getString();
            		}
            	}
            }
         }
         // DB INSERT
         PreparedStatement pstmt = null;
         	if(pid == null){
				pstmt = con.prepareStatement("INSERT INTO post(p_desc, p_img, u_id) VALUES (?,?,?)");
				pstmt.setString(1, pdesc);
				pstmt.setString(2, p_img);
				pstmt.setString(3, session.getAttribute("u_id").toString());
			}else{	
				if (isNewPostImage == 1){
					
					 PreparedStatement pstmt_fetch_pimg = null;
					 pstmt_fetch_pimg = con.prepareStatement("SELECT p_img FROM post WHERE p_id = ?");
					 pstmt_fetch_pimg.setString(1, pid);
		        	 
		        	 ResultSet rs= pstmt_fetch_pimg.executeQuery();
		   			 rs.next();
		   			 
		   			 String old_img = rs.getString("p_img");
		   			
		   			File old_file = new File (filePath + old_img);
		   			if(old_file.delete())
	   					System.out.println("Old File : " + old_img + " Deleted");
	   				else
	   					System.out.println("Error: Deleting Old File");
					
					pstmt = con.prepareStatement("UPDATE post SET p_desc = ?, p_img = ? WHERE p_id = ?;");
					pstmt.setString(1, pdesc);
					pstmt.setString(2, p_img);
					pstmt.setString(3, pid);
				}else{
					pstmt = con.prepareStatement("UPDATE post SET p_desc = ? WHERE p_id = ?;");
					pstmt.setString(1, pdesc);
					pstmt.setString(2, pid);
				}
				
			}
			if(pstmt.executeUpdate() > 0){
				System.out.println("New Post Added !");
			}
      } catch(Exception ex) {
    	 System.out.println(ex);
      }
   }
   response.sendRedirect(request.getHeader("referer"));
%>