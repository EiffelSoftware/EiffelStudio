indexing

	description:
		"Information given by EiffelVision when an item is double-clicked in %
		%a scroll list"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	CLICK_DATA 

inherit 

	CONTEXT_DATA
		rename
			make as context_data_make
		end

create

	make

feature -- Initialization

	make (a_widget: WIDGET; a_position: INTEGER; an_item: STRING) is
			-- Create a context_data for `click' action.
		do
			widget := a_widget;
			position := a_position;
			item := an_item
		end

feature -- Access

	position: INTEGER;
			-- Position of the double-clicked item

	item: STRING;;
			-- Double-clicked item

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




end -- CLICK_DATA

