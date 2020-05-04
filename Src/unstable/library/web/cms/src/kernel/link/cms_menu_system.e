note
	description: "[
			Menu associated with CMS system.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MENU_SYSTEM

inherit
	ITERABLE [CMS_MENU]

	REFACTORING_HELPER
create
	make

feature {NONE} -- Initialization

	make
			-- Create a predefined manu system
		do
			to_implement ("Refactor, take the info from a Database or Configuration file.")
			create items.make (5)
			force (create {CMS_MENU}.make ("primary", 3))
			force (create {CMS_MENU}.make_with_title ("management", "Management", 3))
			force (create {CMS_MENU}.make_with_title ("secondary", "Navigation", 3))
			force (create {CMS_MENU}.make_with_title ("user", "User", 3))
		end

feature -- Access

	item (n: like {CMS_MENU}.name): CMS_MENU
			-- Menu associated with name `n',
			-- if none, it is created.
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
		obsolete
			"Use `primary_menu' [2017-05-31]"
		do
			Result := primary_menu
		end

	primary_menu: CMS_MENU
		do
			Result := item ("primary")
		end

	secondary_menu: CMS_MENU
		do
			Result := item ("secondary")
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
			-- Add menu `m'.
		do
			items.force (m, m.name)
		end

	sort
		do
			across
				items as ic
			loop
				ic.item.sort
			end
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [CMS_MENU]
			-- Fresh cursor associated with current structure.
		do
			Result := items.new_cursor
		end

feature {NONE} -- Implementation

	items: STRING_TABLE [CMS_MENU]

;note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
