indexing

	description:
			"Widget that starts an operation when it is pressed.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PUSH_BUTTON

inherit

	MEL_PUSH_BUTTON_RESOURCES
		export
			{NONE} all
		end;

	MEL_LABEL
		redefine
			make, create_callback_struct
		end;

creation 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif push button.
		local
			widget_name: ANY
		do
			parent := a_parent;	
			widget_name := a_name.to_c;
			screen_object := xm_create_push_button (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		end;

feature -- Access

	activate_command: MEL_COMMAND_EXEC is
			-- Command set for the activate callback
		do
			Result := motif_command (XmNactivateCallback)
		end;

	arm_command: MEL_COMMAND_EXEC is
			-- Command set for the arm callback
		do
			Result := motif_command (XmNarmCallback)
		end;

	disarm_command: MEL_COMMAND_EXEC is
			-- Command set for the disarm callback
		do
			Result := motif_command (XmNdisarmCallback)
		end

feature -- Status report

	arm_color: MEL_PIXEL is
			-- Arm color
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixel (Current, XmNarmColor)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	arm_pixmap: MEL_PIXMAP is
			-- Arm pixmap
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNarmPixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	default_button_shadow_thickness: INTEGER is
			-- Width of the shadow used to indicate the default push button
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNdefaultButtonShadowThickness)
		ensure
			shadow_thickness_large_enough: Result >= 0
		end;

	is_filled_on_arm: BOOLEAN is
			-- Is `arm_color' used when the button is armed?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNfillOnArm)
		end;

	is_multiclick_kept: BOOLEAN is
			-- Are the successive button clicks processed?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNmultiClick) = XmMULTICLICK_KEEP
		end;

	is_multiclick_discarded: BOOLEAN is
			-- Are the successive button clicks discard?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char
				(screen_object, XmNmultiClick) = XmMULTICLICK_DISCARD
		end;

	show_as_default: INTEGER is
			-- Should Current be shown as the default push button?
			-- Zero means no. Greater than zero means yes.
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNshowAsDefault)
		ensure
			value_large_enough: Result >= 0
		end;

feature -- Status setting

	set_arm_color (a_color: MEL_PIXEL) is
			-- Set `arm_color' to `a_color'.
		require
			exists: not is_destroyed;
			valid_color: a_color /= Void and then a_color.is_valid;
			same_display: a_color.same_display (display)
		do
			set_xt_pixel (screen_object, XmNarmColor, a_color)
		ensure
			arm_color_set: arm_color.is_equal (a_color)
		end;

	set_arm_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `arm_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			same_depth: depth = a_pixmap.depth;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNarmPixmap, a_pixmap)
		ensure
			arm_pixmap_set: arm_pixmap.is_equal (a_pixmap)
		end;

	set_default_button_shadow_thickness (a_width: INTEGER) is
			-- Set `default_button_shadow_thickness' to `a_width'.
		require
			exists: not is_destroyed
			shadow_thickness_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNdefaultButtonShadowThickness, a_width)
		ensure
			shadow_thickness_set: default_button_shadow_thickness = a_width
		end;

	fill_on_arm is
			-- Set `filled_on_arm' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNfillOnArm, True)
		ensure
			is_filled_on_arm: is_filled_on_arm 
		end;

	no_fill_on_arm is
			-- Set `filled_on_arm' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNfillOnArm, False)
		ensure
			is_not_filled_on_arm: not is_filled_on_arm 
		end;

	set_multiclick_to_keep is
			-- Set `is_multiclick_kept' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNmultiClick, XmMULTICLICK_KEEP)
		ensure
			keep_successive_clicks: is_multiclick_kept
		end;

	set_multiclick_to_discard is
			-- Set `is_multiclick_discard' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNmultiClick, XmMULTICLICK_DISCARD)
		ensure
			discard_successive_clicks: is_multiclick_discarded
		end;

	set_show_as_default (a_width: INTEGER) is
			-- Set `show_as_default' to `a_width'.
		require
			exists: not is_destroyed;
			width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNshowAsDefault, a_width)
		ensure
			width_set: show_as_default = a_width
		end;

feature -- Element change

	set_activate_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the button is pressed
			-- and released.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNactivateCallback, a_command, an_argument);
		ensure
			command_set: command_set (activate_command, a_command, an_argument)
		end;

	set_arm_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the button is pressed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNarmCallback, a_command, an_argument);
		ensure
			command_set: command_set (arm_command, a_command, an_argument)
		end;

	set_disarm_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the button is released.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNdisarmCallback, a_command, an_argument);
		ensure
			command_set: command_set (disarm_command, a_command, an_argument)
		end;

feature -- Removal

	remove_activate_callback is
			-- Remove the command for the activate callback.
		do
			remove_callback (XmNactivateCallback)
		ensure
			removed: activate_command = Void
		end;

	remove_arm_callback is
			-- Remove the command for the arm callback.
		do
			remove_callback (XmNarmCallback)
		ensure
			removed: arm_command = Void
		end;

	remove_disarm_callback is
			-- Remove the command for the disarm callback.
		do
			remove_callback (XmNdisarmCallback)
		ensure
			removed: disarm_command = Void
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr: POINTER;
				resource_name: POINTER): MEL_PUSH_BUTTON_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			!! Result.make (Current, a_callback_struct_ptr)
		end;

feature {NONE} -- Implementation

	xm_create_push_button (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/PushB.h>"
		alias
			"XmCreatePushButton"
		end;

end -- class MEL_PUSH_BUTTON


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

