indexing

	description: 
		"Motif Toggle Button Gadget.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TOGGLE_BUTTON_GADGET

inherit

	MEL_TOGGLE_BUTTON_GADGET_RESOURCES
		export
			{NONE} all
		end;

	MEL_LABEL_GADGET
		redefine
			make, create_callback_struct
		end

creation 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif toggle button gadget.
		local
			widget_name: ANY
		do
			parent := a_parent;	
			widget_name := a_name.to_c;
			screen_object := xm_create_toggle_button_gadget (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		end;

feature -- Status report

	state: BOOLEAN is
			-- State of current toggle button
		require
			exists: not is_destroyed
		do
			Result := xm_toggle_button_get_state (screen_object);
		end;

	is_filled_on_select: BOOLEAN is
			-- Is the indicator filled with `fill_color'?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNfillOnSelect)
		end;

	is_indicator_visible: BOOLEAN is
			-- Is the indicator visible?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNindicatorOn)
		end;

	indicator_size: INTEGER is
			-- Size of the indicator
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNindicatorSize)
		ensure
			indicator_size_large_enough: Result >= 0
		end;

	is_indicator_square: BOOLEAN is
			-- Is the indicator type a square?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNindicatorType) = XmN_OF_MANY
		end;

	select_color: MEL_PIXEL is
			-- Color when toggle is selected
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixel (Current, XmNselectColor)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.shared
		end;

	select_insensitive_pixmap: MEL_PIXMAP is
			-- Insensitive pixmap when toggle is selected
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNselectInsensitivePixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.shared
		end;

	select_pixmap: MEL_PIXMAP is
			-- Pixmap when toggle is selected
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNselectPixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.shared
		end;

	spacing: INTEGER is
			-- Distance between the toggle indicator and its label
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNspacing)
		ensure
			spacing_large_enough: Result >= 0
		end;

	is_indicator_visible_when_off: BOOLEAN is
			-- Is the toggle indicator visible when off?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNvisibleWhenOff)
		end;

feature -- Status setting

	set_toggle_on is
			-- Set Current toggle on.
		require
			exists: not is_destroyed
		do
			xm_toggle_button_set_state (screen_object, True, False)
		ensure
			state_is_true: state
		end;

	set_toggle_off is
			-- Set Current toggle off.
		require
			exists: not is_destroyed
		do
			xm_toggle_button_set_state (screen_object, False, False)
		ensure
			state_is_false: not state
		end;

	arm is
			-- Set `state' to `True' and call callback (if set).
		require
			exists: not is_destroyed
		do
			xm_toggle_button_set_state (screen_object, True, True)
		ensure
			state_is_true: state
		end;

	disarm is
			-- Set `state' to `False' and call callback (if set).
		require
			exists: not is_destroyed
		do
			xm_toggle_button_set_state (screen_object, False, True)
		ensure
			state_is_false: not state
		end;

	fill_on_select is
			-- Fill the indicator with `select_color' when toggle is selected.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNfillOnSelect, True)
		ensure
			filled_on_select_is_true: is_filled_on_select
		end;

	do_not_fill_on_select is
			-- Do not fill the indicator with `select_color'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNfillOnSelect, False)
		ensure
			filled_on_select_is_false: not is_filled_on_select
		end;

	set_indicator_visible is
			-- Set the indicator visible.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNindicatorOn, True)
		ensure
			indicator_visible_is_true: is_indicator_visible
		end;

	set_indicator_invisible is
			-- Set the indicator invisible.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object,XmNindicatorOn, False)
		ensure
			indicator_visible_is_false: not is_indicator_visible
		end;

	set_indicator_size (a_width: INTEGER) is
			-- Set `indicator_size' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNindicatorSize, a_width)
		ensure
			value_set: indicator_size = a_width
		end;

	set_indicator_square is
			-- Set the indicator type to square.
		require
			exists: not is_destroyed;
		do
			set_xt_unsigned_char (screen_object, XmNindicatorType, XmN_OF_MANY)
		ensure
			indicator_square_is_true: is_indicator_square
		end;
 
  	set_indicator_diamond is
			-- Set the indicator type to diamond.
		require
			exists: not is_destroyed;
		do
			set_xt_unsigned_char (screen_object, XmNindicatorType, XmONE_OF_MANY)
		ensure
			indicator_square_is_false: not is_indicator_square
		end;

	set_select_color (a_color: MEL_PIXEL) is
			-- Set `select_color' to `a_color'.
		require
			exists: not is_destroyed;
			valid_color: a_color /= Void and then a_color.is_valid;
			same_display: a_color.same_display (display)
		do
			set_xt_pixel (screen_object, XmNselectColor, a_color)
		ensure
			select_color_set: select_color.is_equal (a_color)
		end;

	set_select_insensitive_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `select_insensitive_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			is_pixmap: a_pixmap.is_pixmap;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNselectInsensitivePixmap, a_pixmap)
		ensure
			select_insensitive_pixmap_set: select_insensitive_pixmap.is_equal (a_pixmap)
		end;	

	set_select_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `select_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			is_pixmap: a_pixmap.is_pixmap;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNselectPixmap, a_pixmap)
		ensure
			select_pixmap_set: select_pixmap.is_equal (a_pixmap)
		end;

	set_spacing (a_width: INTEGER) is
			-- Set `spacing' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNspacing, a_width)
		ensure
			value_set: spacing = a_width
		end;

	set_indicator_visible_when_off is
			-- Set the indicator visible when off.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNvisibleWhenOff, True)
		ensure
			indicator_is_visible_when_off: is_indicator_visible_when_off
		end;

	set_indicator_invisible_when_off is
			-- Set the indicator invisible when off.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNvisibleWhenOff, False)
		ensure
			indicator_is_not_visible_when_off: not is_indicator_visible_when_off
		end;

feature -- Element change

	add_value_changed_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with the argument `an_argument'
			-- to the callbacks called when the value of the button has
			-- been changed.
		require
			a_callback_not_void: a_callback /= Void;
		do
			add_callback (XmNvalueChangedCallback, a_callback, an_argument);
		end;

	add_arm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with the argument `an_argument'
			-- to the callbacks called when the button is pressed.
		require
			a_callback_not_void: a_callback /= Void;
		do
			add_callback (XmNarmCallback, a_callback, an_argument);
		end;

	add_disarm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with the argument `an_argument'
			-- to the callbacks called when the button is released.
		require
			a_callback_not_void: a_callback /= Void;
		do
			add_callback (XmNdisarmCallback, a_callback, an_argument);
		end;

feature -- Removal

	remove_value_changed_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with the argument `an_argument'
			-- to the callbacks called when the value of the button has
			-- been changed.
		require
			a_callback_not_void: a_callback /= Void;
		do
			remove_callback (XmNvalueChangedCallback, a_callback, an_argument);
		end;

	remove_arm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with the argument `an_argument'
			-- to the callbacks called when the button is pressed.
		require
			a_callback_not_void: a_callback /= Void;
		do
			remove_callback (XmNarmCallback, a_callback, an_argument);
		end;

	remove_disarm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with the argument `an_argument'
			-- to the callbacks called when the button is released.
		require
			a_callback_not_void: a_callback /= Void;
		do
			remove_callback (XmNdisarmCallback, a_callback, an_argument);
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr: POINTER;
					resource_name: POINTER): MEL_TOGGLE_BUTTON_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to the `a_callback_struct_ptr' pointer.
		do
			!! Result.make (Current, a_callback_struct_ptr)
		end;

feature {NONE} -- Implementation

	xm_toggle_button_set_state (scr_obj: POINTER; value1, value2: BOOLEAN) is
		external
			"C [macro <Xm/ToggleBG.h>] (Widget, Boolean, Boolean)"
		alias
			"XmToggleButtonSetState"
		end;

	xm_toggle_button_get_state (scr_obj: POINTER): BOOLEAN is
		external
			"C [macro <Xm/ToggleBG.h>] (Widget): EIF_BOOLEAN"
		alias
			"XmToggleButtonGetState"
		end;

	xm_create_toggle_button_gadget (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/ToggleBG.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateToggleButtonGadget"
		end;

end -- class MEL_TOGGLE_BUTTON_GADGET

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
