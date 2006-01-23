indexing
	description: "Objects that represent paragraph formatting information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PARAGRAPH_FORMAT
	
inherit
	EV_ANY
		redefine
			implementation,
			initialize
		end
		
feature {NONE} -- Initialization

	initialize is
			-- Perform initialization of `Current'.
		do
			enable_left_alignment
			is_initialized := True
		end
		
feature -- Status report

	alignment: INTEGER is
			-- Current alignment. See EV_PARAGRAPH_CONSTANTS
			-- for possible values.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.alignment
		end

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
		
	left_margin: INTEGER is
			-- Left margin between border and text in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.left_margin
		end
		
	right_margin: INTEGER is
			-- Right margin between line end and border in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.right_margin
		end
		
	top_spacing: INTEGER is
			-- Spacing between top of paragraph and previous line in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.top_spacing
		end
		
	bottom_spacing: INTEGER is
			-- Spacing between bottom of paragraph and next line in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.bottom_spacing
		end
		
feature -- Status setting

	enable_left_alignment is
			-- Ensure `is_left_aligned' is `True'.
		require
			not_destroyed: not is_destroyed
		do
			set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_left)
		ensure
			is_left_aligned: is_left_aligned
		end
		
	enable_center_alignment is
			-- Ensure `is_center_aligned' is `True'.
		require
			not_destroyed: not is_destroyed
		do
			set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_center)
		ensure
			is_center_aligned: is_center_aligned
		end
		
	enable_right_alignment is
			-- Ensure `is_right_aligned' is `True'.
		require
			not_destroyed: not is_destroyed
		do
			set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_right)
		ensure
			is_right_aligned: is_right_aligned
		end
		
	enable_justification is
			-- Ensure `is_justified' is `True'.
		require
			not_destroyed: not is_destroyed
		do
			set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_justified)
		ensure
			is_justified: is_justified
		end
		
	set_alignment (an_alignment: INTEGER) is
			-- Assign `an_alignment' to `alignment.
		require
			not_destroyed: not is_destroyed
			valid_alignment (an_alignment)
		do
			implementation.set_alignment (an_alignment)
		ensure
			alignment_set: alignment = an_alignment
		end

	set_left_margin (a_margin: INTEGER) is
			-- Set `left_margin' to `a_margin'.
		require
			not_destroyed: not is_destroyed
			margin_non_negative: a_margin >= 0
		do
			implementation.set_left_margin (a_margin)
		ensure
			margin_set: left_margin = a_margin
		end

	set_right_margin (a_margin: INTEGER) is
			-- Set `right_margin' to `a_margin'.
		require
			not_destroyed: not is_destroyed
			margin_non_negative: a_margin >= 0
		do
			implementation.set_right_margin (a_margin)
		ensure
			margin_set: right_margin = a_margin
		end
		
	set_top_spacing (a_spacing: INTEGER) is
			-- Set `top_spacing' to `a_spacing'.
		require
			not_destroyed: not is_destroyed
			spacing_non_negative: a_spacing >= 0
		do
			implementation.set_top_spacing (a_spacing)
		ensure
			spacing_set: top_spacing = a_spacing
		end
		
	set_bottom_spacing (a_spacing: INTEGER) is
			-- Set `bottom_spacing' to `a_spacing'.
		require
			not_destroyed: not is_destroyed
			spacing_non_negative: a_spacing >= 0
		do
			implementation.set_bottom_spacing (a_spacing)
		ensure
			spacing_set: bottom_spacing = a_spacing
		end
		
feature -- Contract Support

	valid_alignment (an_alignment: INTEGER): BOOLEAN is
			-- Is `an_alignment' a valid paragraph alignment?
		require
			not_destroyed: not is_destroyed
		do
			Result := an_alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_left or
				an_alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_center or
				an_alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_right or
				an_alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_justified
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_PARAGRAPH_FORMAT_I
			-- Implementation of the current object
		
feature {NONE} -- Implementation

	create_implementation is
			-- Create implementation of drawing area.
		do
			create {EV_PARAGRAPH_FORMAT_IMP} implementation.make (Current)
		end

invariant
	valid_alignment: (create {EV_PARAGRAPH_CONSTANTS}).valid_alignment (alignment)

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

