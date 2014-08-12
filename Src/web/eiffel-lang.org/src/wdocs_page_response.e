note
	description: "Summary description for {WDOCS_PAGE_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_PAGE_RESPONSE

inherit
	WSF_HTML_PAGE_RESPONSE
		rename
			make as make_response
		redefine
			make_response,
			send_to
		end

create
	make

feature {NONE} -- Initialization

	make (a_request: WSF_REQUEST; a_content_type: READABLE_STRING_8; a_theme: WDOCS_THEME)
		do
			request := a_request
			content_type := a_content_type
			theme := a_theme
			make_response
		end

	make_response
		do
			Precursor
			create values.make (0)
		end

feature -- Access

	request: WSF_REQUEST

	content_type: READABLE_STRING_8

	theme: WDOCS_THEME

feature -- Access

	values: STRING_TABLE [detachable ANY]

	value (a_key: READABLE_STRING_GENERAL): detachable ANY
		do
			Result := values.item (a_key)
		end

feature -- Element change

	set_value (a_value: detachable ANY; a_key: READABLE_STRING_GENERAL)
		do
			values.force (a_value, a_key)
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		do
			if attached body then
					-- Keep this body
			elseif attached theme.template (content_type) as tpl then
				set_body (tpl.xhtml (request, values))
			end
			Precursor (res)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
