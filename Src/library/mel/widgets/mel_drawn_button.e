indexing

	description:
			"Button widget that provides a graphics area.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_DRAWN_BUTTON 

inherit

	MEL_DRAWN_BUTTON_RESOURCES
		export
			{NONE} all
		end;

	MEL_LABEL
		redefine
			make, create_callback_struct
		end

	MEL_DRAWING

creation
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif draw button widget.
		local
			widget_name: ANY
		do
			parent := a_parent;	
			widget_name := a_name.to_c;
			screen_object := xm_create_drawn_button (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		end;

feature -- Status report

	is_multiclick_kept: BOOLEAN is
			-- Are the successive button clicks processed?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNmultiClick) = XmMULTICLICK_KEEP
		end;

	is_multiclick_discarded: BOOLEAN is
			-- Are the successive button clicks discard?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNmultiClick) = XmMULTICLICK_DISCARD
		end;

	is_push_button_enabled: BOOLEAN is
			-- Does Current appear three dimensional?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNpushButtonEnabled)
		end;

	is_shadow_in: BOOLEAN is
			-- Is Current widget appear inset?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char
					(screen_object, XmNshadowType) = XmSHADOW_IN)
		end;

	is_shadow_out: BOOLEAN is
			-- Is Current widget appear raised?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char
					(screen_object, XmNshadowType) = XmSHADOW_OUT)
		end;

	is_shadow_etched_in: BOOLEAN is
			-- Does Current appear with a double line shadow inset?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char
						(screen_object, XmNshadowType) = XmSHADOW_ETCHED_IN)
		end;

	is_shadow_etched_out: BOOLEAN is
			-- Does Current appear with a double line shadow raised?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char
						(screen_object, XmNshadowType) = XmSHADOW_ETCHED_OUT)
		end;

feature -- Satus setting

	set_multiclick_to_keep is
			-- Set `is_multiclick_keep' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNmultiClick, XmMULTICLICK_KEEP)
		ensure
			keep_successive_clicks: is_multiclick_kept
		end;

	set_multiclick_to_discard is
			-- Set `is_multiclick_keep' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNmultiClick, XmMULTICLICK_DISCARD)
		ensure
			discard_successive_clicks: is_multiclick_discarded
		end;

	enable_push_button is
			-- Set `is_push_button_enabled' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNpushButtonEnabled, True)
		ensure
			push_button_is_enabled: is_push_button_enabled 
		end;

	disable_push_button is
			-- Set `is_push_button_enabled' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNpushButtonEnabled, False)
		ensure
			push_button_is_disabled: not is_push_button_enabled 
		end;

	set_shadow_in is
			-- Set `is_shadow_in' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_IN)
		ensure
			is_shadow_in: is_shadow_in
		end;

	set_shadow_out is
			-- Set `is_shadow_in' to False.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_OUT)
		ensure
			is_shadow_out: is_shadow_out
		end;

	set_shadow_etched_in is
			-- Set `is_shadow_etched_in' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_ETCHED_IN)
		ensure
			is_shadow_etched_in: is_shadow_etched_in
		end;

	set_shadow_etched_out is
			-- Set `is_shadow_etched_out' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_ETCHED_OUT)
		ensure
			is_shadow_etched_out: is_shadow_etched_out
		end;

feature -- Element change

	add_activate_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the button is pressed and released.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNactivateCallback, a_callback, an_argument)
		end;

	add_arm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the button is pressed.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNarmCallback, a_callback, an_argument)
		end;

	add_disarm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the button is released.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNdisarmCallback, a_callback, an_argument)
		end;

	add_expose_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the button receives an exposure
			-- event.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNexposeCallback, a_callback, an_argument)
		end;

	add_resize_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the button receives a resize
			-- event.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNresizeCallback, a_callback, an_argument)
		end;

feature -- Removal

	remove_activate_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the button is pressed and released.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNactivateCallback, a_callback, an_argument)
		end;

	remove_arm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the button is pressed.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNarmCallback, a_callback, an_argument)
		end;

	remove_disarm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the button is released.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNdisarmCallback, a_callback, an_argument)
		end;

	remove_expose_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the button receives an exposure
			-- event.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNexposeCallback, a_callback, an_argument)
		end;

	remove_resize_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the button receives a resize
			-- event.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNresizeCallback, a_callback, an_argument)
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr: POINTER;
				resouce_name: POINTER): MEL_DRAWN_BUTTON_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			!! Result.make (Current, a_callback_struct_ptr)
		end;

feature {NONE} -- Implementation

	xm_create_drawn_button (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/DrawnB.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateDrawnButton"
		end;

end -- class MEL_DRAWN_BUTTON

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
