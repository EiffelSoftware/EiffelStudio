indexing

	description:
		"Message box with a specific error symbol to warn the user %
		%of an invalid or potentially dangerous condition, it appears like an error dialog. %
		%A dialog shell is automatically created as its parent";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	ERROR_D 

inherit

	MESSAGE_D
		rename
			make as message_d_make
		redefine
			implementation
		end

creation

	make
	
feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an error dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_parent: a_name /= Void;
			parent_not_void: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			implementation:= toolkit.error_d (Current, a_parent);
			set_default
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name)
		end;
	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementaiton

	implementation: ERROR_D_I
			-- Implementation of error dialog

end -- class ERROR_D


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
--|----------------------------------------------------------------

