indexing
	description: "Objects that demonstrate EV_TOOL_BAR"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOOL_BAR_RADIO_BUTTON_TEST
	
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
			tool_bar_button: EV_TOOL_BAR_RADIO_BUTTON
		do
			create tool_bar
			from
				counter := 1
			until
				counter > 5
			loop
				create tool_bar_button
				tool_bar_button.set_pixmap (numbered_pixmap (counter \\ 2 + 1))
				tool_bar.extend (tool_bar_button)
				counter := counter + 1
			end
			
			widget := tool_bar
		end
		
feature {NONE} -- Implementation

	tool_bar: EV_TOOL_BAR
	
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

end -- class TOOL_BAR_RADIO_BUTTON_TEST
