indexing

	description:
			"Shell widget with Motif-specific hooks for window manager interaction.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_VENDOR_SHELL

inherit

	MEL_VENDOR_SHELL_RESOURCES
		export
			{NONE} all
		end;

	MEL_WM_SHELL

feature -- Status report

	is_audible_warning: BOOLEAN is
			-- Performs an action an associated audible cue?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNaudibleWarning) = XmBELL
		end;

	default_font_list: MEL_FONT_LIST is
			-- Default font list
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNdefaultFontList)
		ensure
			Result_is_valid: Result /= Void and then Result.is_valid;
			Result_is_shared: Result.is_shared
		end;

	button_font_list: MEL_FONT_LIST is
			-- Font list of the button children
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNbuttonFontList)
		ensure
			Result_is_valid: Result /= Void and then Result.is_valid;
			Result_is_shared: Result.is_shared
		end;

	label_font_list: MEL_FONT_LIST is
			-- Font list of the label children
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNlabelFontList)
		ensure
			Result_is_valid: Result /= Void and then Result.is_valid;
			Result_is_shared: Result.is_shared
		end;

	text_font_list: MEL_FONT_LIST is
			-- Font list of the text children
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNtextFontList)
		ensure
			Result_is_valid: Result /= Void and then Result.is_valid;
			Result_is_shared: Result.is_shared
		end;

	is_delete_response_destroy: BOOLEAN is
			-- Will the shell destroy the window when receiving
			-- a WM_DELETE_WINDOW message?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdeleteResponse) = XmDESTROY
		end;

	is_delete_response_unmap: BOOLEAN is
			-- Will the shell unmap the window when receiving
			-- a WM_DELETE_WINDOW message?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdeleteResponse) = XmUNMAP
		end;

	is_delete_response_do_nothing: BOOLEAN is
			-- Will the shell do nothing  when receiving
			-- a WM_DELETE_WINDOW message?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdeleteResponse) = XmDO_NOTHING
		end;

	input_method: STRING is
			-- String that sets the locale modifier
		require
			exists: not is_destroyed
		do
			Result := get_xt_string (screen_object, XmNinputMethod)
		ensure
			input_method_not_void: Result /= Void
		end;

	is_keyboard_focus_policy_explicit: BOOLEAN is
			-- Is the method of assigning the keyboard focus click-to-type?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNkeyboardFocusPolicy) = XmEXPLICIT
		end;

	is_keyboard_focus_policy_pointer: BOOLEAN is
			-- Is the method of assigning the keyboard focus determined
			-- by the mouse pointer?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNkeyboardFocusPolicy) = XmPOINTER
		end;

	preedit_type: STRING is
			-- Input method style(s) that are available
			-- (Motif Implementation dependent.)
		require
			exists: not is_destroyed
		do
			Result := get_xt_string (screen_object, XmNpreeditType)
		ensure
			preedit_type_not_void: preedit_type /= Void
		end;

	is_unit_pixel: BOOLEAN is
			-- Is the measurement unit a pixel?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, xmNshellUnitType) = XmPIXELS
		end;

	is_unit_100th_millimeter: BOOLEAN is
			-- Is the measurement unit a 100th of a millimeter?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, xmNshellUnitType) = Xm100TH_MILLIMETERS
		end;

	is_unit_1000th_inch: BOOLEAN is
			-- Is the measurement unit a 1000th of an inch?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, xmNshellUnitType) = Xm1000TH_INCHES
		end;

	is_unit_100th_point: BOOLEAN is
			-- Is the measurement unit a 100th of a point?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, xmNshellUnitType) = Xm100TH_POINTS
		end;

	is_unit_100th_font_unit: BOOLEAN is
			-- Is the measurement unit a 100th of a font unit?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, xmNshellUnitType) = Xm100TH_FONT_UNITS
		end;

	is_async_geometry_used: BOOLEAN is
			-- Does the geometry manager *not* wait to confirm a
			-- geometry request that was sent to the window manager?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNuseAsyncGeometry)
		end;

feature -- Status setting

	enable_audible_warning is
			-- Set `is_audible_warning' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNaudibleWarning, XmBELL)
		ensure
			audible_warning_enabled: is_audible_warning 
		end;

	disable_audible_warning is
			-- Set `is_audible_warning' to False.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNaudibleWarning, XmNONE)
		ensure
			audible_warning_disabled: not is_audible_warning 
		end;

	set_delete_response_destroy is
			-- Set `is_delete_response_destroy'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdeleteResponse, XmDESTROY)
		ensure
			delete_response_destroy_set: is_delete_response_destroy
		end;

	set_delete_response_unmap is
			-- Set `is_delete_response_unmap'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdeleteResponse, XmUNMAP)
		ensure
			delete_response_unmap_set: is_delete_response_unmap
		end;

	set_delete_response_do_nothing is
			-- Set `is_delete_response_do_nothing'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdeleteResponse, XmDO_NOTHING)
		ensure
			delete_response_do_nothing_set: is_delete_response_do_nothing
		end;

	set_input_method (a_string: STRING) is
			-- Set `input_method' to `a_string'.
		require
			exists: not is_destroyed;
			a_string_not_void: a_string /= Void
		do
			set_xt_string (screen_object, XmNinputMethod, a_string)
		ensure
			input_method_set: input_method.is_equal (a_string)
		end;

	set_keyboard_focus_policy_to_explicit is
			-- Set `is_keyboard_focus_policy_explicit' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNkeyboardFocusPolicy, XmEXPLICIT)
		ensure
			keyboard_focus_policy_explicit: is_keyboard_focus_policy_explicit
		end;

	set_keyboard_focus_policy_to_pointer is
			-- Set `is_keyboard_focus_policy_explicit' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNkeyboardFocusPolicy, XmPOINTER)
		ensure
			keyboard_focus_policy_pointer: is_keyboard_focus_policy_pointer
		end;

	set_preedit_type (a_string: STRING) is
			-- Set `preedit_type' to `a_string'.
		require
			exists: not is_destroyed;
			a_string_not_void: a_string /= Void
		do
			set_xt_string (screen_object, XmNpreeditType, a_string)
		ensure
			preedit_type_set: preedit_type.is_equal (a_string)
		end;

	set_unit_pixel is
			-- Set `is_unit_pixel'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, xmNshellUnitType, XmPIXELS)
		ensure
			unit_pixel_set: is_unit_pixel
		end;

	set_unit_100th_millimeter is
			-- Set `is_unit_100th_millimeter'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, xmNshellUnitType, Xm100TH_MILLIMETERS)
		ensure
			unit_100th_millimeter_set: is_unit_100th_millimeter
		end;

	set_unit_1000th_inch is
			-- Set `is_unit_1000th_inch'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, xmNshellUnitType, Xm1000TH_INCHES)
		ensure
			unit_1000th_inch_set: is_unit_1000th_inch
		end;

	set_unit_100th_point is
			-- Set `is_unit_100th_point'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, xmNshellUnitType, Xm100TH_POINTS)
		ensure
			unit_100th_point_set: is_unit_100th_point
		end;

	set_unit_100th_font_unit is
			-- Set `is_unit_100th_font_unit'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, xmNshellUnitType, Xm100TH_FONT_UNITS)
		ensure
			unit_100th_font_unit_set: is_unit_100th_font_unit
		end;

	use_async_geometry is
			-- Set `is_async_geometry_used' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNuseAsyncGeometry, True)
		ensure
			async_geometry_is_used: is_async_geometry_used 
		end;

	do_use_async_geometry is
			-- Set `is_async_geometry_used' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNuseAsyncGeometry, False)
		ensure
			async_geometry_is_not_used: not is_async_geometry_used 
		end;

	set_button_font_list (a_font_list: MEL_FONT_LIST) is
			-- Set `button_font_list' to a `a_font_list'.
		require
			exists: not is_destroyed
			a_font_list_is_valid: a_font_list /= Void and then a_font_list.is_valid
		do
			set_xm_font_list (screen_object, XmNbuttonFontList, a_font_list)
		end;

	set_label_font_list (a_font_list: MEL_FONT_LIST) is
			-- Set `label_font_list' to a `a_font_list'.
		require
			exists: not is_destroyed
			a_font_list_is_valid: a_font_list /= Void and then a_font_list.is_valid
		do
			set_xm_font_list (screen_object, XmNlabelFontList, a_font_list)
	   end;

	set_text_font_list (a_font_list: MEL_FONT_LIST) is
			-- Set `text_font_list' to `a_font_list'.
		require
			exists: not is_destroyed
			a_font_list_is_valid: a_font_list /= Void and then a_font_list.is_valid
		do
			set_xm_font_list (screen_object, XmNtextFontList, a_font_list)
		end;

end -- class MEL_VENDOR_SHELL


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

