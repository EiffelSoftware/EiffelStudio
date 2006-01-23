indexing

	description: "Information given by EiffelVision when a callback is triggered"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	MODIFY_DATA 

inherit 

	MOTION_DATA
		rename
			make as motion_make
		end

create

	make

feature -- Initialization

	make (a_widget: WIDGET; a_current, a_next, a_start, a_last: INTEGER; a_text: STRING) is
			-- Create a context_data `modify' action.
		do
			widget := a_widget;
			current_cursor_position := a_current;
			next_cursor_position := a_next;
			start_position := a_start;
			last_position := a_last;
			text := a_text
		end

feature -- Access

	start_position: INTEGER;
			-- Start position of the text to be modified

	last_position: INTEGER;
			-- Last position of the text to be modified

	text: STRING;;
			-- Text to be inserted between `start_position' and `last_position'

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




end -- class MODIFY_DATA

