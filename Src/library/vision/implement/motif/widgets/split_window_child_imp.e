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
debug ("SPLIT")
			io.put_string ("%NSet_size: ");
			io.put_string ("%N%Tnew_width = ");
			io.put_integer (new_width)
			io.put_string ("%N%Tnew_height = ");
			io.put_integer (new_height)
			io.put_string ("%N%TMinimum Pane = ");
			io.put_integer (pane_minimum);
			io.put_string ("%N%TMaximum Pane = ");
			io.put_integer (pane_maximum);
			io.new_line
end
			if parent.is_vertical then
				set_pane_minimum (new_width.abs)
			else
				set_pane_minimum (new_height.abs)
			end

			{FORM} Precursor (new_width.abs,new_height.abs)
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

	pane_minimum: INTEGER is
			-- Get the value of `XmNpaneMinimun'.
		do
			Result := get_xt_dimension (screen_object, XmNpaneMinimum)
		end

	pane_maximum: INTEGER is
			-- Get the value of `XmNpaneMaximum'.
		do
			Result := get_xt_dimension (screen_object, XmNpaneMaximum)
		end

end -- class SPLIT_WINDOW_CHILD_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

