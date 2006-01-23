indexing

	description: "Information given by EiffelVision when a callback is triggered"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	MOTION_DATA 

inherit 

	CONTEXT_DATA
		rename
			make as context_data_make
		end

create

	make

feature -- Initialization

	make (a_widget: WIDGET; a_current, a_next: INTEGER) is
			-- Create a context_data for `motion' action.
		do
			widget := a_widget;
			current_cursor_position := a_current;
			next_cursor_position := a_next
		end

feature -- Access

	current_cursor_position: INTEGER;
			-- Position of cursor at current time (before its motion)

	next_cursor_position: INTEGER;;
			-- Future position of cursor if the motion is agreed

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




end -- class MOTION_DATA

