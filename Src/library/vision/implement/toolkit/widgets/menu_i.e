indexing

	description: "General menu implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	MENU_I 

inherit

	MANAGER_I
	
feature -- Access

	title: STRING is
			-- Title of menu
		deferred
		end;

feature -- Element change

	set_title (a_title: STRING) is
			-- Set menu title to `a_title'.
		require
			not_title_void: a_title /= Void
		deferred
		end;

feature -- Removal

	remove_title is
			-- Remove current menu title if any.
		deferred
		end;

end -- class MENU_I



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

