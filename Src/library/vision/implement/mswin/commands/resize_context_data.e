indexing

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class RESIZE_CONTEXT_DATA 

inherit

    CONTEXT_DATA
	rename
	    make as old_make
	end

create
    make

feature 

	make (a_widget: WIDGET; w,h, wparm : INTEGER) is
                        -- Create a context_data for `ResizeRequest' event.
		do
			widget := a_widget
			width := w
			height := h
			wparam := wparm
		end

feature -- Access

	height: INTEGER
	
	width: INTEGER

	wparam : INTEGER;

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




end -- class RESIZE_CONTEXT_DATA

