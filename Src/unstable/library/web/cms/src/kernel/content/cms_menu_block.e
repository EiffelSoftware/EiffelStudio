note
	description: "Summary description for {CMS_MENU_BLOCK}."
	date: "$Date$"

class
	CMS_MENU_BLOCK

inherit
	CMS_BLOCK

create
	make

feature {NONE} -- Initialization

	make (a_menu: like menu)
		do
			is_enabled := True
			menu := a_menu
			name := a_menu.name
			title := a_menu.title
		end

feature -- Access

	menu: CMS_MENU

	name: READABLE_STRING_8

feature -- Status report

	is_empty: BOOLEAN
			-- Is current block empty?
		do
			Result := menu.is_empty
		end

	is_horizontal: BOOLEAN assign set_is_horizontal
		-- Is horizontal layout for the menu?

	is_raw: BOOLEAN assign set_is_raw
			-- <Precursor>

feature -- Element change

	set_name (n: like name)
			-- Set `name' to `n'.
		require
			not n.is_whitespace
		do
			name := n
		end

	set_is_horizontal (b: BOOLEAN)
			-- Set `is_horizontal' to `b'.
		do
			is_horizontal := b
		end

	set_is_raw (b: BOOLEAN)
			-- Set `is_raw' to `b'.
		do
			is_raw := b
		end

feature -- Conversion

	to_html (a_theme: CMS_THEME): STRING_8
		do
			Result := a_theme.menu_html (menu, is_horizontal, html_options)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
