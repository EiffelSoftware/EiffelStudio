indexing

	description:
			"Container widget that constrains its children.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FORM

inherit

	MEL_FORM_RESOURCES
		export
			{NONE} all
		end;

	MEL_BULLETIN_BOARD
		redefine
			create_widget, is_form
		end

creation 
	make, 
	make_no_auto_unmanage,
	make_from_existing

feature {NONE} -- Initialization

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN) is
			-- Create fom with `auto_manage_flag'.
		do
			if auto_manage_flag then
				screen_object :=
					xm_create_form (p_so,
						$w_name, default_pointer, 0)
			else
				screen_object :=
					xm_create_form (p_so,
						$w_name, auto_unmanage_arg, 1)
			end;
		end

feature -- Access

	is_form: BOOLEAN is True;
			-- Is Current a form?

feature -- Status report

	fraction_base: INTEGER is
			-- The denominator part of the fraction that describes a child's
			-- relative position within Currentright
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNfractionBase)
		ensure
			fraction_base_large_enough: Result > 0
		end;

	horizontal_spacing: INTEGER is
			-- The offset for right and left attachments
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNhorizontalSpacing)
		ensure
			horizontal_spacing_large_enough: Result >= 0
		end;

	vertical_spacing: INTEGER is
			-- The offset for top and bottom attachments
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNverticalSpacing)
		ensure
			vertical_spacing_large_enough: Result >= 0
		end;

	is_rubber_positioning: BOOLEAN is
			-- Are the child's top and left sides positioned relative to the size of Current?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNrubberPositioning)
		end;

feature  -- Status setting

	set_fraction_base (a_value: INTEGER) is
			-- Set `fraction_base' to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value > 0
		do
			set_xt_int (screen_object, XmNfractionBase, a_value)
		ensure
			fraction_base_set: fraction_base = a_value
		end;

	set_horizontal_spacing (a_width: INTEGER) is
			-- Set the offset for right and left attachments.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNhorizontalSpacing, a_width)
		ensure
			horizontal_spacing_set: horizontal_spacing = a_width
		end;

	set_vertical_spacing (a_height: INTEGER) is
			-- Set the offset for top and bottom attachments.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNverticalSpacing, a_height)
		ensure
			vertical_spacing_set: vertical_spacing = a_height
		end;

	enable_rubber_positioning is
			-- Set `is_rubber_positioning' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNrubberPositioning, True)
		ensure
			rubber_positioning_enabled: is_rubber_positioning 
		end;

	disable_rubber_positioning is
			-- Set `is_rubber_positioning' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNrubberPositioning, False)
		ensure
			rubber_positioning_disabled: not is_rubber_positioning 
		end;

feature {NONE} -- External features

	xm_create_form (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/Form.h>"
		alias
			"XmCreateForm"
		end;

end -- class MEL_FORM


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

