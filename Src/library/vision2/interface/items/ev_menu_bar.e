indexing
	description:
		"Menu bar containing drop down menus. See EV_MENU."
	status: "See notice at end of class"
	keywords: "menu, bar, item, file, edit, help"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_BAR

inherit
	EV_MENU_ITEM_LIST
		redefine
			implementation,
			create_implementation
		end

create
	default_create

feature -- Status report

	parent: EV_MENU_ITEM_LIST is
			-- Container of `Current'.
		do
			-- Menu bars have no menu item list as parent.
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_MENU_BAR_I
			-- Responsible for interaction with native graphics toolkit.
		
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_BAR_IMP} implementation.make (Current)
		end

end -- class EV_MENU BAR

--!-----------------------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------------------
