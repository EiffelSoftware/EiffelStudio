indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHARACTER_FORMAT_IMP

inherit
	EV_CHARACTER_FORMAT_I
		undefine
			copy, is_equal
		end

	IDENTIFIED
		undefine
			out
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create character format
		do
		end

	initialize
			-- Do nothing
		do
		end

feature -- Access

	font: EV_FONT
			-- Font of the current format
		do
			create Result.default_create
		end

	color: EV_COLOR
			-- Color of the current format
		do
		end

	background_color: EV_COLOR
			-- Background Color of the current format
		do
		end

	effects: EV_CHARACTER_FORMAT_EFFECTS
			-- Character format effects applicable to `font'
		do
		end

feature -- Status setting

	set_font (a_font: EV_FONT)
			-- Make `value' the new font
		do
		end

	set_font_attributes (a_name: STRING_GENERAL; a_family, a_point_height, a_weight, a_shape, a_charset: INTEGER)
			-- Set internal font attributes
		do
		end

	set_color (a_color: EV_COLOR)
			-- Make `value' the new color
		do
		end

	set_fcolor (a_red, a_green, a_blue: INTEGER)
			-- Pack `fcolor' with `a_red', `a_green' and `a_blue'
		do
		end

	set_bcolor (a_red, a_green, a_blue: INTEGER)
			-- Pack `bcolor' with `a_red', `a_green' and `a_blue'
		do
		end

	set_background_color (a_color: EV_COLOR)
			-- Make `value' the new color
		do
		end

	set_effects (an_effect: EV_CHARACTER_FORMAT_EFFECTS)
			-- Make `an_effect' the new `effects'
		do
		end

	set_effects_internal (a_underlined, a_striked_out: BOOLEAN; a_vertical_offset: INTEGER)
			--
		do
		end

feature {EV_RICH_TEXT_IMP} -- Implementation

	dummy_character_format_range_information: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		once
		end

	apply_character_format_to_text_buffer (applicable_attributes: EV_CHARACTER_FORMAT_RANGE_INFORMATION; a_text_buffer, a_start_iter, a_end_iter: POINTER)
			-- Apply `Current' to `a_text_buffer' to the region bounded by `a_start_iter' and `a_end_iter'
		do
		end


	new_text_tag_from_applicable_attributes (applicable_attributes: EV_CHARACTER_FORMAT_RANGE_INFORMATION): POINTER
			-- Create a new text tag based on state of `Current'
		do
		end

	family_string: STRING
			-- String optimization
		once
		end

	size_string: STRING
			-- String optimization
		once
		end

	style_string: STRING
			-- String optimization
		once
		end

	weight_string: STRING
			-- String optimization
		once
		end

	foreground_string: STRING
			-- String optimization
		once
		end

	background_string: STRING
			-- String optimization
		once
		end

	underline_string: STRING
			-- String optimization
		once
		end

	strikethrough_string: STRING
			-- String optimization
		once
		end

	rise_string: STRING
			-- String optimization
		once
		end

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP
			--
		once
		end

	name: STRING_32
			-- Face name used by `Current'.

	family: INTEGER
			-- Family used by `Current'.

	height: INTEGER
			--  Height of `Current' in screen pixels.
		do
		end

	height_in_points: INTEGER
			-- Height of `Current' in points.

	weight: INTEGER
			-- Weight of `Current'.

	is_bold: BOOLEAN
			-- Is `Current' bold?
		do
		end

	shape: INTEGER
			-- Shape of `Current'.

	char_set: INTEGER
			-- Char set used by `Current'.

	is_underlined: BOOLEAN
			-- Is `Current' underlined?

	is_striked_out: BOOLEAN
			-- Is `Current' striken out?

	vertical_offset: INTEGER
			-- Vertical offset of `Current'.

	fcolor: INTEGER
			-- foreground color BGR packed into 24 bit.

	bcolor: INTEGER
			-- background color BGR packed into 24 bit.

	destroy
			-- Clean up
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




end -- class EV_CHARACTER_FORMAT_IMP

