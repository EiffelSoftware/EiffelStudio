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

creation
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
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

