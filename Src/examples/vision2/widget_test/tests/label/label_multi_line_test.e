indexing
	description: "Objects that demonstrate a multi line EV_LABEL."
	date: "$Date$"
	revision: "$Revision$"

class
	LABEL_MULTI_LINE_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
				-- Create `label' using `make_with_text'.
			create label.make_with_text ("A text%Nwhich%Nspans%Nmultiple lines.")
			
			widget := label
		end
		
feature {NONE} -- Implementation

	label: EV_LABEL
		-- Widget that test is to be performed on.

end -- class LABEL_MULTI_LINE_TEST
