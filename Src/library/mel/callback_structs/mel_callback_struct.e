indexing

	description: 
		"General notion of a callback structure.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CALLBACK_STRUCT

inherit

	MEL_CALLBACK_STRUCT_CONSTANTS;

	MEL_EVENT_CONSTANTS

creation {MEL_DISPATCHER, MEL_OBJECT}
	make, 
	make_no_event

feature {NONE} -- Initialization

	make (a_widget: MEL_OBJECT; an_event_ptr: POINTER) is
			-- Make the MEL_CALLBACK_STRUCT associated with the widget
			-- that triggered the callback and the event callback_structure
			-- associated with this callback.
		require
			a_widget_exists: a_widget /= Void and then not a_widget.is_destroyed;
		do
			widget := a_widget;
			create_event (an_event_ptr)
		ensure
			non_void_event: event /= Void;
			widget_set: a_widget = widget
		end;

	make_no_event (a_widget: MEL_OBJECT) is
			-- Make the MEL_CALLBACK_STRUCT associated with the widget
			-- that triggered the callback. Do not created associated
			-- event.
		require
			a_widget_exists: a_widget /= Void and then not a_widget.is_destroyed;
		do
			widget := a_widget;
debug ("MEL")
	io.error.putstring ("Mel structure:%N ");
	io.error.putstring (out);
	io.error.new_line
end
		ensure
			void_event: event = Void;
			widget_set: a_widget = widget
		end;

feature -- Access

	widget: MEL_OBJECT;
			-- Widget that triggered the callback.

	event: MEL_EVENT;
			-- Event associated with the callback.

	has_widget: BOOLEAN is
			-- Does current callback structure have a widget
			-- associated with it (By default, it is True)
		do
			Result := True
		end;

	reason: INTEGER is
			-- Callback reason for motif callbacks
			-- (Look in class MEL_CALLBACK_STRUCT_CONSTANTS for all
			-- reasons)
		do
		end

	is_motif_callback: BOOLEAN is
			-- Is Current a motif callback structure?
		do
			Result := reason /= XmCR_NONE 
		ensure
			valid_result: Result implies reason /= XmCR_NONE
		end;

feature {NONE} -- Implementation

	create_event (event_ptr: POINTER) is
			-- Create the event that triggered the callback.
		local
			type: INTEGER
		do
			type := c_event_type (event_ptr);
			if type = KeyPress or type = KeyRelease then
				!MEL_KEY_EVENT! event.make (event_ptr)
			elseif type = ButtonPress or type = ButtonRelease then
				!MEL_BUTTON_EVENT! event.make (event_ptr)
			elseif type = MotionNotify then
				!MEL_MOTION_EVENT! event.make (event_ptr)
			elseif type = EnterNotify or type = LeaveNotify then
				!MEL_CROSSING_EVENT! event.make (event_ptr)
			elseif type = FocusIn or type = FocusOut then
				!MEL_FOCUS_CHANGE_EVENT! event.make (event_ptr)
			elseif type = KeymapNotify then
				!MEL_KEYMAP_EVENT! event.make (event_ptr)
			elseif type = Expose then
				!MEL_EXPOSE_EVENT! event.make (event_ptr)
			elseif type = GraphicsExpose then
				!MEL_GRAPHICS_EXPOSE_EVENT! event.make (event_ptr)
			elseif type = NoExpose then
				!MEL_NO_EXPOSE_EVENT! event.make (event_ptr)
			elseif type = VisibilityNotify then
				!MEL_VISIBILITY_EVENT! event.make (event_ptr)
			elseif type = CreateNotify then
				!MEL_CREATE_WINDOW_EVENT! event.make (event_ptr)
			elseif type = DestroyNotify then
				!MEL_DESTROY_WINDOW_EVENT! event.make (event_ptr)
			elseif type = UnmapNotify then
				!MEL_UNMAP_EVENT! event.make (event_ptr)
			elseif type = MapNotify then
				!MEL_MAP_EVENT! event.make (event_ptr)
			elseif type = MapRequest then
				!MEL_MAP_REQUEST_EVENT! event.make (event_ptr)
			elseif type = ReparentNotify then
				!MEL_REPARENT_EVENT! event.make (event_ptr)
			elseif type = ConfigureNotify then
				!MEL_CONFIGURE_EVENT! event.make (event_ptr)
			elseif type = ConfigureRequest then
				!MEL_CONFIGURE_REQUEST_EVENT! event.make (event_ptr)
			elseif type = GravityNotify then
				!MEL_GRAVITY_EVENT! event.make (event_ptr)
			elseif type = ResizeRequest then
				!MEL_RESIZE_REQUEST_EVENT! event.make (event_ptr)
			elseif type = CirculateNotify then
				!MEL_CIRCULATE_EVENT! event.make (event_ptr)
			elseif type = CirculateRequest then
				!MEL_CIRCULATE_REQUEST_EVENT! event.make (event_ptr)
			elseif type = PropertyNotify then
				!MEL_PROPERTY_EVENT! event.make (event_ptr)
			elseif type = SelectionClear then
				!MEL_SELECTION_CLEAR_EVENT! event.make (event_ptr)
			elseif type = SelectionRequest then
				!MEL_SELECTION_REQUEST_EVENT! event.make (event_ptr)
			elseif type = SelectionNotify then
				!MEL_SELECTION_EVENT! event.make (event_ptr)
			elseif type = ColormapNotify then
				!MEL_COLORMAP_EVENT! event.make (event_ptr)
			elseif type = ClientMessage then
				!MEL_CLIENT_MESSAGE_EVENT! event.make (event_ptr)
			elseif type = MappingNotify then
				!MEL_MAPPING_EVENT! event.make (event_ptr)
			else
				!! event.make (event_ptr)
			end
debug ("MEL")
	io.error.putstring ("Mel structure:%N ");
	io.error.putstring (out);
	io.error.putstring ("%TEvent dump: %N%T");
	io.error.putstring (event.out);
	io.error.new_line
end
		end;

	c_event_type (event_ptr: POINTER): INTEGER is
		external
			"C [macro <events.h>] (XEvent *): EIF_INTEGER"
		end;

invariant
	
	non_void_widget: has_widget implies widget /= Void

end -- class MEL_CALLBACK_STRUCT

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
