indexing

	description:
			"Fundamental class for simple Motif widgets.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PRIMITIVE

inherit

	MEL_PRIMITIVE_RESOURCES;

	MEL_WIDGET

feature -- Access

	help_command: MEL_COMMAND_EXEC is
			-- Command set for the help callback
		do
			Result := motif_command (XmNhelpCallback)
		end

feature -- Status report

	bottom_shadow_color: MEL_PIXEL is
			-- Color used for drawing the border shadow's bottom
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
			-- Color used for drawing the border shadow's top
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

	bottom_shadow_pixmap: MEL_PIXMAP is
			-- Pixmap used in drawing the border shadow's bottom
			-- and right sides
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNbottomShadowPixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	top_shadow_pixmap: MEL_PIXMAP is
			-- Pixmap used in drawing the border shadow's top
			-- and left sides
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNtopShadowPixmap);
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	foreground, foreground_color: MEL_PIXEL is
			-- The foreground color used by descendants of Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixel (Current, XmNforeground)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	highlight_color: MEL_PIXEL is
			-- Color used for drawing the highlighting rectangle
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixel (Current, XmNhighlightColor)
		ensure
			valid_result: Result /= Void and then Result.is_valid
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	is_highlighted_on_entry: BOOLEAN is
			-- Is Current highlighted when it gets the focus?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNhighlightOnEnter)
		end;

	highlight_pixmap: MEL_PIXMAP is
			-- Pixmap used in drawing the highlight rectangle
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNhighlightPixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	highlight_thickness: INTEGER is
			-- Thickness of the highlight rectangle
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
			-- Can Current be traversed through?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNtraversalOn)
		end;

	is_unit_pixel: BOOLEAN is
			-- Is the measurement unit of Current a pixel?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNunitType) = XmPIXELS
		end;

	is_unit_100th_millimeter: BOOLEAN is
			-- Is the measurement unit of Current a 100th of a millimeter?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNunitType) = Xm100TH_MILLIMETERS
		end;

	 is_unit_1000th_inch: BOOLEAN is
			-- Is the measurement unit of Current a 1000th of an inch?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNunitType) = Xm1000TH_INCHES
		end;

	is_unit_100th_point: BOOLEAN is
			-- Is the measurement unit of Current a 100th of a point?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNunitType) = Xm100TH_POINTS
		end;

	is_unit_100th_font_unit: BOOLEAN is
			-- Is the measurement unit of Current a 100th of a font unit?
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
			-- Is traversal including the `TAB' key?
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

feature -- Status setting

	set_bottom_shadow_color (a_color: MEL_PIXEL) is
			-- Set `bottom_shadow_color' to `a_color'.
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
			-- Set `top_shadow_color' to `a_color'.
		require
			exists: not is_destroyed;
			valid_color: a_color /= Void and then a_color.is_valid;
			same_display: a_color.same_display (display)
		do
			set_xt_pixel (screen_object, XmNtopShadowColor, a_color)
		ensure
			top_shadow_color_set: top_shadow_color.is_equal (a_color)
		end;

	set_bottom_shadow_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `bottom_shadow_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			same_depth: depth = a_pixmap.depth;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNbottomShadowPixmap, a_pixmap)
		ensure
			bottom_shadow_pixmap_set: bottom_shadow_pixmap.is_equal (a_pixmap)
		end;

	set_top_shadow_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `top_shadow_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			same_depth: depth = a_pixmap.depth;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNtopShadowPixmap, a_pixmap)
		ensure
			top_shadow_pixmap_set: top_shadow_pixmap.is_equal (a_pixmap)
		end;

	set_foreground, set_foreground_color (a_color: MEL_PIXEL) is
			-- Set `foreground' and `foreground_color' to `a_color'.
		require
			exists: not is_destroyed;
			valid_color: a_color /= Void and then a_color.is_valid;
			same_display: a_color.same_display (display)
		do
			set_xt_pixel (screen_object, XmNforeground, a_color)
		ensure
			foreground_color_set: foreground_color.is_equal (a_color)
		end;

	set_highlight_color (a_color: MEL_PIXEL) is
			-- Set `highlight_color' to `a_color'.
		require
			exists: not is_destroyed;
			valid_color: a_color /= Void and then a_color.is_valid;
			same_display: a_color.same_display (display)
		do
			set_xt_pixel (screen_object, XmNhighlightColor, a_color)
		ensure
			highlight_color_set: highlight_color.is_equal (a_color)
		end;

	highlight_on_entry is
			-- Set `is_highlighted_on_entry' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNhighlightOnEnter, True)
		ensure
			highlighted_on_enter: is_highlighted_on_entry
		end;

	no_hightlight_on_entry is
			-- Set `is_highlighted_on_entry' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNhighlightOnEnter, False)
		ensure
			do_not_highlight_on_enter: not is_highlighted_on_entry
		end;

	set_highlight_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `highlight_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			a_pixmap_is_valid: a_pixmap /= Void and then a_pixmap.is_valid
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNhighlightPixmap, a_pixmap)
		ensure
			highlight_pixmap_set: highlight_pixmap.is_equal (a_pixmap)
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

	set_traversal_on is
			-- Set `is_traversable' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNtraversalOn, True)
		ensure
			traversal_on: is_traversable
		end;

	set_traversal_off is
			-- Set `is_traversable' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNtraversalOn, False)
		ensure
			traversal_off: not is_traversable
		end;

	set_unit_pixel is
			-- Set `is_unit_pixel'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNunitType, XmPIXELS)
		ensure
			unit_pixel_set: is_unit_pixel
		end;

	set_unit_100th_millimeter is
			-- Set `is_unit_100th_millimeter'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNunitType, Xm100TH_MILLIMETERS)
		ensure
			unit_100th_millimeter_set: is_unit_100th_millimeter
		end;

	set_unit_1000th_inch is
			-- Set `is_unit_1000th_inch'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNunitType, Xm1000TH_INCHES)
		ensure
			unit_1000th_inch_set: is_unit_1000th_inch
		end;

	set_unit_100th_point is
			-- Set `is_unit_100th_point'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNunitType, Xm100TH_POINTS)
		ensure
			unit_100th_point_set: is_unit_100th_point
		end;

	set_unit_100th_font_unit is
			-- Set `is_unit_100th_font_unit'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNunitType, Xm100TH_FONT_UNITS)
		ensure
			unit_100th_font_unit_set: is_unit_100th_font_unit
		end;

	set_navigation_to_none is
			-- Set `is_navigation_none'.
		do
			set_xt_unsigned_char (screen_object, XmNnavigationType, XmNONE)
		ensure
			is_navigation_none: is_navigation_none
		end;

	set_navigation_to_tab_group is
			-- Set `is_navigation_tab_group'.
		do
			set_xt_unsigned_char (screen_object, XmNnavigationType, XmTAB_GROUP)
		ensure
			is_navigation_tab_group: is_navigation_tab_group
		end;

	set_navigation_to_sticky_tab_group is
			-- Set `is_navigation_sticky_tab_group'.
		do
			set_xt_unsigned_char (screen_object, XmNnavigationType, XmSTICKY_TAB_GROUP)
		ensure
			is_navigation_sticky_tab_group: is_navigation_sticky_tab_group
		end;

	set_navigation_to_exclusive_tab_group is
			-- Set `is_navigation_exclusive_tab_gourp'.
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

feature {NONE} -- Implementation

	navigation_type: INTEGER is
			-- Way in which widget are to be traversed during keyboard navigation
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNnavigationType)
		end;

end -- class MEL_PRIMITIVE


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

