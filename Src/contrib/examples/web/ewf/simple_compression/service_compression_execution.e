note
	description: "Simple file execution, serving home.html, ewf.png and 404.html"
	date: "$Date$"
	revision: "$Revision$"

class
	SERVICE_COMPRESSION_EXECUTION

inherit
	WSF_ROUTED_EXECUTION
		redefine
			initialize,
			execute_default
		end

create
	make

feature {NONE} -- Initialization


	initialize
			-- Initialize current service.
		do
			Precursor
			initialize_router
		end

	setup_router
		local
			fhdl_with_compression: WSF_FILE_SYSTEM_HANDLER_WITH_COMPRESSION
			fhdl: WSF_FILE_SYSTEM_HANDLER
 		do
 			create fhdl_with_compression.make_hidden ("www")
 			fhdl_with_compression.set_directory_index (<<"index.html">>)
 			fhdl_with_compression.compression.set_default_compression_format
 			fhdl_with_compression.compression.enable_compression_for_media_type ({HTTP_MIME_TYPES}.image_jpg)
 			fhdl_with_compression.set_not_found_handler (agent  (ia_uri: READABLE_STRING_8; ia_req: WSF_REQUEST; ia_res: WSF_RESPONSE)
				do
					execute_default (ia_req, ia_res)
				end)
 			router.handle ("/compressed/", fhdl_with_compression, router.methods_GET)

 			create fhdl.make_hidden ("www")
 			fhdl.set_directory_index (<<"index.html">>)
 			fhdl.set_not_found_handler (agent  (ia_uri: READABLE_STRING_8; ia_req: WSF_REQUEST; ia_res: WSF_RESPONSE)
				do
					execute_default (ia_req, ia_res)
				end)
 			router.handle ("/", fhdl, router.methods_GET)
		end


	execute_default (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Dispatch requests without a matching handler.
		local
			not_found: WSF_NOT_FOUND_RESPONSE
			mesg: WSF_RESPONSE_MESSAGE
		do
			create not_found.make (request)
			not_found.add_suggested_location (request.absolute_script_url (""), "Home", "Back to home page")
			mesg := not_found
			res.send (mesg)
		end



end
