indexing

	description:
		"Menu which is part of a menu system. % 
		%It has to be attached to a menu button which will make appear %
		%it when armed";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	PULLDOWN 

inherit

	MENU
		redefine
			implementation
		end
	
feature 

	button: BUTTON is
			-- button 
		deferred
		end;
	
feature -- Access

	text: STRING is
			-- Label of menu button
		require
			exists: not destroyed
		do
			Result := implementation.text
		end;

feature -- Status setting

	allow_recompute_size is
		require
			exists: not destroyed
		do
			implementation.allow_recompute_size;
		end;

	forbid_recompute_size is
		require
			exists: not destroyed
		do
			implementation.forbid_recompute_size;
		end;

feature -- Element change

	set_text (a_text: STRING) is
			-- Set button label to `a_text'.
		require
			exists: not destroyed
		do
			implementation.set_text(a_text)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: PULLDOWN_I;
			-- Implementation of pulldown menu
	
end -- class PULLDOWN



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

