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

create

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
			create {ERROR_D_IMP} implementation.make (Current, a_parent);
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

