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

	title: detachable READABLE_STRING_32

feature -- Status report

	is_horizontal: BOOLEAN

	is_raw: BOOLEAN = False
			-- <Precursor>

feature -- Element change

	set_name (n: like name)
			-- Set `name' to `n'.
		require
			not n.is_whitespace
		do
			name := n
		end

	set_title (a_title: like title)
			-- Set `title' to `a_title'.
		do
			title := a_title
		end

feature -- Conversion

	to_html (a_theme: CMS_THEME): STRING_8
		do
			Result := a_theme.menu_html (menu, is_horizontal)
		end

end
