note
	description: "Summary description for {CMS_MENU_SYSTEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MENU_SYSTEM

inherit
	ITERABLE [CMS_MENU]

create
	make

feature {NONE} -- Initialization

	make
		do
			create items.make (5)
			force (create {CMS_MENU}.make ("main-menu", 3))
			force (create {CMS_MENU}.make_with_title ("management", "Management", 3))
			force (create {CMS_MENU}.make_with_title ("navigation", "Navigation", 3))
			force (create {CMS_MENU}.make_with_title ("user", "User", 3))
		end

feature -- Access

	item (n: like {CMS_MENU}.name): CMS_MENU
		local
			m: detachable CMS_MENU
		do
			m := items.item (n)
			if m = Void then
				create m.make (n, 3)
				force (m)
			end
			Result := m
		end

	main_menu: CMS_MENU
		do
			Result := item ("main-menu")
		end

	management_menu: CMS_MENU
		do
			Result := item ("management")
		end

	navigation_menu: CMS_MENU
		do
			Result := item ("navigation")
		end

	user_menu: CMS_MENU
		do
			Result := item ("user")
		end

	primary_tabs: CMS_MENU
		do
			Result := item ("primary-tabs")
		end

feature -- Change

	force (m: CMS_MENU)
		do
			items.force (m, m.name)
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [CMS_MENU]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature {NONE} -- Implementation

	items: HASH_TABLE [CMS_MENU, like {CMS_MENU}.name]
--	items: ARRAYED_LIST [CMS_MENU]

invariant

end
