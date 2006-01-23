indexing

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SCROLLING_DATA_WINDOWS

inherit

	CONTEXT_DATA
		rename
			make as context_data_make 
		end

create

	make

feature -- Initialization

	make (a_widget: WIDGET; code, pos: INTEGER; direction: BOOLEAN) is
			-- Create a context data for `scrolling' events
		do
			widget := a_widget
			event_code := code
			new_position := pos
			is_vertical := direction
		end

feature -- Access

	event_code: INTEGER
			-- Code of the event that has occurred

	new_position: INTEGER
			-- New thumb position

	is_vertical: BOOLEAN;
			-- Did this come from a VSCROLL?

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




end -- class SCROLLING_DATA_WINDOWS 

