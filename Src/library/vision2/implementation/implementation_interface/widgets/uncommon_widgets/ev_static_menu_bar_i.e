indexing
	description: "EiffelVision static menu bar.A static menu bar%
				% is a menu bar attached to a window. It cannot%
				% be resized or moved."
	note: "The parent of such a menu can only be an EV_WINDOW"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_STATIC_MENU_BAR_I

inherit
	EV_MENU_CONTAINER_I
	
feature {NONE} -- Initialization
	
	make (par: EV_WINDOW) is         
			-- Create a menu widget with `par' as parent window.
		require
			parent_exists: not par.destroyed
		deferred
		end	

feature -- Access
	
	parent: EV_WINDOW is
			-- The widget that has the current menu
		require
			exists: not destroyed
		do
			Result ?= parent_imp.interface
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is the current menu destroyed ?
		deferred
		end

feature -- Status setting

	destroy is
			-- Destroy the actual static menu-bar.
		require
			exists: not destroyed
		deferred
		end

feature {NONE} -- Implementation

	parent_imp: EV_WINDOW_IMP
			-- The window where the menu is.

end -- class EV_STATIC_MENU_BAR_I

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|---------------------------------------------------------------
