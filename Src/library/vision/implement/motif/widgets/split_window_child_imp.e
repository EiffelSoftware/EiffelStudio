indexing

	descriotion:
		"Child for a SPLIT_WINDOW.";
	date: "$Date$";
	revision: "$Revision$"

class SPLIT_WINDOW_CHILD_IMP


inherit
	FORM
		rename
			make as form_make,
			make_unmanaged as form_make_unmanaged
		redefine
			parent, implementation,
			manage, unmanage, set_size
		end
	
	MEL_PANED_WINDOW_CHILD_RESOURCES
	MEL_XT_FUNCTIONS


feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: SPLIT_WINDOW) is
			-- Initialize Current.
		do
			parent:= a_parent
			form_make (a_name, a_parent)
			allow_pane_resize
		end;

feature -- Sizing policy

	set_size (new_width:INTEGER; new_height: INTEGER) is
		do

			if parent.is_vertical then
				set_pane_minimum ( new_width)
			else
				set_pane_minimum ( new_height)
			end
			Precursor (new_width,new_height)
			set_pane_minimum (1)

		end

	
feature -- Widget Management

	set_child_managed is
			-- Manage Current.
			--| Ie. Make it visible on the screen.
		do
			implementation.set_managed(True)
		end;

	set_child_unmanaged is
			-- Unmanage Current.
			--| Ie. Make ir invisible on the screen.
		do
			implementation.set_managed (False)
		end


feature -- Widget Management


	manage is
			-- Manage Current.
			--| Ie. Make it visible on the screen.
		do
			-- redefine it in descdendant
		end;

	unmanage is
			-- Unmanage Current.
			--| Ie. Make ir invisible on the screen.
		do
			-- redefine it in descdendant
		end

feature -- Implementation

	implementation: FORM_I
			-- Implementation Window

	parent: SPLIT_WINDOW


feature --PanedWindow...

	allow_pane_resize is
			-- Set `allow_pane_to_resize' to True.
		do
			set_xt_boolean (screen_object, XmNallowResize, True)
		end;

	forbid_pane_resize is
			-- Set `allow_pane_to_resize' to False.
		do
			set_xt_boolean (screen_object, XmNallowResize, False)
		end;

	set_pane_minimum (a_dimension: INTEGER) is
			-- Set `pane_minimum' to `a_dimension'.
		do
			set_xt_dimension (screen_object, XmNpaneMinimum, a_dimension)
		end;

	set_pane_maximum (a_dimension: INTEGER) is
			-- Set `pane_maximum' to `a_dimension'.
		do
			set_xt_dimension (screen_object, XmNpaneMaximum, a_dimension)
		end;



end -- class SPLIT_WINDOW_CHILD_IMP
