indexing

	description:
			"Fundamental shell widget that interacts with an %
			%ICCCM-compliant window manager.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_WM_SHELL

inherit

	MEL_WM_SHELL_RESOURCES
		export
			{NONE} all
		end;

	MEL_SHELL

feature -- Status report

	base_height: INTEGER is
			-- Base for a progression of preferred heights for current
			-- window manager to use in sizing widgets.
			-- The preferred heights are base_heights plus integral multiples
			-- of height_inc.
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNbaseHeight)
		ensure
			base_height_large_enough: Result >= 0
		end;

	base_width: INTEGER is
			-- Base for a progression of preferred widths for current
			-- window manager to use in sizing widgets.
			-- The preferred widths are base_heights plus integral multiples
			-- of width_inc.
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNbaseWidth)
		ensure
			base_width_large_enough: Result >= 0
		end;

	height_inc: INTEGER is
			-- Increment for a progression of preferred heights for the
			-- window manager tu use in sizing widgets
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNheightInc)
		ensure
			height_inc_large_enough: Result >= 0
		end;

	width_inc: INTEGER is
			-- Increment for a progression of preferred widths for the
			-- window manager tu use in sizing widgets
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNwidthInc)
		ensure
			width_inc_large_enough: Result >= 0
		end;

	icon_mask: MEL_PIXMAP is
			-- Bitmap that could be used by window manager to clip icon_pixmap
			-- bitmap to make the icon non rectangular
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNiconMask)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	icon_pixmap: MEL_PIXMAP is
			-- Bitmap that could be used by the window manager as the application's icon
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNiconPixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	icon_window: POINTER is
			-- The ID of a window that serves as the application's icon.
		require
			exists: not is_destroyed
		do
		ensure
		end;

	icon_x: INTEGER is
			-- Place to put application's icon
			-- (Since the window manager controls icon placement policy, this may be ignored.)
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNiconX)
		end;

	icon_y: INTEGER is
			-- Place to put application's icon
			-- (Since the window manager controls icon placement policy, this may be ignored.)
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNiconY)
		end;

	is_initial_state_normal: BOOLEAN is
			-- Does the application start as a window?
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNinitialState) = NormalState
		end;

	is_initial_state_iconic: BOOLEAN is
			-- Does the application start as an icon?
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNinitialState) = IconicState
		end;

	input: BOOLEAN is
			-- Is input allowed?
			-- (`input' is only useful in conjunction with the `WM_TAKE_FOCUS' atom,
			--  with which it determines the keyboard focus model:
			--  If `input' is False and the atom exists, then the focus is globally active.
			--  If `input' is False and the atom does not exist, then no input is allowed.
			--  If `input' is True and the atom exists, then the focus is locally active.
			--  If `input' is True and the atom does not exist, then the focus is passive.)
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNinput)
		end;

	max_aspect_x: INTEGER is
			-- Numerator of maximum aspect ratio requested for Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNmaxAspectX)
		end;

	max_aspect_y: INTEGER is
			-- Denominator of maximum aspect ratio requested for Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNmaxAspectY)
		end;

	min_aspect_x: INTEGER is
			-- Numerator of minimum aspect ratio requested for Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNminAspectX)
		end;

	min_aspect_y: INTEGER is
			-- Denominator of minimum ratio requested for Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNminAspectY)
		end;

	max_height: INTEGER is
			-- Maximum height
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNmaxHeight)
		ensure
			max_height_large_enough: Result >= min_height
		end;

	max_width: INTEGER is
			-- Maximum width
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNmaxWidth)
		ensure
			max_width_large_enough: Result >= min_width
		end;

	min_height: INTEGER is
			-- Minimum height
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNminHeight)
		ensure
			min_height_large_enough: Result > 0;
			min_height_small_enough: Result <= max_height
		end;

	min_width: INTEGER is
			-- Minimum width
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNminWidth)
		ensure
			min_width_large_enough: Result > 0;
			min_width_small_enough: Result <= max_width
		end;

	title: STRING is
			-- Application name to be displayed by the window manager
		require
			exists: not is_destroyed
		do
			Result := get_xt_string_no_free (screen_object, XmNtitle)
		ensure
			title_not_void: Result /= Void
		end;

	title_encoding is
			-- Property type for encoding `title'
		require
			exists: not is_destroyed
		do
		ensure
		end;

	is_transient: BOOLEAN is
			-- Is Current transient?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNtransient)
		end;

	wait_for_wm: BOOLEAN is
			-- Does the X Toolkit wait for a response
			-- from the window manager before acting as if no window
			-- manager exists?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNwaitForWm)
		end;

	window_group is
			-- Window assciated with Current
		require
			exists: not is_destroyed
		do
		ensure
		end;

	window_gravity: INTEGER is
			-- Window gravity is used in positioning Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNwinGravity)
		end;

	wm_timeout: INTEGER is
			-- Number of milliseconds that the X Toolkit waits
			-- for a response from the window manager
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNwmTimeout)
		ensure
			wm_timeout_large_enough: wm_timeout > 0
		end;

feature -- Status setting

	set_base_height (a_height: INTEGER) is
			-- Set `base_height' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height > 0
		do
			set_xt_int (screen_object, XmNbaseHeight, a_height)
		ensure
			base_height_set: base_height = a_height
		end;

	set_base_width (a_width: INTEGER) is
			-- Set `base_width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width > 0
		do
			set_xt_int (screen_object, XmNbaseWidth, a_width)
		ensure
			base_width_set: base_width = a_width
		end;

	set_height_inc (a_height: INTEGER) is
			-- Set `height_inc' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height > 0
		do
			set_xt_int (screen_object, XmNheightInc, a_height)
		ensure
			height_inc_set: height_inc = a_height
		end;

	set_width_inc (a_width: INTEGER) is
			-- Set `width_inc' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width > 0
		do
			set_xt_int (screen_object, XmNwidthInc, a_width)
		ensure
			width_inc_set: width_inc = a_width
		end;

	set_icon_mask (a_mask: MEL_PIXMAP) is
			-- Set `icon_mask' to `a_mask'.
		require
			exists: not is_destroyed;
			valid_mask: a_mask /= Void and then a_mask.is_valid;
			same_display: a_mask.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNiconMask, a_mask)
		ensure
			set: icon_mask.is_equal (a_mask)
		end;

	set_icon_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `icon_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNiconPixmap, a_pixmap)
		ensure
			set: icon_pixmap.is_equal (a_pixmap)
		end;

	set_icon_window is
			-- Set `icon_window'.
		require
			exists: not is_destroyed
		do
		ensure
		end;

	set_icon_x (a_x: INTEGER) is
			-- Set `icon_x' to `a_x'.
		require
			exists: not is_destroyed
		do
			set_xt_int (screen_object, XmNiconX, a_x)
		ensure
			icon_x_set: icon_x = a_x;
		end;

	set_icon_y (a_y: INTEGER) is
			-- Set `icon_y' to `a_y'.
		require
			exists: not is_destroyed
		do
			set_xt_int (screen_object, XmNiconY, a_y)
		ensure
			icon_y_set: icon_y = a_y
		end;

	set_initial_state_to_normal is
			-- Set `is_initial_state_normal' to True.
		require
			exists: not is_destroyed
		do
			set_xt_int (screen_object, XmNinitialState, NormalState)
		ensure
			initial_state_is_normal: is_initial_state_normal 
		end;

	set_initial_state_to_iconic is
			-- Set `is_initial_state_iconic' to True.
		require
			exists: not is_destroyed
		do
			set_xt_int (screen_object, XmNinitialState, IconicState)
		ensure
			initial_state_is_iconic: is_initial_state_iconic 
		end;

	enable_input is
			-- Set `input' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNinput, True)
		ensure
			input_enabled: input
		end;

	disable_input is
			-- Set `input' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNinput, False)
		ensure
			input_disabled: not input
		end;

	set_max_aspect_x (a_value: INTEGER) is
			-- Set `max_aspect_x' to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value > 0
		do
			set_xt_int (screen_object, XmNmaxAspectX, a_value)
		ensure
			max_aspect_x_set: max_aspect_x = a_value
		end;

	set_max_aspect_y (a_value: INTEGER) is
			-- Set `max_aspect_y' to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value > 0
		do
			set_xt_int (screen_object, XmNmaxAspectY, a_value)
		ensure
			max_aspect_y_set: max_aspect_y = a_value
		end;

	set_min_aspect_x (a_value: INTEGER) is
			-- Set `min_aspect_x' to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value > 0
		do
			set_xt_int (screen_object, XmNminAspectX, a_value)
		ensure
			min_aspect_x_set: min_aspect_x = a_value
		end;

	set_min_aspect_y (a_value: INTEGER) is
			-- Set `min_aspect_y' to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value > 0
		do
			set_xt_int (screen_object, XmNminAspectY, a_value)
		ensure
			min_aspect_y_set: min_aspect_y = a_value
		end;

	set_max_height (a_height: INTEGER) is
			-- Set `max_height' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height >= min_height
		do
			set_xt_int (screen_object, XmNmaxHeight, a_height)
		ensure
			max_height_set: max_height = a_height
		end;

	set_max_width (a_width: INTEGER) is
			-- Set `max_width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= min_width
		do
			set_xt_int (screen_object, XmNmaxWidth, a_width)
		ensure
			max_width_set: max_width = a_width
		end;

	set_min_height (a_height: INTEGER) is
			-- Set `min_height' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height >= 0;
			a_height_small_enough: a_height <= max_height
		do
			set_xt_int (screen_object, XmNminHeight, a_height)
		ensure
			min_height_set: min_height = a_height
		end;

	set_min_width (a_width: INTEGER) is
			-- Set `min_width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0;
			a_width_small_enough: a_width <= max_width
		do
			set_xt_int (screen_object, XmNminWidth, a_width)
		ensure
			min_width_set: min_width = a_width
		end;

	set_title (a_string: STRING) is
			-- Set `title' to `a_string'.
		require
			exists: not is_destroyed;
			a_string_not_void: a_string /= Void
		do
			set_xt_string (screen_object, XmNtitle, a_string)
		ensure
			title_set: title.is_equal (a_string)
		end;

	enable_transient is
			-- Set `is_transient' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNtransient, True)
		ensure
			shell_is_transient: is_transient 
		end;

	disable_transient is
			-- Set `is_transient' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNtransient, False)
		ensure
			shell_is_not_transient: not is_transient 
		end;

	enable_wait_for_wm is
			-- Set `wait_for_wm' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNwaitForWm, True)
		ensure
			wait_for_wm_enabled: wait_for_wm 
		end;

	disable_wait_for_wm is
			-- Set `wait_for_wm' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNwaitForWm, False)
		ensure
			wait_for_wm_disabled: not wait_for_wm 
		end;

	set_window_gravity (a_value: INTEGER) is
			-- Set `window_gravity' to `a_value'.
		require
			exists: not is_destroyed
		do
			set_xt_int (screen_object, XmNwinGravity, a_value)
		ensure
			window_gravity_set: window_gravity = a_value
		end;

	set_wm_timeout (a_value: INTEGER) is
			-- Set `wm_timeout' as `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value > 0
		do
			set_xt_int (screen_object, XmNwmTimeout, a_value)
		ensure
			wm_timeout_set: wm_timeout = a_value
		end;

invariant

--	max_aspect_greater_than_min_aspect:
--		(max_aspect_x / max_aspect_y) >= (min_aspect_x / min_aspect_y)

end -- class MEL_WM_SHELL


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

