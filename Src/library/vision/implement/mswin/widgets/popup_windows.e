indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	POPUP_WINDOWS 

inherit 
	ROOT_MENU_WINDOWS

	MENU_WINDOWS

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
			ww : WEL_WINDOW
		do
			if not exists then
				make_track
			end
			put_children_in_menu (Current)
			ww ?= parent
			parent.associate_menu (Current)
			show_track (x, y, ww)
			parent.remove_menu
		end

end -- class POPUP_WINDOWS

--|---------------------------------------------------------------- 
--| EiffelVision: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software 
--|   Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------

