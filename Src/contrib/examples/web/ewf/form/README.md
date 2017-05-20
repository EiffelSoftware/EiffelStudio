This example demonstrates the use of the `wsf_html` library for web form handling.

To simplify the code, it is also using the `WSF_RESPONSE.send (WSF_RESPONSE_MESSAGE)`,
thus no need to write the expected http header here.

The current code is a web interface form, returning html page as response.
		
notes:
* It is not using the `WSF_ROUTER` component to keep the example as simple as possible.
* It is also possible to use the `WSF_REQUEST.form_parameter (...)` directly, 
	  but WSF_FORM provides advanced processing.
* For a CRUD REST API, you can also use `WSF_FORM` to analyze the incoming POST values, 
	  however the html generation may be too verbose for a simple REST api.
	  
warning: depending on your system and connector, you may need to use `WSF_REQUEST.set_uploaded_file_path (...)`
		to tell the server where to store the temporary uploaded files.
		(this should be a directory with write permission for the server).
		For that
			- inherit from WSF_REQUEST_EXPORTER
			- in `execute` add at the beginning the call `request.set_uploaded_file_path (path-to-wanted-directory)` 
