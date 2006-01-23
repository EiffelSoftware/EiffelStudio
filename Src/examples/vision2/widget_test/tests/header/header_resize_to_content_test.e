indexing
	description: "Objects that demonstrate EV_HEADER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER_RESIZE_TO_CONTENT_TEST
	
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
			instruction_label: EV_LABEL
		do
			create vertical_box
			create header
			header.pointer_button_press_actions.force_extend (agent resize_pointed_item)
			vertical_box.extend (header)
			create instruction_label.make_with_text ("Double click dividers to resize items to content")
			vertical_box.extend (instruction_label)
			from
				counter := 1
			until
				counter > 5
			loop
				create header_item.make_with_text ("Item " + counter.out)
				header_item.set_pixmap (numbered_pixmap ((counter \\ 2) + 1))
				header.extend (header_item)
				counter := counter + 1
			end
				-- Now set widths of header items
			header.i_th (1).set_width (20)
			header.i_th (2).set_width (20)
			header.i_th (3).set_width (200)
			header.i_th (4).set_width (20)
			header.i_th (5).set_width (40)
			
				-- We set a reasonable minimum height based on the height of the default
				-- font as retrieved from an EV_LABEL.
			header.set_minimum_size (300, numbered_pixmap (1).minimum_height + 6)
				
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	resize_pointed_item is
			-- Resize the item associated with the pointed divider index
			-- to the size of its contents.
		local
			pointed_index: INTEGER
		do
			pointed_index := header.pointed_divider_index
			if pointed_index > 0 then
				header.i_th (pointed_index).resize_to_content
			end
		end
		
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


end -- class HEADER_RESIZE_TO_CONTENT_TEST
