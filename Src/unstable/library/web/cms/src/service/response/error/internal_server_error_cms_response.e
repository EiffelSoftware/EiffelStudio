note
	description: "Summary description for {INTERNAL_SERVER_ERROR_CMS_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	INTERNAL_SERVER_ERROR_CMS_RESPONSE

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
			set_status_code ({HTTP_STATUS_CODE}.internal_server_error)
			page.register_variable (absolute_url (location, Void), "request")
			page.set_status_code (status_code)
			page.register_variable (status_code.out, "code")
		end

feature -- Execution

	process
			-- Computed response message.
		do
			set_title ("Internal Server Error")
			set_page_title (Void)
			set_main_content ("<em>Internal Server Error</em>")
		end
note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

