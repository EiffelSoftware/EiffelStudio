
-- Area which enables alternate way of choosing a setting.

indexing

	date: "$Date$";
	revision: "$Revision$"

class CHECK_BOX 

inherit

	MANAGER
		redefine
			implementation
		end

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a check box with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			implementation:= toolkit.check_box (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifer_set: identifier.is_equal (a_name)
		end;

feature {NONE}

	set_default is
			-- Set default values to current check box.
		do
		end;
	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: CHECK_BOX_I
			-- Implementation of current check box

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
