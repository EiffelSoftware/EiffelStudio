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
			create_widget
		end

creation 
	make, 
	make_no_auto_unmanage

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
			Mel_widgets.put (Current, screen_object)
		end

feature -- Access

	top_widget (a_widget: MEL_RECT_OBJ): MEL_RECT_OBJ is
			-- Widget that serves as the attachment point for the top of `a_widget'
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result ?= get_xt_widget (a_widget.screen_object, XmNtopWidget)
		end;

	bottom_widget (a_widget: MEL_RECT_OBJ): MEL_RECT_OBJ is
			-- Widget that serves as the attachment point for the bottom of `a_widget'
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result ?= get_xt_widget (a_widget.screen_object, XmNbottomWidget)
		end;

	left_widget (a_widget: MEL_RECT_OBJ): MEL_RECT_OBJ is
			-- Widget that serves as the attachment point for the left of `a_widget'
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result ?= get_xt_widget (a_widget.screen_object, XmNleftWidget)
		end;

	right_widget (a_widget: MEL_RECT_OBJ): MEL_RECT_OBJ is
			-- Widget that serves as the attachment point for the right of `a_widget'
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result ?= get_xt_widget (a_widget.screen_object, XmNrightWidget)
		end;

	is_top_attached (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the top side of `a_widget' attached to the top side of the form? 
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment) = XmATTACH_FORM
		end;

	is_bottom_attached (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the bottom side of `a_widget' attached to the bottom side of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment) = XmATTACH_FORM
		end;

	is_left_attached (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the left side of `a_widget' attached to the left side of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment) = XmATTACH_FORM
		end;

	is_right_attached (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the right side of `a_widget' attached to the right side of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment) = XmATTACH_FORM
		end;

	is_top_attached_to_opposite (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the top side of `a_widget' attached to the bottom side of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment) = XmATTACH_OPPOSITE_FORM
		end;

	is_bottom_attached_to_opposite (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the bottom side of `a_widget' attached to the top side of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment) = XmATTACH_OPPOSITE_FORM
		end;

	is_left_attached_to_opposite (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the left side of `a_widget' attached to the right side of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char 
					(a_widget.screen_object, XmNleftAttachment) = XmATTACH_OPPOSITE_FORM
		end;

	is_right_attached_to_opposite (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the right side of `a_widget' attached to the left side of Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment) = XmATTACH_OPPOSITE_FORM
		end;

	is_top_not_attached (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the top side of `a_widget' not attached?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment) = XmATTACH_NONE
		end;

	is_bottom_not_attached (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the bottom side of `a_widget' not attached?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment) = XmATTACH_NONE
		end;

	is_left_not_attached (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the left side of `a_widget' not attached?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment) = XmATTACH_NONE
		end;

	is_right_not_attached (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the right side of `a_widget' not attached?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment) = XmATTACH_NONE
		end;

	is_top_attached_to_widget (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is  the top side of `a_widget' attached to the bottom side of a widget?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment) = XmATTACH_WIDGET
		end;

	is_bottom_attached_to_widget (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is  the bottom side of `a_widget' attached to the top side of a widget?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment) = XmATTACH_WIDGET
		end;

	is_left_attached_to_widget (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is  the left side of `a_widget' attached to the right side of a widget?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment) = XmATTACH_WIDGET
		end;

	is_right_attached_to_widget (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is  the right side of `a_widget' attached to the left side of a widget?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment) = XmATTACH_WIDGET
		end;

	is_top_attached_to_opposite_widget (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the top side of `a_widget' attached to the top side of a widget?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment) = XmATTACH_OPPOSITE_WIDGET
		end;

	is_bottom_attached_to_opposite_widget (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the bottom side of `a_widget' attached to the bottom side of a widget?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment) = XmATTACH_OPPOSITE_WIDGET
		end;

	is_left_attached_to_opposite_widget (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the left side of `a_widget' attached to the left side of a widget?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment) = XmATTACH_OPPOSITE_WIDGET
		end;

	is_right_attached_to_opposite_widget (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the right side of `a_widget' attached to the right side of a widget?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment) = XmATTACH_OPPOSITE_WIDGET
		end;

	is_top_attached_to_itself (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the top side of `a_widget' attached to itself?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment) = XmATTACH_SELF
		end;

	is_bottom_attached_to_itself (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the bottom side of `a_widget' attached to itself?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment) = XmATTACH_SELF
		end;

	is_left_attached_to_itself (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the left side of `a_widget' attached to itself?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment) = XmATTACH_SELF
		end;

	is_right_attached_to_itself (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the right side of `a_widget' attached to itself?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment) = XmATTACH_SELF
		end;

	is_top_attached_to_position (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the top side of `a_widget' attached to a position in Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment) = XmATTACH_POSITION
		end;

	is_bottom_attached_to_position (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the bottom side of `a_widget' attached to a position in Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment) = XmATTACH_POSITION
		end;

	is_left_attached_to_position (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the left side of `a_widget' attached to a position in Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment) = XmATTACH_POSITION
		end;

	is_right_attached_to_position (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is the right side of `a_widget' attached to a position in Current?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment) = XmATTACH_POSITION
		end;

	top_offset (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Distance between `a_widget' its top side and the object it is
			-- attached to
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_int (a_widget.screen_object, XmNtopOffset)
		end;

	bottom_offset (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Distance between `a_widget' its bottom side and the object it is
			-- attached to
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_int (a_widget.screen_object, XmNbottomOffset)
		end;

	left_offset (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Distance between `a_widget' its left side and the object it is
			-- attached to
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_int (a_widget.screen_object, XmNleftOffset)
		end;

	right_offset (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Distance between `a_widget' its right side and the object it is
			-- attached to
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_int (a_widget.screen_object, XmNrightOffset)
		end;

	widget_top_position (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Used in conjunction with `fraction' to calculate the position of
			-- the top of `a_widget'
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_int (a_widget.screen_object, XmNtopPosition)
		ensure
			top_position_large_enough: Result >= 0;
			top_position_small_enough: Result <= fraction_base
		end;

	widget_bottom_position (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Used in conjunction with `fraction_base' to calculate the position
			-- of the bottom of a child
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_int (a_widget.screen_object, XmNbottomPosition)
		ensure
			bottom_position_large_enough: Result >= 0;
			bottom_position_small_enough: Result <= fraction_base
		end;

	widget_left_position (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Used in conjunction with `fraction' to calculate the position of
			-- the left side of `a_widget'
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_int (a_widget.screen_object, XmNleftPosition)
		ensure
			left_position_large_enough: Result >= 0;
			left_position_small_enough: Result <= fraction_base
		end;

	widget_right_position (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Used in conjunction with `fraction' to calculate the position of
			-- the right side of `a_widget'
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_int (a_widget.screen_object, XmNrightPosition)
		ensure
			right_position_large_enough: Result >= 0;
			right_position_small_enough: Result <= fraction_base
		end;

feature  -- Status report

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

	set_rubber_positioning (b: BOOLEAN) is
			-- Set `is_rubber_positioning' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNrubberPositioning, b)
		ensure
			rubber_positioning_enabled: is_rubber_positioning = b
		end;

	set_top_offset (a_widget: MEL_RECT_OBJ; an_offset: INTEGER) is
			-- Set the distance between `a_widget' its top side and the object it is
			-- attached to to `an_offset'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_int (a_widget.screen_object, XmNtopOffset, an_offset)
		ensure
			top_offset_set: top_offset (a_widget) = an_offset
		end;

	set_bottom_offset (a_widget: MEL_RECT_OBJ; an_offset: INTEGER) is
			-- Set the distance between the `a_widget' its bottom side and the object it is
			-- attached to to `an_offset'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_int (a_widget.screen_object, XmNbottomOffset, an_offset)
		ensure
			bottom_offset_set: bottom_offset (a_widget) = an_offset
		end;

	set_left_offset (a_widget: MEL_RECT_OBJ; an_offset: INTEGER) is
			-- Set the distance between the `a_widget' its left side and the object it's
			-- attached to to `an_offset'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_int (a_widget.screen_object, XmNleftOffset, an_offset)
		ensure
			left_offset_set: left_offset (a_widget) = an_offset
		end;

	set_right_offset (a_widget: MEL_RECT_OBJ; an_offset: INTEGER) is
			-- Set the distance between the `a_widget' its right side and the object it's
			-- attached to to `an_offset'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_int (a_widget.screen_object, XmNrightOffset, an_offset)
		ensure
			right_offset_set: right_offset (a_widget) = an_offset
		end;

	set_widget_top_position (a_widget: MEL_RECT_OBJ; a_position: INTEGER) is
			-- Set the position of the top of `a_widget' to `a_position'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		do
			set_xt_int (a_widget.screen_object, XmNtopPosition, a_position)
		ensure
			widget_top_position_is_set: widget_top_position (a_widget) = a_position
		end;

	set_widget_bottom_position (a_widget: MEL_RECT_OBJ; a_position: INTEGER) is
			-- Set the position of the bottom of `a_widget' to `a_position'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		do
			set_xt_int (a_widget.screen_object, XmNbottomPosition, a_position)
		ensure
			widget_bottom_position_is_set: widget_bottom_position (a_widget) = a_position
		end;

	set_widget_left_position (a_widget: MEL_RECT_OBJ; a_position: INTEGER) is
			-- Set the position of the left of `a_widget' to `a_position'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		do
			set_xt_int (a_widget.screen_object, XmNleftPosition, a_position)
		ensure
			widget_left_position_is_set: widget_left_position (a_widget) = a_position
		end;

	set_widget_right_position (a_widget: MEL_RECT_OBJ; a_position: INTEGER) is
			-- Set the position of the right of `a_widget' to `a_position'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		do
			set_xt_int (a_widget.screen_object, XmNrightPosition, a_position)
		ensure
			widget_right_position_is_set: widget_right_position (a_widget) = a_position
		end;

feature -- Miscellaneous

	child_resizable (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is `a_widget' resizable?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			Result := get_xt_boolean (a_widget.screen_object, XmNresizable)
		end;

	enable_resize_requests (a_widget: MEL_RECT_OBJ; b: BOOLEAN) is
			-- Set acceptance of resize requests from `a_widget' to `b'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_boolean (a_widget.screen_object, XmNresizable, b)
		ensure
			child_allowed_to_resize: child_resizable (a_widget) = b
		end;

	attach_top (a_widget: MEL_RECT_OBJ) is
			-- Attach the top side of `a_widget' to the top side of the form.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment, XmATTACH_FORM)
		ensure
			widget_top_is_attached_to_form: is_top_attached (a_widget)
		end;

	attach_top_to_opposite (a_widget: MEL_RECT_OBJ) is
			-- Attach the top side of `a_widget' to the bottom side of the form.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment, XmATTACH_OPPOSITE_FORM)
		ensure
			widget_top_is_attached_to_opposite_form: is_top_attached_to_opposite (a_widget)
		end;

	attach_top_to_widget (a_widget, a_target: MEL_RECT_OBJ) is
			-- Attach the top side of `a_widget' to the bottom side of the widget `a_target'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_target_is_a_child: a_target /= Void and then
									not a_target.is_destroyed and then
									a_target.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment, XmATTACH_WIDGET);
			set_xt_widget (a_widget.screen_object, XmNtopWidget, a_target.screen_object)
		ensure
			widget_top_is_attached_to_widget: is_top_attached_to_widget (a_widget);
			target_set: top_widget (a_widget) =  a_target
		end;

	attach_top_to_opposite_widget (a_widget, a_target: MEL_RECT_OBJ) is
			-- Attach the top side of `a_widget' to the top side of a widget.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_target_is_a_child: a_target /= Void and then
									not a_target.is_destroyed and then
									a_target.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment, XmATTACH_OPPOSITE_WIDGET);
			set_xt_widget (a_widget.screen_object, XmNtopWidget, a_target.screen_object)
		ensure
			widget_top_is_attached_to_opposite_widget: is_top_attached_to_opposite_widget (a_widget);
			target_set: top_widget (a_widget) = a_target
		end;

	attach_top_to_itself (a_widget: MEL_RECT_OBJ) is
			-- Attach the top side of `a_widget' to itself.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment, XmATTACH_SELF)
		ensure
			widget_top_is_attached_to_itself: is_top_attached_to_itself (a_widget)
		end;

	attach_top_to_position (a_widget: MEL_RECT_OBJ; a_position: INTEGER) is
			-- Attach the top side of `a_widget' to a position in the form.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment, XmATTACH_POSITION);
			set_xt_int (a_widget.screen_object, XmNtopPosition, a_position)
		ensure
			widget_top_is_attached_to_position: is_top_attached_to_position (a_widget);
			widget_top_position_is_set: widget_top_position (a_widget) = a_position
		end;

	detach_top (a_widget: MEL_RECT_OBJ) is
			-- Detach the top side of `a_widget'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNtopAttachment, XmATTACH_NONE)
		ensure
			top_is_detached: is_top_not_attached (a_widget)
		end;

	attach_bottom (a_widget: MEL_RECT_OBJ) is
			-- Attach the bottom side of `a_widget' to the bottom side of the form.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment, XmATTACH_FORM)
		ensure
			widget_bottom_is_attached_to_form: is_bottom_attached (a_widget)
		end;

	attach_bottom_to_opposite (a_widget: MEL_RECT_OBJ) is
			-- Attach the bottom side of `a_widget' to the top side of the form.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment, XmATTACH_OPPOSITE_FORM)
		ensure
			widget_bottom_is_attached_to_opposite_form: is_bottom_attached_to_opposite (a_widget)
		end;

	attach_bottom_to_widget (a_widget, a_target: MEL_RECT_OBJ) is
			-- Attach the bottom side of `a_widget' to the top side of the widget `a_target'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_target_is_a_child: a_target /= Void and then
									not a_target.is_destroyed and then
									a_target.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment, XmATTACH_WIDGET);
			set_xt_widget (a_widget.screen_object, XmNbottomWidget, a_target.screen_object)
		ensure
			widget_bottom_is_attached_to_widget: is_bottom_attached_to_widget (a_widget);
			target_set: bottom_widget (a_widget) =  a_target
		end;

	attach_bottom_to_opposite_widget (a_widget, a_target: MEL_RECT_OBJ) is
			-- Attach the bottom side of `a_target' to the bottom side of `a_widget'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_target_is_a_child: a_target /= Void and then
									not a_target.is_destroyed and then
									a_target.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment, XmATTACH_OPPOSITE_WIDGET);
			set_xt_widget (a_widget.screen_object, XmNbottomWidget, a_target.screen_object)
		ensure
			widget_bottom_is_attached_to_opposite_widget: is_bottom_attached_to_opposite_widget (a_widget);
			target_set: bottom_widget (a_widget) =  a_target
		end;

	attach_bottom_to_itself (a_widget: MEL_RECT_OBJ) is
			-- Attach the bottom side of `a_widget' to itself.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment, XmATTACH_SELF)
		ensure
			widget_bottom_is_attached_to_itself: is_bottom_attached_to_itself (a_widget)
		end;

	attach_bottom_to_position (a_widget: MEL_RECT_OBJ; a_position: INTEGER) is
			-- Attach the bottom side of `a_widget' to `a_position' in the form.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment, XmATTACH_POSITION);
			set_xt_int (a_widget.screen_object, XmNbottomPosition, a_position)
		ensure
			widget_bottom_is_attached_to_position: is_bottom_attached_to_position (a_widget);
			widget_bottom_position_is_set: widget_bottom_position (a_widget) = a_position
		end;

	detach_bottom (a_widget: MEL_RECT_OBJ) is
			-- Detach the bottom side of `a_widget'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNbottomAttachment, XmATTACH_NONE)
		ensure
			bottom_is_detached: is_bottom_not_attached (a_widget)
		end;

	attach_left (a_widget: MEL_RECT_OBJ) is
			-- Attach the left side of `a_widget' to the left side of the form.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment, XmATTACH_FORM)
		ensure
			widget_left_is_attached_to_form: is_left_attached (a_widget)
		end;

	attach_left_to_opposite (a_widget: MEL_RECT_OBJ) is
			-- Attach the left side of `a_widget' to the left side of the form.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment, XmATTACH_OPPOSITE_FORM)
		ensure
			widget_left_is_attached_to_opposite_form: is_left_attached_to_opposite (a_widget)
		end;

	attach_left_to_widget (a_widget, a_target: MEL_RECT_OBJ) is
			-- Attach the left side of `a_widget' to the left side of `a_target'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_target_is_a_child: a_target /= Void and then
									not a_target.is_destroyed and then
									a_target.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment, XmATTACH_WIDGET);
			set_xt_widget (a_widget.screen_object, XmNleftWidget, a_target.screen_object)
		ensure
			widget_left_is_attached_to_widget: is_left_attached_to_widget (a_widget);
			target_set: left_widget (a_widget) =  a_target
		end;

	attach_left_to_opposite_widget (a_widget, a_target: MEL_RECT_OBJ) is
			-- Attach the left side of `a_target' to the left side of `a_widget'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_target_is_a_child: a_target /= Void and then
									not a_target.is_destroyed and then
									a_target.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment, XmATTACH_OPPOSITE_WIDGET);
			set_xt_widget (a_widget.screen_object, XmNleftWidget, a_target.screen_object)
		ensure
			widget_left_is_attached_to_opposite_widget: is_left_attached_to_opposite_widget (a_widget);
			target_set: left_widget (a_widget) =  a_target
		end;

	attach_left_to_itself (a_widget: MEL_RECT_OBJ) is
			-- Attach the left side of `a_widget' to itself.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment, XmATTACH_SELF)
		ensure
			widget_left_is_attached_to_itself: is_left_attached_to_itself (a_widget)
		end;

	attach_left_to_position (a_widget: MEL_RECT_OBJ; a_position: INTEGER) is
			-- Attach the left side of `a_widget' to `a_position' in the form.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment, XmATTACH_POSITION);
			set_xt_int (a_widget.screen_object, XmNleftPosition, a_position)
		ensure
			widget_left_is_attached_to_position: is_left_attached_to_position (a_widget);
			widget_left_position_is_set: widget_left_position (a_widget) = a_position
		end;

	detach_left (a_widget: MEL_RECT_OBJ) is
			-- Detach the left side of `a_widget'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNleftAttachment, XmATTACH_NONE)
		ensure
			left_is_detached: is_left_not_attached (a_widget)
		end;

	attach_right (a_widget: MEL_RECT_OBJ) is
			-- Attach the right side of `a_widget' to the right side of the form.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment, XmATTACH_FORM)
		ensure
			widget_right_is_attached_to_form: is_right_attached (a_widget)
		end;

	attach_right_to_opposite (a_widget: MEL_RECT_OBJ) is
			-- Attach the right side of `a_widget' to the right side of the form.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment, XmATTACH_OPPOSITE_FORM)
		ensure
			widget_right_is_attached_to_opposite_form: is_right_attached_to_opposite (a_widget)
		end;

	attach_right_to_widget (a_widget, a_target: MEL_RECT_OBJ) is
			-- Attach the right side of `a_widget' to the left side of `a_target'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_target_is_a_child: a_target /= Void and then
									not a_target.is_destroyed and then
									a_target.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment, XmATTACH_WIDGET);
			set_xt_widget (a_widget.screen_object, XmNrightWidget, a_target.screen_object)
		ensure
			widget_right_is_attached_to_widget: is_right_attached_to_widget (a_widget);
			target_set: right_widget (a_widget) =  a_target
		end;

	attach_right_to_opposite_widget (a_widget, a_target: MEL_RECT_OBJ) is
			-- Attach the right side of `a_target' to the right side of `a_widget'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_target_is_a_child: a_target /= Void and then
									not a_target.is_destroyed and then
									a_target.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment, XmATTACH_OPPOSITE_WIDGET);
			set_xt_widget (a_widget.screen_object, XmNrightWidget, a_target.screen_object)
		ensure
			widget_right_is_attached_to_opposite_widget: is_right_attached_to_opposite_widget (a_widget);
			target_set: right_widget (a_widget) =  a_target
		end;

	attach_right_to_itself (a_widget: MEL_RECT_OBJ) is
			-- Attach the right side of `a_widget' to itself.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment, XmATTACH_SELF)
		ensure
			widget_right_is_attached_to_itself: is_right_attached_to_itself (a_widget)
		end;

	attach_right_to_position (a_widget: MEL_RECT_OBJ; a_position: INTEGER) is
			-- Attach the right side of `a_widget' to `a_position' in the form.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= fraction_base
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment, XmATTACH_POSITION);
			set_xt_int (a_widget.screen_object, XmNrightPosition, a_position)
		ensure
			widget_right_is_attached_to_position: is_right_attached_to_position (a_widget);
			widget_right_position_is_set: widget_right_position (a_widget) = a_position
		end;

	detach_right (a_widget: MEL_RECT_OBJ) is
			-- Detach the right side of `a_widget'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
									not a_widget.is_destroyed and then
									a_widget.parent = Current
		do
			set_xt_unsigned_char (a_widget.screen_object, XmNrightAttachment, XmATTACH_NONE)
		ensure
			right_is_detached: is_right_not_attached (a_widget)
		end;

feature {NONE} -- Implementation

	xm_create_form (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/Form.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateForm"
		end;

end -- class MEL_FORM

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
