indexing
	description: "Widget that represents a split window.";
	date: "$Date$";
	revision: "$Revision $"

class
	SPLIT_WINDOW

inherit
	FORM
		rename
			make as form_make
		redefine
			implementation
		end

creation
	make_horizontal, make_vertical,
	make_horizontal_with_proportion, make_vertical_with_proportion

feature -- Initialization

	make_horizontal (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an horizontal frame with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			make (a_name, a_parent, False)
			set_proportion(50)
		end

	make_horizontal_with_proportion (a_name: STRING; a_parent: COMPOSITE; proportion: INTEGER) is
			-- Create an horizontal frame with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			make (a_name, a_parent, False)
			set_proportion(proportion)
		end

	make_vertical (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a vertical frame with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			make (a_name, a_parent, True)
			set_proportion(50)
		end

	make_vertical_with_proportion (a_name: STRING; a_parent: COMPOSITE; proportion: INTEGER) is
			-- Create a vertical frame with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			make (a_name, a_parent, True)
			set_proportion(proportion)
		end

feature {NONE} -- Implementation

	make (a_name: STRING; a_parent: COMPOSITE; vertical: BOOLEAN) is
			-- Create a frame with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			depth := a_parent.depth + 1
			widget_manager.new (Current, a_parent)
			identifier:= clone (a_name)
			is_vertical := vertical
			!SPLIT_WINDOW_IMP! implementation.make (Current, a_parent, is_vertical)
			implementation.set_widget_default
			set_default
		ensure
			parent_set: parent = a_parent
			identifier_set: identifier.is_equal (a_name)
		end;

feature -- Access

	implementation: SPLIT_WINDOW_I

	is_vertical: BOOLEAN
			-- Is the split window a vertical one?

feature -- Status Setting

	set_proportion (p:INTEGER) is
			-- Set the split proportion from 1 to 99.
		do
			implementation.set_proportion (p)
		end


	set_widget_pane_minimum (a_widget: WIDGET; a_dimension: INTEGER) is
		local
			--l: MEL_RECT_OBJ
		do
			--l ?= a_widget.implementation
			--implementation.set_widget_pane_minimum (l, a_dimension)
		end

end -- class SPLIT_WINDOW
