indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	POPUP_IMP

inherit 
	ROOT_MENU_WINDOWS

	MENU_IMP
		redefine
			associated_shell
		end

	POPUP_I

create
	make

feature -- Initialization

	make (a_popup: POPUP; oui_parent: COMPOSITE) is
			-- Create the popup menu
		do
			parent ?= oui_parent.implementation
		end

feature -- Output

	popup is
			-- Display the popup menu
		local
			ww : WEL_COMPOSITE_WINDOW
		do
			if not exists then
				make_track
			end
			put_children_in_menu
			ww ?= parent
			parent.associate_menu (Current)
			show_track (x, y, ww)
			parent.remove_menu
		end

feature {NONE} -- Inapplicable

	associated_shell: WM_SHELL_IMP is
		do
		end

end -- class POPUP_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

