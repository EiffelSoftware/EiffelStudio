indexing

	description:
		"Information given by EiffelVision when a mouse's button click. %
		%X event associated: `ButtonRelease'"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	BUTCLICK_DATA 

obsolete
	"button click actions will be removed therefor Current class will %
		%not be needed."

inherit

	BUTREL_DATA
		rename
			make as button_rel_data_make
		end

create

	make

feature -- Initialization

	make (a_widget: WIDGET; a_relative_x, a_relative_y, an_absolute_x, an_absolute_y, a_button: INTEGER; a_buttons_state: BUTTONS) is
			-- Create a context_data for `ButtonClick' event.
		do
			widget := a_widget;
			relative_x := a_relative_x;
			relative_y := a_relative_y;
			absolute_x := an_absolute_x;
			absolute_y := an_absolute_y;
			button := a_button;
			buttons_state := a_buttons_state
		end

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




end -- class BUTCLICK_DATA

