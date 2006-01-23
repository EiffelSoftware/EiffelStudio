indexing
	description: "Objects that hold the current formatting applied while loading a RTF file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RTF_FORMAT_I
	
inherit
	EV_PARAGRAPH_CONSTANTS
		rename
			alignment as alignment_constant,
			left_margin as left_margin_constant,
			right_margin as right_margin_constant,
			top_spacing as top_spacing_constant,
			bottom_spacing as bottom_spacing_constant
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create `Current'
		do
			alignment := alignment_left
			reset_internals
		end

feature -- Access

	highlight_color: INTEGER
				-- Highlighting applied to text.
			
	highlight_set: BOOLEAN
			-- Has `highlight_color' been explicitly set and does not correspond to auto?

	text_color: INTEGER
			-- Text color of format
			
	color_set: BOOLEAN
			-- Has `text_color' been explicitly set and does not correspond to auto?

	is_bold: BOOLEAN
			-- Is format bold?
			
	is_italic: BOOLEAN
			-- Is format italic?
			
	is_striked_out: BOOLEAN
			-- Is format striken out?
			
	is_underlined: BOOLEAN
			-- Is format underlined?
			
	vertical_offset: INTEGER
			-- Vertical offset in pixels.

	font_height: INTEGER
			-- Height of font used by format.

	character_format: INTEGER
			-- Current character format index.

	boolean_out (a_boolean: BOOLEAN): STRING is
			-- 
		do
			if a_boolean then
				Result := true_constant
			else
				Result := false_constant
			end
		end
		
	true_constant: STRING is "T"
	false_constant: STRING is "F"
		
			
	character_format_out: STRING is
			-- Result is representation of character format attributes of `Current'.
			-- Paragraph and formats need to be buffered independently, hence a
			-- seperate out fetaure for each of these set of attributes.
		do
			if internal_character_format_out = Void then
				create Result.make (30)
				Result.append_integer (highlight_color)
				Result.append (boolean_out (is_bold))
				Result.append_integer (character_format)
				Result.append (boolean_out (is_italic))
				Result.append_integer (font_height)
				Result.append (boolean_out (is_striked_out))
				Result.append_integer (text_color)
				Result.append (boolean_out (is_underlined))
				Result.append_integer (vertical_offset)
				Result.append (boolean_out (highlight_set))
				Result.append (boolean_out (color_set))
				internal_character_format_out := Result
			else
				Result := internal_character_format_out
			end
		end
		
feature -- Access
	
	alignment: INTEGER
			-- Alignment of text.
			
	bottom_spacing: INTEGER
			-- Bottom spacing

	top_spacing: INTEGER
			-- Top spacing

	right_margin: INTEGER
			-- Right margin

	left_margin: INTEGER
			-- Left margin
			
	reset_paragraph is
			-- Ensure all paragraph formatting attributes are reset to
			-- default values.
		do
			alignment := alignment_left
			left_margin := 0
			right_margin := 0
			top_spacing := 0
			bottom_spacing := 0
			reset_internals
		ensure
			alignment = alignment_left
			left_margin = 0
			right_margin = 0
			top_spacing = 0
			bottom_spacing = 0
		end

	paragraph_format_out: STRING is
			-- Result is representation of paragraph format attributes of `Current'.
			-- Paragraph and formats need to be buffered independently, hence a
			-- seperate out fetaure for each of these set of attributes.
		do
				if internal_paragraph_format_out = Void then
					create Result.make (16)
					Result.append_integer (alignment)
					Result.append_integer (bottom_spacing)
					Result.append_integer (top_spacing)
					Result.append_integer (right_margin)
					Result.append_integer (left_margin)
					internal_paragraph_format_out := Result
				else
					Result := internal_paragraph_format_out
				end
		end
	
feature -- Element change

	set_bottom_spacing (a_bottom_spacing: INTEGER) is
			-- Set `bottom_spacing' to `a_bottom_spacing'.
		require
			a_bottom_spacing_non_negative: a_bottom_spacing >= 0
		do
			bottom_spacing := a_bottom_spacing
			reset_internals
		ensure
			bottom_spacing_assigned: bottom_spacing = a_bottom_spacing
		end

	set_top_spacing (a_top_spacing: INTEGER) is
			-- Set `top_spacing' to `a_top_spacing'.
		require
			a_top_spacing_non_negative: a_top_spacing >= 0
		do
			top_spacing := a_top_spacing
			reset_internals
		ensure
			top_spacing_assigned: top_spacing = a_top_spacing
		end

	set_right_margin (a_right_margin: INTEGER) is
			-- Set `right_margin' to `a_right_margin'.
		require
			a_right_margin_non_negative: a_right_margin >= 0
		do
			right_margin := a_right_margin
			reset_internals
		ensure
			right_margin_assigned: right_margin = a_right_margin
		end

	set_left_margin (a_left_margin: INTEGER) is
			-- Set `left_margin' to `a_left_margin'.
		require
			a_left_margin_non_negative: a_left_margin >= 0
		do
			left_margin := a_left_margin
			reset_internals
		ensure
			left_margin_assigned: left_margin = a_left_margin
		end

	set_highlight_color (a_highlight_color: INTEGER) is
			-- Set `highlight_color' to `a_highlight_color'.
		require
			a_highlight_color_non_negative: a_highlight_color >= 0
		do
			highlight_color := a_highlight_color
			highlight_set := True
			reset_internals
		ensure
			highlight_color_assigned: highlight_color = a_highlight_color
		end

	set_text_color (a_text_color: INTEGER) is
			-- Set `text_color' to `a_text_color'.
		require
			a_text_color_non_negative: a_text_color >= 0
		do
			text_color := a_text_color
			color_set := True
			reset_internals
		ensure
			text_color_assigned: text_color = a_text_color
		end

	set_bold (a_is_bold: BOOLEAN) is
			-- Set `is_bold' to `a_is_bold'.
		do
			is_bold := a_is_bold
			reset_internals
		ensure
			is_bold_assigned: is_bold = a_is_bold
		end
		
	set_italic (an_is_italic: BOOLEAN) is
			-- Set `is_italic' to `an_is_italic'.
		do
			is_italic := an_is_italic
			reset_internals
		ensure
			is_italic_assigned: is_italic = an_is_italic
		end

	set_striked_out (an_is_striked_out: BOOLEAN) is
			-- Set `is_striked_out' to `an_is_striked_out'.
		do
			is_striked_out := an_is_striked_out
			reset_internals
		ensure
			is_striked_out_assigned: is_striked_out = an_is_striked_out
		end
		
	set_underlined (an_is_underlined: BOOLEAN) is
			-- Set `is_underlined' to `an_is_underlined'.
		do
			is_underlined := an_is_underlined
			reset_internals
		ensure
			is_underlined: is_underlined = an_is_underlined
		end
		
	set_vertical_offset (an_offset: INTEGER) is
			-- Set `vertical_offset' to `an_offset'.
		do
			vertical_offset := an_offset
			reset_internals
		ensure
			offset_set: vertical_offset = an_offset
		end

	set_font_height (a_font_height: INTEGER) is
			-- Set `font_height' to `a_font_height'.
		require
			a_font_height_positive: a_font_height > 0
		do
			font_height := a_font_height
			reset_internals
		ensure
			font_height_assigned: font_height = a_font_height
		end

	set_character_format (a_character_format: INTEGER) is
			-- Set `character_format' to `a_character_format'.
		require
			a_character_format_non_negative: a_character_format >= 0
		do
			character_format := a_character_format
			reset_internals
		ensure
			character_format_assigned: character_format = a_character_format
		end
		
	set_alignment (an_alignment: INTEGER) is
			-- Set `alignment' to `an_alignment'.
		require
			valid_alignment: valid_alignment (an_alignment)
		do
			alignment := an_alignment
			reset_internals
		ensure
			alignment_set: alignment = an_alignment
		end

feature {NONE} -- Implementation

	internal_character_format_out: STRING
			-- Once per object for `character_format_out'.
			
	internal_paragraph_format_out: STRING
			-- Once per object for `paragraph_format_out'.

	reset_internals is
			-- Reset `internal_character_format_out'.
		do
				internal_character_format_out := Void
				internal_paragraph_format_out := Void
		ensure
			internal_character_format_out_reset: internal_character_format_out = Void
		end
		
invariant
	character_format_non_negative: character_format >= 0
	font_height_non_negative: font_height >= 0
	text_color_non_negative: text_color >= 0
	highlight_color_non_negative: highlight_color >= 0
	left_margin_non_negative: left_margin >= 0
	right_margin_non_negative: right_margin >= 0
	top_spacing_non_negative: top_spacing >= 0
	bottom_spacing_non_negative: bottom_spacing >= 0

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




end -- class RTF_FORMAT_I

