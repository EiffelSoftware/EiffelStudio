indexing
	description: "Objects that simulate an EV_COMBO_BOX in an EV_TOOL_BAR"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_COMBO_BOX_TEST
	
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
			counter: INTEGER
			tool_bar_button: EV_TOOL_BAR_BUTTON
			horizontal_box: EV_HORIZONTAL_BOX
			list_item: EV_LIST_ITEM
		do
			create left_bar
			create right_bar
			create combo_box
			combo_box.set_minimum_width (150)
			from
				counter := 1
			until
				counter > 5
			loop
				create tool_bar_button
				tool_bar_button.set_pixmap (numbered_pixmap (counter \\ 2 + 1))
				left_bar.extend (tool_bar_button)
				
				create tool_bar_button
				tool_bar_button.set_pixmap (numbered_pixmap (counter \\ 2 + 1))
				right_bar.extend (tool_bar_button)
				
				create list_item.make_with_text ("Item " + counter.out)
				combo_box.extend (list_item)
				
				counter := counter + 1
			end
			
			create horizontal_box
			horizontal_box.extend (left_bar)
			horizontal_box.extend (combo_box)
			horizontal_box.extend (right_bar)
			horizontal_box.disable_item_expand (left_bar)
			horizontal_box.disable_item_expand (combo_box)

			widget := horizontal_box
		end
		
feature {NONE} -- Implementation

	left_bar, right_bar: EV_TOOL_BAR
	
	combo_box: EV_COMBO_BOX
	
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

end -- class TOOL_BAR_COMBO_BOX_TEST
