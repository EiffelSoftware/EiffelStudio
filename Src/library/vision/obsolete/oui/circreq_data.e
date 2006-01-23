indexing

	description: 
		"Information given by EiffelVision when a window is asked to be placed %
		%on top or on bottom of the stacking order. %
		%The values in this class indicates the hints of the request. %
		%X event associated: `CirculateRequest'"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CIRCREQ_DATA 

obsolete
	"Use class CONTEXT_DATA instead."

inherit

	CIRCNOT_DATA
		rename
			make as circnot_data_make
		end

create

	make

feature 

	make (a_widget: WIDGET; arg_is_placed_on_top: BOOLEAN) is
			-- Create a context_data for `CirculateRequest' event.
		do
			circnot_data_make (a_widget, arg_is_placed_on_top)
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




end

