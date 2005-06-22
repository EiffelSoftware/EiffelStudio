indexing
	description: "Objects that demonstrate EV_HEADER"
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER_BASIC_TEST
	
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
		do
			create header
			from
				counter := 1
			until
				counter > 5
			loop
				create header_item.make_with_text ("Item " + counter.out)
				header.extend (header_item)
				counter := counter + 1
			end
				-- We set a reasonable minimum height based on the height of the default
				-- font as retrieved from an EV_LABEL.
			header.set_minimum_size (300, (create {EV_LABEL}).minimum_height + 3)
			
			widget := header
		end
		
feature {NONE} -- Implementation

	header: EV_HEADER
		-- Widget that test is to be performed on.

end -- class HEADER_TEST
