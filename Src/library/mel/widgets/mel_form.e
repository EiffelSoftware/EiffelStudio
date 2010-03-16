note

	description:
			"Container widget that constrains its children."
	legal: "See notice at end of class.";
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

create 
	make, 
	make_no_auto_unmanage,
	make_from_existing

feature {NONE} -- Initialization

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN)
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

	is_form: BOOLEAN = True;
			-- Is Current a form?

feature -- Status report

	fraction_base: INTEGER
			-- The denominator part of the fraction that describes a child's
			-- relative position within Currentright
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNfractionBase)
		ensure
			fraction_base_large_enough: Result > 0
		end;

	horizontal_spacing: INTEGER
			-- The offset for right and left attachments
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNhorizontalSpacing)
		ensure
			horizontal_spacing_large_enough: Result >= 0
		end;

	vertical_spacing: INTEGER
			-- The offset for top and bottom attachments
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNverticalSpacing)
		ensure
			vertical_spacing_large_enough: Result >= 0
		end;

	is_rubber_positioning: BOOLEAN
			-- Are the child's top and left sides positioned relative to the size of Current?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNrubberPositioning)
		end;

feature  -- Status setting

	set_fraction_base (a_value: INTEGER)
			-- Set `fraction_base' to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value > 0
		do
			set_xt_int (screen_object, XmNfractionBase, a_value)
		ensure
			fraction_base_set: fraction_base = a_value
		end;

	set_horizontal_spacing (a_width: INTEGER)
			-- Set the offset for right and left attachments.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNhorizontalSpacing, a_width)
		ensure
			horizontal_spacing_set: horizontal_spacing = a_width
		end;

	set_vertical_spacing (a_height: INTEGER)
			-- Set the offset for top and bottom attachments.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNverticalSpacing, a_height)
		ensure
			vertical_spacing_set: vertical_spacing = a_height
		end;

	enable_rubber_positioning
			-- Set `is_rubber_positioning' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNrubberPositioning, True)
		ensure
			rubber_positioning_enabled: is_rubber_positioning 
		end;

	disable_rubber_positioning
			-- Set `is_rubber_positioning' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNrubberPositioning, False)
		ensure
			rubber_positioning_disabled: not is_rubber_positioning 
		end;

feature {NONE} -- External features

	xm_create_form (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/Form.h>"
		alias
			"XmCreateForm"
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_FORM


