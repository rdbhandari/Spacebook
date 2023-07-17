<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>

<%
   	File file ;
   	int maxFileSize = 307382; //153600
   	int maxMemSize = 169544; //500 KB
  	ServletContext context = pageContext.getServletContext();
  
	String filePath = "D:\\Education\\M.Sc. CS\\SEMESTER - 1\\Web Technology - SG\\Projects\\Spacebook\\webapp\\img\\";
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
      
      //System.out.println(request.getHeaderNames());
      
      try { 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);
         
         
         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         while ( i.hasNext () ) {        	 
            FileItem fi = (FileItem)i.next();
            
            System.out.println("Size of " + fi.getFieldName() + " is : " + fi.getSize());
            
            if ( !fi.isFormField ()) {
            	if(fi.getSize() > 1 && fi.getSize() < (10000 * 1024)){
            		String fileName = fi.getName();
                    
                    // Write the file
                    if( fileName.lastIndexOf("\\") >= 0 ) {
                       file = new File( filePath + 
                       fileName.substring( fileName.lastIndexOf("\\"))) ;
                    } else {
                       file = new File( filePath + 
                       fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                    }
                    fi.write( file ) ;
                    //System.out.println("FILE: Size of " + fi.getFieldName() + " is : " + fi.getSize());
            	}            	
               
            }else{            	
            	
            }
            
         }
      } catch(Exception ex) {
         System.out.println(ex);
      }
   }
%>