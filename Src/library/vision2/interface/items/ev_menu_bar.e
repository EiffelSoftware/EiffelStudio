indexing
	description:
		"[
			Menu bar containing drop down menus. See EV_MENU.
		]"
	status: "See notice at end of class"
	keywords: "menu, bar, item, file, edit, help"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_BAR

inherit
	
	EV_MENU_ITEM_LIST
		export
			{NONE}
				is_parent_recursive
		redefine
			implementation,
			create_implementation
		end

create
	default_create

feature -- Status report
		
	parent: EV_WINDOW is
			-- Parent of `Current'.
		do
			Result := implementation.parent
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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

