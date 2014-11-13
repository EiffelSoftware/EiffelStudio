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
			page.register_variable ("501", "code")
			page.set_status_code (501)
		end

feature -- Execution

	process
			-- Computed response message.
		do
			set_title ("Not Implemented")
			set_page_title (Void)
		end
end

