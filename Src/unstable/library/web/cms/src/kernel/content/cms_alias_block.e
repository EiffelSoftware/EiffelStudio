note
	description: "[
				Block being an alias of other block.
				
				Mainly to avoid multiple region for a block content.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ALIAS_BLOCK

inherit
	CMS_BLOCK
		redefine
			append_to_html
		end

create
	make_with_block

feature {NONE} -- Initialization

	make_with_block	(a_name: READABLE_STRING_8; a_block: CMS_BLOCK)
		do
			name := a_name
			origin := a_block
			title := a_block.title
		end

feature -- Access

	origin: CMS_BLOCK

	name: READABLE_STRING_8

feature -- Status report	

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := origin.is_empty
		end

	is_raw: BOOLEAN
			-- <Precursor>
		do
			Result := origin.is_raw
		end

feature -- Conversion

	append_to_html  (a_theme: CMS_THEME; a_output: STRING_8)
			-- Append HTML representation of Current block to `a_output'.
		do
			origin.append_to_html (a_theme, a_output)
		end

	to_html (a_theme: CMS_THEME): READABLE_STRING_8
			-- HTML representation of Current block.
		do
			Result := origin.to_html (a_theme)
		end

;note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
