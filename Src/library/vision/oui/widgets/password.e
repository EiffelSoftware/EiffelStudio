indexing

	description:
		"A text editor for one line of text without echo. %
		%Characters are shown as '*' (stars)."; 
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	PASSWORD

inherit

	TEXT_FIELD
		redefine
			create_ev_widget
		end

creation

	make, make_unmanaged

feature {NONE} -- Initialization

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a password field with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			implementation := toolkit.password (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

end -- class PASSWORD

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

