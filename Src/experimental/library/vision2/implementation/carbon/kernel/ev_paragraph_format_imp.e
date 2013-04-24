note
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

	make (an_interface: like interface)
			-- Create paragraph format
		do
			base_make (an_interface)
		end

	initialize
			-- Do nothing
		do
			set_is_initialized (True)
		end

feature -- Status report

	alignment: INTEGER
		-- Current alignment. See EV_PARAGRAPH_CONSTANTS
		-- for possible values.

	is_left_aligned: BOOLEAN
			-- Is `Current' left aligned?
		do
			Result := alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_left
		end

	is_center_aligned: BOOLEAN
			-- Is `Current' center aligned?
		do
			Result := alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_center
		end

	is_right_aligned: BOOLEAN
			-- Is `Current' right aligned?
		do
			Result := alignment = {EV_PARAGRAPH_CONSTANTS}.alignment_right
		end

	is_justified: BOOLEAN
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

	enable_left_alignment
			-- Ensure `is_left_aligned' is `True'.
		do
			set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_left)
		end

	enable_center_alignment
			-- Ensure `is_center_aligned' is `True'.
		do
			set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_center)
		end

	enable_right_alignment
			-- Ensure `is_right_aligned' is `True'.
		do
			set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_right)
		end

	enable_justification
			-- Ensure `is_justified' is `True'.
		do
			set_alignment ({EV_PARAGRAPH_CONSTANTS}.alignment_justified)
		end

	set_alignment (a_alignment: INTEGER)
			-- Set `alignment' to `a_alignment'
		do
			alignment := a_alignment
		end

	set_left_margin (a_margin: INTEGER)
			-- Set `left_margin' to `a_margin'.
		do
			left_margin := a_margin
		end

	set_right_margin (a_margin: INTEGER)
			-- Set `right_margin' to `a_margin'.
		do
			right_margin := a_margin
		end

	set_top_spacing (a_margin: INTEGER)
			-- Set `top_spacing' to `a_margin'.
		do
			top_spacing := a_margin
		end

	set_bottom_spacing (a_margin: INTEGER)
			-- Set `bottom_spacing' to `a_margin'.
		do
			bottom_spacing := a_margin
		end

feature {EV_RICH_TEXT_IMP} -- Implementation

	new_paragraph_tag_from_applicable_attributes (applicable_attributes: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION): POINTER
			--
		do

		end

	dummy_paragraph_format_range_information: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
			--
		do
			create Result.make_with_flags (
				{EV_PARAGRAPH_CONSTANTS}.alignment
				| {EV_PARAGRAPH_CONSTANTS}.left_margin
				| {EV_PARAGRAPH_CONSTANTS}.right_margin
				| {EV_PARAGRAPH_CONSTANTS}.top_spacing
				| {EV_PARAGRAPH_CONSTANTS}.bottom_spacing
			)
		end

feature {NONE} -- Implementation

	destroy
			-- Clean up `Current'
		do
			set_is_destroyed (True)
		end

note
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

