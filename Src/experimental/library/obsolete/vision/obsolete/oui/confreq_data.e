note

	description:
		"Information given by EiffelVision when a window's configuration is %
		%asked to change. %
		%The values in this class indicates the hints of the request. %
		%X event associated: `ConfigureRequest'"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CONFREQ_DATA 

obsolete
	"Use class CONTEXT_DATA instead."

inherit

	CONFNOT_DATA
		rename
			make as confnot_data_make
		end

create

	make

feature 

	make (a_widget: WIDGET; a_x, a_y, a_width, a_height, a_border_width: INTEGER)
			-- Create a context_data for `ConfigureRequest' event.
		do
			confnot_data_make (a_widget, a_x, a_y, a_width, a_height, a_border_width)
		end

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




end

