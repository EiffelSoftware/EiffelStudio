indexing

	description: 
		"Widget that represents a split window.";
	date: "$Date$";
	revision: "$Revision $"

class SPLIT_WINDOW

inherit

	MANAGER
		redefine
			implementation
		end

creation

	make

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a frame with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			!! implementation.make (Current, True, a_parent);
			implementation.set_widget_default;
			set_default
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
		end;

feature -- Access

	implementation: SPLIT_WINDOW_I

	set_default is
		do
		end;

feature -- Status Setting

	set_widget_pane_minimum (a_widget: WIDGET; a_dimension: INTEGER) is
		local
			--l: MEL_RECT_OBJ
		do
			--l ?= a_widget.implementation;
			--implementation.set_widget_pane_minimum (l, a_dimension)
		end

end -- class SPLIT_WINDOW
