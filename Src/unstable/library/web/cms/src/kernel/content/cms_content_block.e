note
	description: "CMS_BLOCK implemented with a `content' associated with a specific `format'."
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
		require
			a_name_not_blank: not a_name.is_whitespace
		do
			is_enabled := True
			name := a_name
			title := a_title
			content := a_content
			format := a_format
		end

	make_raw (a_name: like name; a_title: like title; a_content: like content; a_format: like format)
		require
			a_name_not_blank: not a_name.is_whitespace
		do
			make (a_name, a_title, a_content, a_format)
			set_is_raw (True)
		end

feature -- Access

	name: READABLE_STRING_8
			-- <Precursor>

	content: READABLE_STRING_8

	format: detachable CONTENT_FORMAT
			--

feature -- Status report

	is_empty: BOOLEAN
			-- Is current block empty?
		do
			Result := is_raw and content.is_empty
		end

	is_raw: BOOLEAN assign set_is_raw
			-- Is raw?
			-- If True, do not get wrapped it with block specific div	

feature -- Element change

	set_is_raw (b: BOOLEAN)
		do
			is_raw := b
		end

	set_name (n: like name)
			-- Set `name' to `n'.
		require
			not n.is_whitespace
		do
			name := n
		end

feature -- Conversion

	to_html (a_theme: CMS_THEME): READABLE_STRING_8
		do
				-- Why in this particular case theme is not used to generate the content?

			if attached format as f then
				Result := f.formatted_output (content)
			else
				Result := content
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
