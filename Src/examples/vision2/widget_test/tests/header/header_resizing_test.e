indexing
	description: "Objects that demonstrate EV_HEADER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER_RESIZING_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			counter: INTEGER
			header_item: EV_HEADER_ITEM
			vertical_box: EV_VERTICAL_BOX
		do
			create vertical_box
			create header
			vertical_box.extend (header)
			create output
			vertical_box.extend (output)
			output.set_minimum_height (200)
			header.item_resize_start_actions.extend (agent header_item_started_resizing)
			header.item_resize_actions.extend (agent header_item_resizing)
			header.item_resize_end_actions.extend (agent header_item_ended_resizing)
			from
				counter := 1
			until
				counter > 5
			loop
				create header_item.make_with_text ("Resize Me")
				header.extend (header_item)
				counter := counter + 1
			end
				-- We set a reasonable minimum height based on the height of the default
				-- font as retrieved from an EV_LABEL.
			header.set_minimum_size (300, (create {EV_LABEL}).minimum_height + 3)
			
			widget := vertical_box
		end
		
	header_item_started_resizing (a_header_item: EV_HEADER_ITEM) is
			-- A header item has started resizing in `Current'.
		do
			output.append_text ("Header item " + header.index_of (a_header_item, 1).out + " start resizing%N")	
		end
		
	header_item_resizing (a_header_item: EV_HEADER_ITEM) is
			-- A header item is being resized in `Current'.
		do
			output.append_text ("Header item " + header.index_of (a_header_item, 1).out + " resizing to width : " + a_header_item.width.out + "%N")
		end
		
	header_item_ended_resizing (a_header_item: EV_HEADER_ITEM) is
			-- A header item has ended resizing in `Current'.
		do
			output.append_text ("Header item " + header.index_of (a_header_item, 1).out + " end resizing%N")
		end
		
		
feature {NONE} -- Implementation

	output: EV_TEXT

	header: EV_HEADER;
		-- Widget that test is to be performed on.

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


end -- class HEADER_RESIZING_TEST
