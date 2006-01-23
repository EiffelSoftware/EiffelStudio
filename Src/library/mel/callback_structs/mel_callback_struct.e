indexing

	description: 
		"General notion of a callback structure."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CALLBACK_STRUCT

inherit

	MEL_CALLBACK_STRUCT_CONSTANTS;

	MEL_EVENT_CONSTANTS

create {MEL_DISPATCHER, MEL_OBJECT}
	make, 
	make_no_event
create {MEL_APPLICATION_CONTEXT, MEL_WIDGET}
	make_event_only 

feature {NONE} -- Initialization

	make (a_widget: MEL_OBJECT; an_event_ptr: POINTER) is
			-- Make the MEL_CALLBACK_STRUCT associated with the widget
			-- that triggered the callback and the event callback_structure
			-- associated with this callback.
		require
			a_widget_exists: a_widget /= Void and then not a_widget.is_destroyed;
		do
			widget := a_widget;
			if an_event_ptr /= default_pointer then
				create_event (an_event_ptr)
			end;
		ensure
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
debug ("MEL_CALLBACK")
	io.error.putstring ("Mel structure:%N ");
	io.error.putstring (out);
	io.error.new_line
end
		ensure
			void_event: event = Void;
			widget_set: a_widget = widget
		end;

	make_event_only (an_event_ptr: POINTER) is
			-- Make the event callback_structure.
		require
			valid_event_ptr: an_event_ptr /= default_pointer
		do
			create_event (an_event_ptr)
		ensure
			non_void_event: event /= Void;
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
				create {MEL_KEY_EVENT} event.make (event_ptr)
			elseif type = ButtonPress or type = ButtonRelease then
				create {MEL_BUTTON_EVENT} event.make (event_ptr)
			elseif type = MotionNotify then
				create {MEL_MOTION_EVENT} event.make (event_ptr)
			elseif type = EnterNotify or type = LeaveNotify then
				create {MEL_CROSSING_EVENT} event.make (event_ptr)
			elseif type = FocusIn or type = FocusOut then
				create {MEL_FOCUS_CHANGE_EVENT} event.make (event_ptr)
			elseif type = KeymapNotify then
				create {MEL_KEYMAP_EVENT} event.make (event_ptr)
			elseif type = Expose then
				create {MEL_EXPOSE_EVENT} event.make (event_ptr)
			elseif type = GraphicsExpose then
				create {MEL_GRAPHICS_EXPOSE_EVENT} event.make (event_ptr)
			elseif type = NoExpose then
				create {MEL_NO_EXPOSE_EVENT} event.make (event_ptr)
			elseif type = VisibilityNotify then
				create {MEL_VISIBILITY_EVENT} event.make (event_ptr)
			elseif type = CreateNotify then
				create {MEL_CREATE_WINDOW_EVENT} event.make (event_ptr)
			elseif type = DestroyNotify then
				create {MEL_DESTROY_WINDOW_EVENT} event.make (event_ptr)
			elseif type = UnmapNotify then
				create {MEL_UNMAP_EVENT} event.make (event_ptr)
			elseif type = MapNotify then
				create {MEL_MAP_EVENT} event.make (event_ptr)
			elseif type = MapRequest then
				create {MEL_MAP_REQUEST_EVENT} event.make (event_ptr)
			elseif type = ReparentNotify then
				create {MEL_REPARENT_EVENT} event.make (event_ptr)
			elseif type = ConfigureNotify then
				create {MEL_CONFIGURE_EVENT} event.make (event_ptr)
			elseif type = ConfigureRequest then
				create {MEL_CONFIGURE_REQUEST_EVENT} event.make (event_ptr)
			elseif type = GravityNotify then
				create {MEL_GRAVITY_EVENT} event.make (event_ptr)
			elseif type = ResizeRequest then
				create {MEL_RESIZE_REQUEST_EVENT} event.make (event_ptr)
			elseif type = CirculateNotify then
				create {MEL_CIRCULATE_EVENT} event.make (event_ptr)
			elseif type = CirculateRequest then
				create {MEL_CIRCULATE_REQUEST_EVENT} event.make (event_ptr)
			elseif type = PropertyNotify then
				create {MEL_PROPERTY_EVENT} event.make (event_ptr)
			elseif type = SelectionClear then
				create {MEL_SELECTION_CLEAR_EVENT} event.make (event_ptr)
			elseif type = SelectionRequest then
				create {MEL_SELECTION_REQUEST_EVENT} event.make (event_ptr)
			elseif type = SelectionNotify then
				create {MEL_SELECTION_EVENT} event.make (event_ptr)
			elseif type = ColormapNotify then
				create {MEL_COLORMAP_EVENT} event.make (event_ptr)
			elseif type = ClientMessage then
				create {MEL_CLIENT_MESSAGE_EVENT} event.make (event_ptr)
			elseif type = MappingNotify then
				create {MEL_MAPPING_EVENT} event.make (event_ptr)
			else
				create event.make (event_ptr)
			end
debug ("MEL_CALLBACK")
	io.error.putstring ("Mel structure:%N ");
	io.error.putstring (out);
	io.error.putstring ("%TEvent dump: %N%T");
	io.error.putstring (event.out);
	io.error.new_line
end
		end;

	c_event_type (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XEvent *): EIF_INTEGER"
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_CALLBACK_STRUCT


