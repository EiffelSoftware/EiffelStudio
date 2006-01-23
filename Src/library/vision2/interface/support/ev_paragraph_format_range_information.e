indexing
	description: "[
		Objects that provide information for a range of lines in an EV_RICH_TEXT.
		Depending on the query applied to `Current', the values of all attributes are used in different
		fashions, sometimes to indicate which fields of an EV_PARAGRAPH_FORMAT are valid, or have a particular
		property. The applicable features in EV_RICH_TEXT which use `Current' provide full descriptions.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
	
inherit
	ANY

	EV_PARAGRAPH_CONSTANTS
		rename
			alignment as alignment_flag,
			left_margin as left_margin_flag,
			right_margin as right_margin_flag,
			top_spacing as top_spacing_flag,
			bottom_spacing as bottom_spacing_flag
		export
			{NONE} all
			{ANY} valid_alignment, valid_paragraph_flag
		end
	
create
	make_with_flags
	
feature -- Creation

	make_with_flags (flags: INTEGER) is
			-- Create `Current' and apply `flags' to set attributes.
			-- Valid flags are the corresponding flags from EV_PARAGRAPH_CONSTANTS.
			-- Combine these in `flags' to set multiple attrbutes, e.g. to set the
			-- left and right margins as applicable peform:
			-- "make_with_flags (feature {EV_PARAGRAPH_CONSTANTS}.left_margin | feature {EV_PARAGRAPH_CONSTANTS}.right_margin)"
		require
			valid_paragraph_flag: valid_paragraph_flag (flags)
		do
			alignment := flags | {EV_PARAGRAPH_CONSTANTS}.alignment = flags
			left_margin := flags | {EV_PARAGRAPH_CONSTANTS}.left_margin = flags
			right_margin := flags | {EV_PARAGRAPH_CONSTANTS}.right_margin = flags
			top_spacing := flags | {EV_PARAGRAPH_CONSTANTS}.top_spacing = flags
			bottom_spacing := flags | {EV_PARAGRAPH_CONSTANTS}.bottom_spacing = flags
		ensure
			attributes_set: alignment = (flags | {EV_PARAGRAPH_CONSTANTS}.alignment = flags) and
				left_margin = (flags | {EV_PARAGRAPH_CONSTANTS}.left_margin = flags) and
				right_margin = (flags | {EV_PARAGRAPH_CONSTANTS}.right_margin = flags) and
				top_spacing = (flags | {EV_PARAGRAPH_CONSTANTS}.top_spacing = flags) and
				bottom_spacing = (flags | {EV_PARAGRAPH_CONSTANTS}.bottom_spacing = flags)
		end

feature -- Access
	
	alignment: BOOLEAN
		-- Is alignment of paragraph applicable?
		
	left_margin: BOOLEAN
		-- Is left margin of paragraph applicable?
		
	right_margin: BOOLEAN
		-- Is right margin of paragraph applicable?
		
	top_spacing: BOOLEAN
		-- Is top spacing of paragraph applicable?
		
	bottom_spacing: BOOLEAN;
		-- Is bottom spacing of paragraph applicable?

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




end -- class EV_PARAGRAPH_FORMAT_RANGE_INFORMATION

