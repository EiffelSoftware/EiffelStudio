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
			set_status_code ({HTTP_STATUS_CODE}.not_implemented)
			page.register_variable (absolute_url (request.percent_encoded_path_info, Void), "request")
			page.set_status_code (status_code)
			page.register_variable (status_code.out, "code")
		end

feature -- Execution

	process
			-- Computed response message.
		local
			s: STRING
		do
			set_title ("Not Implemented")
			set_page_title (Void)
			if main_content = Void then
				create s.make_from_string (html_encoded (request.percent_encoded_path_info))
				s.append (" is not implemented!")
				set_main_content (s)
			end
		end
note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

