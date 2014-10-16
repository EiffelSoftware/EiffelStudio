note
	description: "Summary description for {CMS_CONTENT_BLOCK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_CONTENT_BLOCK

inherit
	CMS_BLOCK

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_title: like title; a_body: like body; a_format: like format)
		do
			is_enabled := True
			name := a_name
			title := a_title
			body := a_body
			format := a_format
		end

feature -- Access

	name: READABLE_STRING_8

	title: detachable READABLE_STRING_32

	body: READABLE_STRING_8

	format: CONTENT_FORMAT

feature -- Conversion

	to_html (a_theme: CMS_THEME): STRING_8
		do
			Result := format.formatted_output (body)
		end

invariant

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
