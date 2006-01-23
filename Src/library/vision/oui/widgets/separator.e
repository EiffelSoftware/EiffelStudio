indexing

	description: "Simple vertical or horizontal line to be used as separator"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	SEPARATOR 

inherit

	PRIMITIVE
		redefine
			implementation
		end

create

	make, make_unmanaged
	
feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a separator with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged separator with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a separator with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			create {SEPARATOR_IMP} implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Status report

	is_horizontal: BOOLEAN is
			-- Is separator oriented horizontal?
		require
			exists: not destroyed
		do
			Result := implementation.is_horizontal
		end;

feature -- Status setting

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		require
			exists: not destroyed
		do
			implementation.set_horizontal (flag)
		ensure
			value_correctly_set: is_horizontal = flag
		end;

	set_single_line is
			-- Set separator display to be single line.
		require
			exists: not destroyed
		do
			implementation.set_single_line
		end;

	set_double_line is
			-- Set separator display to be double line.
		require
			exists: not destroyed
		do
			implementation.set_double_line
		end;

	set_single_dashed_line is
			-- Set separator display to be single dashed line.
		require
			exists: not destroyed
		do
			implementation.set_single_dashed_line
		end;

	set_double_dashed_line is
			-- Set separator display to be double dashed line.
		require
			exists: not destroyed
		do
			implementation.set_double_dashed_line
		end;

	set_no_line is
			-- Make separator invisible.
		require
			exists: not destroyed
		do
			implementation.set_no_line
		end 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: SEPARATOR_I;
			-- Implementation of separator

feature {NONE} -- Implementation

	set_default is
			-- Set default values to current separator.
		do
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SEPARATOR

