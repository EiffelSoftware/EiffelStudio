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
		
	left_margin: INTEGER
		-- Left margin between border and text in pixels
		
	right_margin: INTEGER
		-- Right margin between line end and border in pixels
		
	top_spacing: INTEGER
		-- Spacing between top of paragraph and previous line in pixels.
		
	bottom_spacing: INTEGER
		-- Spacing between bottom of paragraph and next line in pixels.

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
		
	set_left_margin (a_margin: INTEGER) is
			-- Set `left_margin' to `a_margin'.
		require
			margin_non_negative: a_margin >= 0
		do
			left_margin := a_margin
		ensure
			margin_set: left_margin = a_margin
		end

	set_right_margin (a_margin: INTEGER) is
			-- Set `right_margin' to `a_margin'.
		require
			margin_non_negative: a_margin >= 0
		do
			right_margin := a_margin
		ensure
			margin_set: right_margin = a_margin
		end
		
	set_top_spacing (a_margin: INTEGER) is
			-- Set `top_spacing' to `a_margin'.
		require
			margin_non_negative: a_margin >= 0
		do
			top_spacing := a_margin
		ensure
			margin_set: top_spacing = a_margin
		end
		
	set_bottom_spacing (a_margin: INTEGER) is
			-- Set `bottom_spacing' to `a_margin'.
		require
			margin_non_negative: a_margin >= 0
		do
			bottom_spacing := a_margin
		ensure
			margin_set: bottom_spacing = a_margin
		end

invariant
	valid_alignment: (create {EV_PARAGRAPH_CONSTANTS}).valid_alignment (alignment)

end -- class EV_PARAGRAPH_FORMAT
