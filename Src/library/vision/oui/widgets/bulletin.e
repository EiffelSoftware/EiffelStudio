
-- Area for free-form placement on any of its children.

indexing

	date: "$Date$";
	revision: "$Revision$"

class BULLETIN 

inherit

	MANAGER
		redefine
			implementation
		end

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a bulletin with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			implementation:= toolkit.bulletin (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;

	set_default_position (flag: BOOLEAN) is
		do
			implementation.set_default_position (flag);
		end;


feature {NONE}

	set_default is
			-- Set default values to current bulletin.
		do
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: BULLETIN_I
			-- Implementation of bulletin

end


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
