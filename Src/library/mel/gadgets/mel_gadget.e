indexing

	description: 
		"Abstract notion of a Motif Gadget.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_GADGET

inherit

	MEL_GADGET_RESOURCES
		export
			{NONE} all
		end;

	MEL_RECT_OBJ

feature -- Access

	help_command: MEL_COMMAND_EXEC is
			-- Command set for the help callback
		do
			Result := motif_command (XmNhelpCallback)
		end

feature -- Status Report

	bottom_shadow_color: MEL_PIXEL is
			-- Color used in drawing the border shadow's bottom
			-- and right sides
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixel (Current, XmNbottomShadowColor)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	top_shadow_color: MEL_PIXEL is
			-- Color used in drawing the border shadow's top
			-- and left sides
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixel (Current, XmNtopShadowColor)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	highlight_color: MEL_PIXEL is
			-- Color used in drawing the highlighting rectangle
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixel (Current, XmNhighlightColor)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	is_highlighted_on_entry: BOOLEAN is
			-- Will the rectangle around the widget's be highlighted
			-- when the cursor moves over it?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNhighlightOnEnter)
		end;

	highlight_thickness: INTEGER is
			-- Thickness of the highlighting rectangle.
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNhighlightThickness)
		ensure
			highlight_thickness_large_enough: Result >= 0
		end;

	shadow_thickness: INTEGER is
			-- Thickness of the shadow border
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNshadowThickness)
		ensure
			shadow_thickness_large_enough: Result >= 0
		end;

	is_traversable: BOOLEAN is
			-- Is it possible to traverse the widget?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNtraversalOn)
		end;

	is_unit_pixel: BOOLEAN is
			-- Is the measurement unit of the widget in pixel?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNunitType) = XmPIXELS
		end;

	is_unit_100th_millimeter: BOOLEAN is
			-- Is the measurement unit of the widget the 100th of millimeter ?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNunitType) = Xm100TH_MILLIMETERS
		end;

	 is_unit_1000th_inch: BOOLEAN is
			-- Is the measurement unit of the widget the 1000th of inch ?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNunitType) = Xm1000TH_INCHES
		end;

	is_unit_100th_point: BOOLEAN is
			-- Is the measurement unit of the widget the 100th of point ?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNunitType) = Xm100TH_POINTS
		end;

	is_unit_100th_font_unit: BOOLEAN is
			-- Is the measurement unit of the widget the 100th of font unit ?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNunitType) = Xm100TH_FONT_UNITS
		end;

	is_navigation_none: BOOLEAN is
			-- Is traversal excluding keyboard navigation?
		require
			exists: not is_destroyed
		do
			Result := navigation_type = XmNONE
		end;

	is_navigation_tab_group: BOOLEAN is
			-- Is traversal including keyboard navigation?
		require
			exists: not is_destroyed
		do
			Result := navigation_type = XmTAB_GROUP
		end;

	is_navigation_sticky_tab_group: BOOLEAN is
			-- Is traversal including keyboard navigation
			-- even if `XmAddTabGroup()' was called?
		require
			exists: not is_destroyed
		do
			Result := navigation_type = XmSTICKY_TAB_GROUP
		end;

	is_navigation_exclusive_tab_gourp: BOOLEAN is
			-- Is traversal defined by the application?
		require
			exists: not is_destroyed
		do
			Result := navigation_type = XmEXCLUSIVE_TAB_GROUP
		end;

feature  -- Status setting

	set_bottom_shadow_color (a_color: MEL_PIXEL) is
			-- Set `bottom_shadow_color' to a `a_color'.
		require
			exists: not is_destroyed;
			valid_color: a_color /= Void and then a_color.is_valid;
			same_display: a_color.same_display (display)
		do
			set_xt_pixel (screen_object, XmNbottomShadowColor, a_color)
		ensure
			bottom_shadow_color_set: bottom_shadow_color.is_equal (a_color)
		end;

	set_top_shadow_color (a_color: MEL_PIXEL) is
			-- Set `top_shadow_color' to a `a_color'.
		require
			exists: not is_destroyed;
			valid_color: a_color /= Void and then a_color.is_valid;
			same_display: a_color.same_display (display)
		do
			set_xt_pixel (screen_object, XmNtopShadowColor, a_color)
		ensure
			top_shadow_color_set: top_shadow_color.is_equal (a_color)
		end;

	set_highlight_color (a_color: MEL_PIXEL) is
			-- Set `highlight_color' to a `a_color'.
		require
			exists: not is_destroyed;
			valid_color: a_color /= Void and then a_color.is_valid;
			same_display: a_color.same_display (display)
		do
			set_xt_pixel (screen_object, XmNhighlightColor, a_color)
		ensure
			highlight_color_set: highlight_color.is_equal (a_color)
		end;

	set_highlight_on_entry is
			-- Highlight widget on entry.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNhighlightOnEnter, True)
		ensure
			is_highlighted_on_entry: is_highlighted_on_entry 
		end;

	set_no_highlight_on_entry is
			-- Do not highlight widget on entry.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNhighlightOnEnter, False)
		ensure
			is_not_highlighted_on_enter: not is_highlighted_on_entry
		end;

	set_highlight_thickness (a_thickness: INTEGER) is
			-- Set `highlight_thickness' to `a_thickness'.
		require
			exists: not is_destroyed;
			a_thickness_large_enough: a_thickness >= 0
		do
			set_xt_dimension (screen_object, XmNhighlightThickness, a_thickness)
		ensure
			highlight_thickness_set: highlight_thickness = a_thickness
		end;

	set_shadow_thickness (a_thickness: INTEGER) is
			-- Set `shadow_thickness' to `a_thickness'.
		require
			exists: not is_destroyed;
			a_thickness_large_enough: a_thickness >= 0
		do
			set_xt_dimension (screen_object, XmNshadowThickness, a_thickness)
		ensure
			shadow_thickness_set: shadow_thickness = a_thickness
		end;

	enable_traversal is
			-- Enable the traversal of this widget.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNtraversalOn, True)
		ensure
			traversal_enabled: is_traversable
		end;

	disable_traversal is
			-- Disable the traversal of this widget.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNtraversalOn, False)
		ensure
			traversal_disbled: not is_traversable
		end;

	set_unit_pixel is
			-- Set the measurement unit of the widget to pixel.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNunitType, XmPIXELS)
		ensure
			unit_pixel_set: is_unit_pixel
		end;

	set_unit_100th_millimeter is
			-- Set the measurement unit of the widget to 100th of millimeter.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNunitType, Xm100TH_MILLIMETERS)
		ensure
			unit_100th_millimeter_set: is_unit_100th_millimeter
		end;

	set_unit_1000th_inch is
			-- Set the measurement unit of the widget to the 1000th of inch.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNunitType, Xm1000TH_INCHES)
		ensure
			unit_1000th_inch_set: is_unit_1000th_inch
		end;

	set_unit_100th_point is
			-- Set the measurement unit of the widget to the 100th of point.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNunitType, Xm100TH_POINTS)
		ensure
			unit_100th_point_set: is_unit_100th_point
		end;

	set_unit_100th_font_unit is
			-- Set the measurement unit of the widget to the 100th of font unit.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNunitType, Xm100TH_FONT_UNITS)
		ensure
			unit_100th_font_unit_set: is_unit_100th_font_unit
		end;

	set_navigation_to_none is
			-- Set the navigation type to `XmNONE'.
		do
			set_xt_unsigned_char (screen_object, XmNnavigationType, XmNONE)
		ensure
			is_navigation_none: is_navigation_none
		end;

	set_navigation_to_tab_group is
			-- Set the navigation type to `XmTAB_GROUP'.
		do
			set_xt_unsigned_char (screen_object, XmNnavigationType, XmTAB_GROUP)
		ensure
			is_navigation_tab_group: is_navigation_tab_group
		end;

	set_navigation_to_sticky_tab_group is
			-- Set the navigation type to `XmSTICKY_TAB_GROUP'.
		do
			set_xt_unsigned_char (screen_object, XmNnavigationType, XmSTICKY_TAB_GROUP)
		ensure
			is_navigation_sticky_tab_group: is_navigation_sticky_tab_group
		end;

	set_navigation_to_exclusive_tab_group is
			-- Set the navigation type to `XmEXCLUSIVE_TAB_GROUP'.
		do
			set_xt_unsigned_char (screen_object, XmNnavigationType, XmEXCLUSIVE_TAB_GROUP)
		ensure
			is_navigation_exclusive_tab_gourp: is_navigation_exclusive_tab_gourp
		end;

feature -- Element change

	set_help_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when help is requested.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void;
		do
			set_callback (XmNhelpCallback, a_command, an_argument);
		ensure
			command_set: command_set (help_command, a_command, an_argument)
		end;

feature -- Removal

	remove_help_callback is
			-- Remove command for the help callback.
		do
			remove_callback (XmNhelpCallback)
		ensure
			removed: help_command = Void
		end;

feature -- Miscellaneous

	update_colors_from (a_color: MEL_PIXEL) is
			-- Update the colors (top_shadow, bottom_shadow,
			-- select_color ...) if necessary using `a_color'.
		require
			exists: not is_destroyed;
			non_void_a_color: a_color /= Void
		do
			xm_change_color (screen_object, a_color.identifier);
		end;

feature {NONE} -- Implementation

	navigation_type: INTEGER is
			-- Determines the way in widget are to be
			-- traversed during keyboard navigation
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNnavigationType)
		end;

end -- class MEL_GADGET


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

