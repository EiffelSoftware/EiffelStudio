indexing

	description: 
			"Abstact notion of windowed widgets which %
			%represents the Core widget class in Motif.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_WIDGET

inherit

	MEL_CORE_RESOURCES
		export
			{NONE} all
		end;

	MEL_RECT_OBJ

creation
	make_from_existing

feature -- Status Report

	is_mapped_when_managed: BOOLEAN is
			-- Becomes Current visible as soon as it is both realized and managed?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNmappedWhenManaged)
		end;

	background, background_color: MEL_PIXEL is
			-- Color used for the background
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixel (screen_object, XmNbackground)
		ensure
			background_color_created: Result /= Void and then Result.is_valid
		end;

	background_pixmap: MEL_PIXMAP is
			-- Background pixmap
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (screen_object, XmNbackgroundPixmap)
		ensure
			background_pixmap_is_valid: Result /= Void and then Result.is_valid
		end;

	depth: INTEGER is
			-- Number of bits allowed for each pixel
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNdepth)
		ensure
			depth_large_enough: Result > 0
		end;

feature -- Status setting

	set_background, set_background_color (a_color: MEL_PIXEL) is
			-- Set `background' and `background_color' to `a_color'.
		require
			exists: not is_destroyed;
			a_color_is_valid: a_color /= Void and then a_color.is_valid
		do
			set_xt_pixel (screen_object, XmNbackground, a_color)
		ensure
			background_color_set: background_color.is_equal (a_color);
			background_set: background.is_equal (a_color)
		end;

	set_background_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `background_pixmap' to `a_pixmap'.
		require
			 exists: not is_destroyed;
			a_pixmap_is_valid: a_pixmap /= Void and then a_pixmap.is_valid
		do
			set_xt_pixmap (screen_object, XmNbackgroundPixmap, a_pixmap)
		ensure
			background_pixmap_set: background_pixmap.is_equal (a_pixmap)
		end;

	propagate_event is
			-- Propagate event to direct ancestor if no action
			-- is specified for event.
		require
			widget_realized: realized
		do
			x_propagate_event (screen_object, True)
		end;

	set_no_event_propagation is
			-- Don't propagate event to direct ancestor.
		require
			widget_realized: realized
		do
			x_propagate_event (screen_object, False)
		end;


	set_map_when_managed (b: BOOLEAN) is
			-- Set `is_mapped_when_managed' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNmappedWhenManaged, b)
		ensure
			is_mapped_when_managed: is_mapped_when_managed = b
		end;

feature -- Transformation

	lower is
			-- Lower Current in the stacking order.
		require
			exists: not is_destroyed
		do
			if window /= 0 then
				x_lower_window (screen.display.handle, window)
			end
		end;

	raise is
			-- Raise Current to the top of the stacking order.
		require
			exists: not is_destroyed
		do
			if window /= 0 then
				x_raise_window (screen.display.handle, window)
			end
		end;

feature -- Miscellaneous

	update_colors is
			-- Update the colors (top_shadow, bottom_shadow,
			-- select_color ...) if necessary using `background_color'.
		require
			exists: not is_destroyed;
			background_color_not_void: background_color /= Void
		do
			xm_change_color (screen_object, background_color.id)
		end;

feature -- Element change

	add_event_handler (a_mask: POINTER; a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callback list of the widget called specified by event mask `a_mask'.
			-- (All masks are defined in class `MEL_EVENT_MASK_CONSTANTS')
		require
			exists: not is_destroyed;
			a_mask_not_void: a_mask /= default_pointer;
			non_void_a_callback: a_callback /= Void
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.add_event_handler (screen_object, a_mask, a_callback_exec)
		end;

	set_override_translation (a_translation: STRING; a_callback: MEL_CALLBACK; an_argument: ANY) is
            -- Set `a_callback' to be executed with `an_argument' when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
			-- An existing translation for `a_translation' will be overriden.
		require
			exists: not is_destroyed;
			non_void_a_translation: a_translation /= Void
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.add_translation (screen_object, a_translation, a_callback_exec)
		end;

feature -- Removal

	remove_event_handler (a_mask: POINTER; a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callback list of the widget called specified by event mask `a_mask;.
			-- (All masks are defined in class `MEL_EVENT_MASK_CONSTANTS')
		require
			exists: not is_destroyed;
			a_mask_not_null: a_mask /= default_pointer;
			non_void_a_callback: a_callback  /= Void
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.remove_event_handler (screen_object, a_mask, a_callback_exec)
		end;

	remove_override_translation (a_translation: STRING) is
            -- Remove the callback for `a_translation'.
            -- Do nothing if `a_translation' was not set.
		require
			exists: not is_destroyed;
			non_void_a_translation: a_translation /= Void
		do
			Mel_dispatcher.remove_translation (screen_object, a_translation)
		end;

feature {NONE} -- Implementation

	x_propagate_event (scr_obj: POINTER; c_bool: BOOLEAN) is
		external
			"C"
		end;

end -- class MEL_WIDGET

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
