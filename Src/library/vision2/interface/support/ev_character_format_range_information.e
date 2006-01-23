indexing
	description: "[
		Objects that provide information for a range of characters in an EV_RICH_TEXT.
		Depending on the query applied to `Current', the values of all attributes are used in different
		fashions, sometimes to indicate which fields of an EV_CHARACTER_FORMAT are valid, or have a particular
		property. The applicable features in EV_RICH_TEXT which use `Current' provide full descriptions.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_RANGE_INFORMATION
	
inherit
	ANY

	EV_CHARACTER_FORMAT_CONSTANTS
		rename
			effects_vertical_offset as effects_vertical_offset_flag,
			effects_underlined as effects_underlined_flag,
			effects_striked_out as effects_striked_out_flag,
			background_color as background_color_flag,
			color as color_flag,
			font_height as font_height_flag,
			font_shape as font_shape_flag,
			font_weight as font_weight_flag,
			font_family as font_family_flag
		export
			{NONE} all
			{ANY} valid_character_format_flag
		end

create
	make_with_flags
	
feature -- Creation

	make_with_flags (flags: INTEGER) is
			-- Create `Current' and apply `flags' to set attributes.
			-- Valid flags are the corresponding flags from EV_CHARACTER_FORMAT_CONSTANTS.
			-- Combine these in `flags' to set multiple attrbutes, e.g. to set the
			-- font height and font color as applicable perform:
			-- "make_with_flags (feature {EV_CHARACTER_FORMAT_CONSTANTS}.font_height | feature {EV_CHARACTER_FORMAT_CONSTANTS}.color)"
		require
			valid_flags: valid_character_format_flag (flags)
		do
			font_family := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.font_family = flags
			font_weight := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.font_weight = flags
			font_shape := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.font_shape = flags
			font_height := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.font_height = flags
			color := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.color = flags
			background_color := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.background_color = flags
			effects_striked_out := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.effects_striked_out = flags
			effects_underlined := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.effects_underlined = flags
			effects_vertical_offset := flags | {EV_CHARACTER_FORMAT_CONSTANTS}.effects_vertical_offset = flags
		ensure
			attributes_set: font_family = (flags | {EV_CHARACTER_FORMAT_CONSTANTS}.font_family = flags) and
			font_weight = (flags | {EV_CHARACTER_FORMAT_CONSTANTS}.font_weight = flags) and
			font_shape = (flags | {EV_CHARACTER_FORMAT_CONSTANTS}.font_shape = flags) and
			font_height = (flags | {EV_CHARACTER_FORMAT_CONSTANTS}.font_height = flags) and
			color = (flags | {EV_CHARACTER_FORMAT_CONSTANTS}.color = flags) and
			background_color = (flags | {EV_CHARACTER_FORMAT_CONSTANTS}.background_color = flags) and
			effects_striked_out = (flags | {EV_CHARACTER_FORMAT_CONSTANTS}.effects_striked_out = flags) and
			effects_underlined = (flags | {EV_CHARACTER_FORMAT_CONSTANTS}.effects_underlined = flags) and
			effects_vertical_offset = (flags | {EV_CHARACTER_FORMAT_CONSTANTS}.effects_vertical_offset = flags)
		end

feature -- Access
	
	font_family: BOOLEAN
		-- Is family of font applicable?
	
	font_weight: BOOLEAN
		-- Is weight of font applicable?
	
	font_shape: BOOLEAN
		-- Is shape of font applicable?
	
	font_height: BOOLEAN
		-- Is height of font applicable?
		
	color: BOOLEAN
		-- Is color of font applicable?
		
	background_color: BOOLEAN
		-- Is background color of font applicable?
	
	effects_striked_out: BOOLEAN
		-- Is striked out effect of font applicable?
	
	effects_underlined: BOOLEAN
		-- Is underlined effect of font applicable?
		
	effects_vertical_offset: BOOLEAN;
		-- Is vertical offset effect of font applicable?

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




end -- class EV_CHARACTER_FORMAT_INFORMATION

