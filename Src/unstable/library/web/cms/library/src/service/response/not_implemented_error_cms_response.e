note
	description: "Summary description for {NOT_IMPLEMENTED_ERROR_CMS_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	NOT_IMPLEMENTED_ERROR_CMS_RESPONSE

inherit

	CMS_RESPONSE
		redefine
			custom_prepare
		end

create
	make

feature -- Generation

	custom_prepare (page: CMS_HTML_PAGE)
		do
			page.register_variable (request.absolute_script_url (request.path_info), "request")
			page.set_status_code ({HTTP_STATUS_CODE}.not_implemented)
			page.register_variable (page.status_code.out, "code")
		end

feature -- Execution

	process
			-- Computed response message.
		do
			set_title ("Not Implemented")
			set_page_title (Void)
			if main_content = Void then
				set_main_content (request.percent_encoded_path_info + " is not implemented!")
			end
		end
end

