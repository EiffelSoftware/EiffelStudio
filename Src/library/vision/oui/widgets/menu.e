indexing

	description: "General notion of menu";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	MENU  

inherit

	MANAGER
		redefine
			implementation
		end
	
feature -- Access

	title: STRING is
			-- Title of menu
		require
			exists: not destroyed;
		do
			Result:= implementation.title
		end; 

feature -- Element change

	set_title (a_title: STRING) is
			-- Set menu title to `a_title'.
		require
			exists: not destroyed;
			valid_title: a_title /= Void
		do
			implementation.set_title (a_title)
		end;

	remove_title is
			-- Remove current menu title if any.
		require
			exists: not destroyed;
		do
			implementation.remove_title
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: MENU_I;
			-- Implementation of menu

end -- class MENU

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

