indexing
	description: "Objects that test EV_FRAME."
	date: "$Date$"
	revision: "$Revision$"

class
	FRAME_BASIC_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
				-- Create `frame' using `make_with_text'.
			create frame.make_with_text ("A Frame")
				-- Assign a minimum size.
			frame.set_minimum_size (200, 200)
			
			widget := frame
		end
		
feature {NONE} -- Implementation

	frame: EV_FRAME
		-- Widget that test is to be performed on.

end -- class FRAME_BASIC_TEST
