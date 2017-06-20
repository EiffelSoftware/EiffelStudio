note
	description: "Summary description for {HTTP_CLIENT_REQUEST_FORM_PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_CLIENT_REQUEST_FORM_PARAMETERS

inherit
	HTTP_CLIENT_REQUEST_PARAMETERS [HTTP_CLIENT_REQUEST_PARAMETER]

create
	make

feature -- Status report

	has_file_parameter: BOOLEAN
			-- Has any file parameter?
		do
			Result := across items as ic some attached {HTTP_CLIENT_REQUEST_FILE_PARAMETER} ic.item end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
