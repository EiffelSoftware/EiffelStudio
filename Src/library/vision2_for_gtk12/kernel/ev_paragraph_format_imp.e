indexing
	description: "Objects that represent paragraph formatting information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PARAGRAPH_FORMAT_IMP
	
inherit
	EV_PARAGRAPH_FORMAT_I
	
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create paragraph format
		do
			base_make (an_interface)
		end

	initialize is
			-- Do nothing
		do
			set_is_initialized (True)
		end
		
feature -- Status report

	alignment: INTEGER
		-- Current alignment. See EV_PARAGRAPH_CONSTANTS
		-- for possible values.

	is_left_aligned: BOOLEAN is
			-- Is `Current' left aligned?
		do
			Result := alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_left
		end
		
	is_center_aligned: BOOLEAN is
			-- Is `Current' center aligned?
		do
			Result := alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_center
		end
	
	is_right_aligned: BOOLEAN is
			-- Is `Current' right aligned?
		do
			Result := alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_right
		end
	
	is_justified: BOOLEAN is
			-- Is `Current' justified?
		do
			Result := alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_justified
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
			set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_left)
		end
		
	enable_center_alignment is
			-- Ensure `is_center_aligned' is `True'.
		do
			set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_center)
		end
		
	enable_right_alignment is
			-- Ensure `is_right_aligned' is `True'.
		do
			set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_right)
		end
		
	enable_justification is
			-- Ensure `is_justified' is `True'.
		do
			set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_justified)
		end

	set_alignment (a_alignment: INTEGER) is
			-- Set `alignment' to `a_alignment'
		do
			alignment := a_alignment
		end

	set_left_margin (a_margin: INTEGER) is
			-- Set `left_margin' to `a_margin'.
		do
			left_margin := a_margin
		end

	set_right_margin (a_margin: INTEGER) is
			-- Set `right_margin' to `a_margin'.
		do
			right_margin := a_margin
		end
		
	set_top_spacing (a_margin: INTEGER) is
			-- Set `top_spacing' to `a_margin'.
		do
			top_spacing := a_margin
		end
		
	set_bottom_spacing (a_margin: INTEGER) is
			-- Set `bottom_spacing' to `a_margin'.
		do
			bottom_spacing := a_margin
		end
		
feature {NONE} -- Implementation

	destroy is
			-- Clean up `Current'
		do
			
		end

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




end -- class EV_PARAGRAPH_FORMAT

