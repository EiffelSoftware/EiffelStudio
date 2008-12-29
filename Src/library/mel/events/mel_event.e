note

	description: 
		"Implementation of the XAnyEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_EVENT

inherit

	SHARED_MEL_WIDGET_MANAGER
		redefine
			out
		end;

	MEL_EVENT_CONSTANTS
		export
			{NONE} all
		redefine	
			out
		end

create
	make

feature {NONE} -- Initialization

	make (an_event_ptr: POINTER)
			-- Create the events.
		require
			valid_an_event_ptr: an_event_ptr /= default_pointer
		do
			handle := an_event_ptr;
		ensure
			set: handle = an_event_ptr
		end;

feature -- Access

	type: INTEGER
			-- Event type 
			-- (Look in class MEL_EVENT_CONSTANTS for all
			-- event types)
		do
			Result := c_event_type (handle)
		end

	serial: INTEGER
			-- Number of last processed event.
			-- Caution it is an unsigned long casted into an int,
			-- so it can be sometimes negative.
		do
			Result := c_event_serial (handle)
		end;

	send_event: BOOLEAN
			-- True means that the event is from a SendEvent
		do
			Result := c_event_send_event (handle)
		end

	window_widget: MEL_WIDGET
			-- Associated MEL widget class with `window'
		do
			Result := retrieve_widget_from_window (window)
		end;

	display: MEL_DISPLAY
			-- Associated display 
		local
			d: POINTER
		do
			d := display_pointer;
			if d /= default_pointer then
				create Result.make_from_existing (display_pointer)
			end
		end;

feature -- Pointer access

	handle: POINTER;
			-- Pointer to the C XEvent structure

	display_pointer: POINTER
			-- Display server that reported the event
		do
			Result := c_event_display (handle)
		end

	window: POINTER
			-- Window pointer requesting the event
		do
			Result := c_event_window (handle)
		end;

feature -- Output

	out: STRING
			-- Output of event
		do
			Result := event_out
		end;

feature {NONE} -- Implementation

	retrieve_widget_from_window (w_ptr: POINTER): MEL_WIDGET
			-- Retrieve mel widget from window pointer `ptr'
		do
			if w_ptr /= default_pointer then
				Result := Mel_widgets.window_to_widget (display_pointer, w_ptr)
			end
		end;

	event_out: STRING
			-- Output of event
		local
			w: MEL_WIDGET
		do
			create Result.make (0);
			Result.append ("class: ");
			Result.append (generator);
			Result.append ("%N");
			Result.append ("%Tserial: ");
			Result.append (serial.out);
			Result.append ("%N");
			Result.append ("%Ttype: ");
			Result.append (type.out);
			Result.append ("%N");
			w := window_widget;
			if w = Void then
				Result.append ("Could not find MEL widget.");
			else
				Result.append ("Widget class: ");
				Result.append (w.generator);
				Result.append (" name: ");
				Result.append (w.name);
			end;
			Result.append ("%N");
		end;

feature {NONE} -- Implementation

	c_event_type (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XAnyEvent *): EIF_INTEGER"
		end;

	c_event_serial (event_ptr: POINTER): INTEGER
		external
			"C [macro %"events.h%"] (XAnyEvent *): EIF_INTEGER"
		end;

	c_event_send_event (event_ptr: POINTER): BOOLEAN
		external
			"C [macro %"events.h%"] (XAnyEvent *): EIF_BOOLEAN"
		end;

	c_event_display (event_ptr: POINTER): POINTER
		external
			"C [macro %"events.h%"] (XAnyEvent *): EIF_POINTER"
		end;

    c_event_window (event_ptr: POINTER): POINTER
        external
            "C [macro %"events.h%"] (XAnyEvent *): EIF_POINTER"
        end;

invariant
	
	valid_handle: handle /= default_pointer

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_EVENT


