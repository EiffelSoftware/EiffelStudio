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
	make,
	make_raw

feature {NONE} -- Initialization

	make (a_name: like name; a_title: like title; a_content: like content; a_format: like format)
		do
			is_enabled := True
			name := a_name
			title := a_title
			content := a_content
			format := a_format
		end

	make_raw (a_name: like name; a_title: like title; a_content: like content; a_format: like format)
		do
			make (a_name, a_title, a_content, a_format)
			set_is_raw (True)
		end

feature -- Access

	name: READABLE_STRING_8

	title: detachable READABLE_STRING_32

	content: READABLE_STRING_8

	format: detachable CONTENT_FORMAT

feature -- Status report

	is_raw: BOOLEAN
			-- Is raw?
			-- If True, do not get wrapped it with block specific div	

feature -- Element change

	set_is_raw (b: BOOLEAN)
		do
			is_raw := b
		end

feature -- Conversion

	to_html (a_theme: CMS_THEME): STRING_8
		do
				-- Why in this particular case theme is not used to generate the content?

			if attached format as f then
				Result := f.formatted_output (content)
			else
				Result := content
			end
		end
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
