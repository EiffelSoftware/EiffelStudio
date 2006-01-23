indexing

	description:
		"Information given by EiffelVision when the pointer enters a window. %
		%X event associated: `EnterNotify'"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class ENTER_DATA 

obsolete
	"Use class CONTEXT_DATA instead."

inherit

	CONTEXT_DATA
		undefine
			make
		end

create

	make

feature {NONE}

	absolute_x: INTEGER;
            -- Absolute horizontal position of the point of entry of the
			-- pointer

    absolute_y: INTEGER;
            -- Absolute vertical position of the point of entry of the
			-- pointer

    relative_x: INTEGER;
            -- Horizontal position of the point of entry of the pointer
			-- relative to the receiving window

    relative_y: INTEGER;
            -- Vertical position of the point of entry of the pointer relative
			-- to the receiving window

feature 

	make (a_widget: WIDGET) is
			-- Create a context_data for `EnterNotify' event.
		do
			widget := a_widget
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




end -- class ENTER_DATA

