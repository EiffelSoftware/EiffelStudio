indexing

	description:
			"Constraint widget that tiles its children vertically.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PANED_WINDOW

inherit

	MEL_PANED_WINDOW_RESOURCES
		export
			{NONE} all
		end;

	MEL_MANAGER

creation 
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif paned window widget.
		require
			a_name_exists: a_name /= Void
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_paned_window (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.put (Current, screen_object);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed
		end;

feature -- Status report

	margin_height: INTEGER is
			-- Spacing between the top or the bottom of Current's children
			-- and Current's shadow
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginHeight)
		ensure
			margin_height_large_enough: Result >= 0
		end;

	margin_width: INTEGER is
			-- Spacing between the left or right of Current's children
			-- and Current's shadow
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginWidth)
		ensure
			margin_width_large_enough: Result >= 0
		end;

	is_refigure_mode: BOOLEAN is
			-- Are the children set to their appropriate position after
			-- a change in Current?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNrefigureMode)
		end;

	sash_height: INTEGER is
			-- Height of the sash
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNsashHeight)
		ensure
			sash_heighth_large_enough: Result >= 0
		end;

	sash_width: INTEGER is
			-- Width of the sash
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNsashWidth)
		ensure
			sash_width_large_enough: Result >= 0
		end;

	sash_indent: INTEGER is
			-- Horizontal position of the sash along each pane
		require
			exists: not is_destroyed
		do
			Result := get_xt_position (screen_object, XmNsashIndent)
		end;

	sash_shadow_thickness: INTEGER is
			-- The thickness of the shadow drawn on each sash
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNsashShadowThickness)
		ensure
			sash_shadow_thickness_large_enough: Result >= 0
		end;

	is_separator_on: BOOLEAN is
			-- Is a separator (gadget) placed between each pane
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNseparatorOn)
		end;

	spacing: INTEGER is
			-- The distance between each pane child
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNspacing)
		ensure
			spacing_large_enough: Result >= 0
		end;

feature -- Status setting

	set_margin_height (a_height: INTEGER) is
			-- Set `margin_height' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNmarginHeight, a_height)
		ensure
			margin_height_set: margin_height = a_height
		end;

	set_margin_width (a_width: INTEGER) is
			-- Set `margin_width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNmarginWidth, a_width)
		ensure
			margin_width_set: margin_width = a_width
		end;

	set_refigure_mode (b: BOOLEAN) is
			-- Set `refigure_mode' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNrefigureMode, b)
		ensure
			refigure_mode_enabled: is_refigure_mode = b
		end;

	set_sash_height (a_height: INTEGER) is
			-- Set `sash_height' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNsashHeight, a_height)
		ensure
			sash_height_set: sash_height = a_height
		end;

	set_sash_width (a_width: INTEGER) is
			-- Set `sash_width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNsashWidth, a_width)
		ensure
			sash_width_set: sash_width = a_width
		end;

	set_sash_indent (a_position: INTEGER) is
			-- Set `sash_indent' to `a_position'.
		require
			exists: not is_destroyed
		do
			set_xt_position (screen_object, XmNsashIndent, a_position)
		ensure
			sash_indent_set: sash_indent = a_position
		end;

	set_sash_shadow_thickness (a_thickness: INTEGER) is
			-- Set `sash_shadow_thickness' to `a_thickness'.
		require
			exists: not is_destroyed;
			a_thickness_large_enough: a_thickness >= 0
		do
			set_xt_dimension (screen_object, XmNsashShadowThickness, a_thickness)
		ensure
			sash_shadow_thickness_set: sash_shadow_thickness = a_thickness
		end;

	set_separator (b: BOOLEAN) is
			-- Set `separator_on' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNseparatorOn, b)
		ensure
			separator_enabled: is_separator_on = b
		end;

	set_spacing (a_distance: INTEGER) is
			-- Set `spacing' to `a_distance'.
		require
			exists: not is_destroyed;
			a_distance_large_enough: a_distance >= 0 
		do
			set_xt_dimension (screen_object, XmNspacing, a_distance)
		ensure
			spacing_set: spacing = a_distance
		end;

feature -- Miscellaneous

	is_widget_allowed_to_resize (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is `a_widget' allowed to resize ?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			Result := get_xt_boolean (a_widget.screen_object, XmNallowResize)
		end;

	set_widget_allowed_to_resize (a_widget: MEL_RECT_OBJ; b: BOOLEAN) is
			-- Set `is_widget_allowed_to_resize' to `b'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			set_xt_boolean (a_widget.screen_object, XmNallowResize, b)
		ensure
			widget_allowed_to_resize: is_widget_allowed_to_resize (a_widget)
		end;

	widget_pane_minimum (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Minimal dimensions for resizing of `a_widget'
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			Result := get_xt_dimension (a_widget.screen_object, XmNpaneMinimum)
		ensure
			pane_minimum_large_enough: Result >= 0
		end;

	set_widget_pane_minimum (a_widget: MEL_RECT_OBJ; a_dimension: INTEGER) is
			-- Set `widget_pane_minimum' of `a_widget' to `a_dimension'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_dimension_large_enough: a_dimension >= 0;
			a_dimension_smaller_than_maximum: a_dimension <= widget_pane_maximum (a_widget)
		do
			set_xt_dimension (a_widget.screen_object, XmNpaneMinimum, a_dimension)
		ensure
			pane_minimum_set: widget_pane_minimum (a_widget) = a_dimension
		end;

	widget_pane_maximum (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Maximal dimensions for resizing of `a_widget'
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			Result := get_xt_dimension (a_widget.screen_object, XmNpaneMAximum)
		ensure
			pane_maximum_large_enough: Result >= 0
		end;

	set_widget_pane_maximum (a_widget: MEL_RECT_OBJ; a_dimension: INTEGER) is
			-- Set `widget_pane_maximum' of `a_widget' to `a_dimension'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_dimension_large_enough: a_dimension >= 0;
			a_dimension_greater_than_minimum: a_dimension >= widget_pane_minimum (a_widget)
		do
			set_xt_dimension (a_widget.screen_object, XmNpaneMaximum, a_dimension)
		ensure
			pane_maximum_set: widget_pane_maximum (a_widget) = a_dimension
		end;

	widget_position (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Position of `a_widget' in the RowColumn's list of children
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
		do
			Result := get_xt_short (a_widget.screen_object, XmNpositionIndex)
		ensure
			position_large_enough: Result >=0;
			position_small_enough: Result < children_count
		end;

	set_widget_position (a_widget: MEL_RECT_OBJ; a_position: INTEGER) is
			-- Set `widget_position' of `a_widget' to `a_position'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position < children_count
		do
			set_xt_short (a_widget.screen_object, XmNpositionIndex, a_position)
		ensure
			position_set: widget_position (a_widget) = a_position;
		end;

	set_widget_at_last_position (a_widget: MEL_RECT_OBJ) is
			-- Set the position of `a_widget' in the RowColumn's list
			-- to the last position.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
		do
			set_xt_short (a_widget.screen_object, XmNpositionIndex, XmLAST_POSITION)
		ensure
			is_at_the_end: widget_position (a_widget) = children_count
		end;

	is_automatic_adjustment (a_widget: MEL_RECT_OBJ): BOOLEAN is
			-- Is `a_widget' automatically resized ?
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			Result := not get_xt_boolean (a_widget.screen_object, XmNskipAdjust)
		end;

	set_automatic_adjustment (a_widget: MEL_RECT_OBJ; b: BOOLEAN) is
			-- Set `is_automatic_adjustment' for `a_widget' to `b'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			set_xt_boolean (a_widget.screen_object, XmNskipAdjust, not b)
		ensure
			widget_is_automatically_resized: is_automatic_adjustment (a_widget) = b
		end;

feature {NONE} -- Implementation

	xm_create_paned_window (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/PanedW.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreatePanedWindow"
		end;

end -- class MEL_PANED_WINDOW

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
