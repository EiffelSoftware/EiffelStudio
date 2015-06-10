note
	description: "Simple file execution, serving home.html, ewf.png and 404.html"
	date: "$Date$"
	revision: "$Revision$"

class
	SERVICE_FILE_EXECUTION

inherit
	WSF_EXECUTION

create
	make

feature {NONE} -- Initialization

	execute
		local
			mesg: WSF_RESPONSE_MESSAGE
			not_found: WSF_NOT_FOUND_RESPONSE
		do
			if request.path_info.is_case_insensitive_equal_general ("/") then
				create {WSF_FILE_RESPONSE} mesg.make_html ("home.html")
			elseif request.path_info.is_case_insensitive_equal_general ("/ewf.png") then
				create {WSF_FILE_RESPONSE} mesg.make_with_content_type ({HTTP_MIME_TYPES}.image_png ,"ewf.png")
			else
				create not_found.make (request)
				not_found.add_suggested_location (request.absolute_script_url (""), "Home", "Back to home page")

				mesg := not_found
			end
			response.send (mesg)
		end

end
