
-- Simple vertical or horizontal line to be used as separator.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SEPARATOR 

inherit

	PRIMITIVE
		redefine
			implementation
		end

creation

	make
	
feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a separator with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			implementation := toolkit.separator (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;

feature -- Orientation

	is_horizontal: BOOLEAN is
			-- Is separator oriented horizontal?
		do
			Result := implementation.is_horizontal
		end;

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		do
			implementation.set_horizontal (flag)
		ensure
			value_correctly_set: is_horizontal = flag
		end;

feature -- Line type

	set_single_line is
			-- Set separator display to be single line.
		do
			implementation.set_single_line
		end;

	set_double_line is
			-- Set separator display to be double line.
		do
			implementation.set_double_line
		end;

	set_single_dashed_line is
			-- Set separator display to be single dashed line.
		do
			implementation.set_single_dashed_line
		end;

	set_double_dashed_line is
			-- Set separator display to be double dashed line.
		do
			implementation.set_double_dashed_line
		end;

	set_no_line is
			-- Make separator invisible.
		do
			implementation.set_no_line
		end 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: SEPARATOR_I;
			-- Implementation of separator

feature {NONE}

	set_default is
			-- Set default values to current separator.
		do
		end;
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
