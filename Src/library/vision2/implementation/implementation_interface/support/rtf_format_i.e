indexing
	description: "Objects that hold the current formatting applied while loading a RTF file."
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
			
	character_format_out: STRING is
			-- Result is representation of character format attributes of `Current'.
			-- Paragraph and formats need to be buffered independently, hence a
			-- seperate out fetaure for each of these set of attributes.
		do
			Result := ""
			Result.append (character_format.out)
			Result.append (font_height.out)
			Result.append (text_color.out)
			Result.append (highlight_color.out)
			Result.append (is_bold.out)
			Result.append (is_italic.out)
			Result.append (is_striked_out.out)
			Result.append (is_underlined.out)
			Result.append (vertical_offset.out)
			Result.append (highlight_set.out)
			Result.append (color_set.out)
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
			Result := ""
			Result.append (alignment.out)
			Result.append (bottom_spacing.out)
			Result.append (top_spacing.out)
			Result.append (right_margin.out)
			Result.append (left_margin.out)
		end
	
feature -- Element change

	set_bottom_spacing (a_bottom_spacing: INTEGER) is
			-- Set `bottom_spacing' to `a_bottom_spacing'.
		require
			a_bottom_spacing_non_negative: a_bottom_spacing >= 0
		do
			bottom_spacing := a_bottom_spacing
		ensure
			bottom_spacing_assigned: bottom_spacing = a_bottom_spacing
		end

	set_top_spacing (a_top_spacing: INTEGER) is
			-- Set `top_spacing' to `a_top_spacing'.
		require
			a_top_spacing_non_negative: a_top_spacing >= 0
		do
			top_spacing := a_top_spacing
		ensure
			top_spacing_assigned: top_spacing = a_top_spacing
		end

	set_right_margin (a_right_margin: INTEGER) is
			-- Set `right_margin' to `a_right_margin'.
		require
			a_right_margin_non_negative: a_right_margin >= 0
		do
			right_margin := a_right_margin
		ensure
			right_margin_assigned: right_margin = a_right_margin
		end

	set_left_margin (a_left_margin: INTEGER) is
			-- Set `left_margin' to `a_left_margin'.
		require
			a_left_margin_non_negative: a_left_margin >= 0
		do
			left_margin := a_left_margin
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
		ensure
			text_color_assigned: text_color = a_text_color
		end

	set_bold (a_is_bold: BOOLEAN) is
			-- Set `is_bold' to `a_is_bold'.
		do
			is_bold := a_is_bold
		ensure
			is_bold_assigned: is_bold = a_is_bold
		end
		
	set_italic (an_is_italic: BOOLEAN) is
			-- Set `is_italic' to `an_is_italic'.
		do
			is_italic := an_is_italic
		ensure
			is_italic_assigned: is_italic = an_is_italic
		end

	set_striked_out (an_is_striked_out: BOOLEAN) is
			-- Set `is_striked_out' to `an_is_striked_out'.
		do
			is_striked_out := an_is_striked_out
		ensure
			is_striked_out_assigned: is_striked_out = an_is_striked_out
		end
		
	set_underlined (an_is_underlined: BOOLEAN) is
			-- Set `is_underlined' to `an_is_underlined'.
		do
			is_underlined := an_is_underlined
		ensure
			is_underlined: is_underlined = an_is_underlined
		end
		
	set_vertical_offset (an_offset: INTEGER) is
			-- Set `vertical_offset' to `an_offset'.
		do
			vertical_offset := an_offset
		ensure
			offset_set: vertical_offset = an_offset
		end

	set_font_height (a_font_height: INTEGER) is
			-- Set `font_height' to `a_font_height'.
		require
			a_font_height_positive: a_font_height > 0
		do
			font_height := a_font_height
		ensure
			font_height_assigned: font_height = a_font_height
		end

	set_character_format (a_character_format: INTEGER) is
			-- Set `character_format' to `a_character_format'.
		require
			a_character_format_non_negative: a_character_format >= 0
		do
			character_format := a_character_format
		ensure
			character_format_assigned: character_format = a_character_format
		end
		
	set_alignment (an_alignment: INTEGER) is
			-- Set `alignment' to `an_alignment'.
		require
			valid_alignment: valid_alignment (an_alignment)
		do
			alignment := an_alignment
		ensure
			alignment_set: alignment = an_alignment
		end

invariant
	character_format_non_negative: character_format >= 0
	font_height_positive: font_height > 0
	text_color_non_negative: text_color >= 0
	highlight_color_non_negative: highlight_color >= 0
	left_margin_non_negative: left_margin >= 0
	right_margin_non_negative: right_margin >= 0
	top_spacing_non_negative: top_spacing >= 0
	bottom_spacing_non_negative: bottom_spacing >= 0

end -- class RTF_FORMAT_I
