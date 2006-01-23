indexing

	description:
		"Information given by EiffelVision when a window is placed on top %
		%or on bottom of the stacking order. %
		%X event associated: `CirculateNotify'"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CIRCNOT_DATA 

obsolete
	"Use class CONTEXT_DATA instead."

inherit

	CONTEXT_DATA
		rename
			make as context_data_make
		end

create

	make

feature 

	make (a_widget: WIDGET; arg_is_placed_on_top: BOOLEAN) is
			-- Create a context_data for `CirculateNotify' event.
		do
			widget := a_widget;
			is_placed_on_top := arg_is_placed_on_top
		end;

	is_placed_on_top: BOOLEAN;
			-- Is the window placed on top of stacking order ?

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

