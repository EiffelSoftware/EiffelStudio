indexing
	description: "Objects that test EV_LIST."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_PIXMAP_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
	EXECUTION_ENVIRONMENT
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			list_item: EV_LIST_ITEM
			filename: FILE_NAME
			counter: INTEGER
			vertical_box: EV_VERTICAL_BOX
			reset_button: EV_BUTTON
		do
			create vertical_box
			create list
			vertical_box.extend (list)
			create reset_button.make_with_text_and_action ("Reset", agent reset)
			vertical_box.extend (reset_button)
			vertical_box.disable_item_expand (reset_button)
			vertical_box.set_minimum_size (300, 300)
			from
				counter := 1
			until
				counter > 25
			loop
				create list_item.make_with_text ("Item " + counter.out)
				list_item.select_actions.extend (agent select_pixmap)

				list_item.set_pixmap (numbered_pixmap (1))
				list.extend (list_item)
				counter := counter + 1
			end
			
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	list: EV_LIST
	
	numbered_pixmap (a_number: INTEGER): EV_PIXMAP is
			-- `Result' is pixmap named "image" + a_number.out.
		local
			filename: FILE_NAME
		do
			if all_loaded_pixmaps = Void then
				create all_loaded_pixmaps.make (2)
			end
			create filename.make_from_string (current_working_directory)
			filename.extend ("png")
			filename.extend ("image" + a_number.out + ".png")
			if all_loaded_pixmaps @ filename /= Void then
				Result := all_loaded_pixmaps @ filename
			else
				create Result
				Result.set_with_named_file (filename)	
				all_loaded_pixmaps.put (Result, filename)
			end
		end
		
	all_loaded_pixmaps: HASH_TABLE [EV_PIXMAP, STRING]
			-- All pixmaps laready loaded, referenced by their names.
			-- For quick access.
	
	select_pixmap is
			-- Assign `selected_pixmap' to `selected_item' of `list'.
		do
			list.selected_item.set_pixmap (numbered_pixmap (2))
		end

	reset is
			-- Revert all items in `list' to displaying `unselected_pixmap'.
		do
			from
				list.start
			until
				list.off
			loop
				list.item.set_pixmap (numbered_pixmap (1))
				list.forth
			end
		end
		

end -- class LIST_PIXMAP_TEST
