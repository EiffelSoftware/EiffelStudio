indexing
	description: "Objects that represent paragraph formatting information."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PARAGRAPH_FORMAT
	
inherit
	ANY
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Perform default creation of `Current'.
		do
			enable_left_alignment 
		end
		
feature -- Status report

	alignment: INTEGER
		-- Current alignment. See EV_PARAGRAPH_CONSTANTS
		-- for possible values.

	is_left_aligned: BOOLEAN is
			-- Is `Current' left aligned?
		do
			Result := alignment = feature {EV_PARAGRAPH_CONSTANTS}.alignment_left
		end
		
	is_center_aligned: BOOLEAN is
			-- Is `Current' center aligned?
		do
			Result := alignment = feature {EV_PARAGRAPH_CONSTANTS}.alignment_center
		end
	
	is_right_aligned: BOOLEAN is
			-- Is `Current' right aligned?
		do
			Result := alignment = feature {EV_PARAGRAPH_CONSTANTS}.alignment_right
		end
	
	is_justified: BOOLEAN is
			-- Is `Current' justified?
		do
			Result := alignment = feature {EV_PARAGRAPH_CONSTANTS}.alignment_justified
		end

feature -- Status setting

	enable_left_alignment is
			-- Ensure `is_left_aligned' is `True'.
		do
			alignment := feature {EV_PARAGRAPH_CONSTANTS}.alignment_left
		ensure
			is_left_aligned: is_left_aligned
		end
		
	enable_center_alignment is
			-- Ensure `is_center_aligned' is `True'.
		do
			alignment := feature {EV_PARAGRAPH_CONSTANTS}.alignment_center
		ensure
			is_center_aligned: is_center_aligned
		end
		
	enable_right_alignment is
			-- Ensure `is_right_aligned' is `True'.
		do
			alignment := feature {EV_PARAGRAPH_CONSTANTS}.alignment_right
		ensure
			is_right_aligned: is_right_aligned
		end
		
	enable_justification is
			-- Ensure `is_justified' is `True'.
		do
			alignment := feature {EV_PARAGRAPH_CONSTANTS}.alignment_justified
		ensure
			is_justified: is_justified
		end

invariant
	valid_alignment: (create {EV_PARAGRAPH_CONSTANTS}).valid_alignment (alignment)

end -- class EV_PARAGRAPH_FORMAT
