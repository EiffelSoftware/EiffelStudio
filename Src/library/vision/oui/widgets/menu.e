
-- General notion of menu.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class MENU  

inherit

	MANAGER
		redefine
			implementation
		end
	
feature -- Text

	set_title (a_title: STRING) is
			-- Set menu title to `a_title'.
		require
			Valid_title: a_title /= Void
		do
			implementation.set_title (a_title)
		end;

	title: STRING is
			-- Title of menu
		do
			Result:= implementation.title
		end; 

	remove_title is
			-- Remove current menu title if any.
		do
			implementation.remove_title
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: MENU_I;
			-- Implementation of menu

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
