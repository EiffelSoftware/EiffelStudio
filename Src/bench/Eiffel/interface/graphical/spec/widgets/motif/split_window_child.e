indexing

	description:
		"Class to hold a child for split windows.";
	date: "$Date$";
	revision: "$Revision$"

class SPLIT_WINDOW_CHILD

inherit
	FORM
		rename
			make as form_make,
			make_unmanaged as form_make_unmanaged
		redefine
			parent
		end;
	FORM
		redefine
			make, make_unmanaged, parent
		select
			make, make_unmanaged
		end

creation
	make, make_unmanaged

feature -- Initialization

	make (name: STRING; a_parent: SPLIT_WINDOW) is
			-- Create a split window child with `a_name' as
			-- identifier and `a_parent' as parent.
		do
			parent := a_parent
			form_make (name, a_parent);
		end;

	make_unmanaged (name: STRING; a_parent: SPLIT_WINDOW) is
			-- Create a split window child with `a_name' as
			-- identifier and `a_parent' as parent.
		do
			parent := a_parent
			form_make_unmanaged (name, a_parent);
		end

feature -- Status Setting

	set_min_height (a_height: INTEGER) is
			-- Set minimum resize height to be `a_height'.
		do
			parent.set_widget_pane_minimum (Current, a_height)
		end

feature -- Access

	parent: SPLIT_WINDOW
		-- Current's parent (in GUI sense)

end -- class SPLIT_WINDOW_CHILD
