indexing
	description: "Objects that hold the current formatting applied while loading a RTF file."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RTF_FORMAT_I
	
inherit
	ANY
		redefine
			out
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
			
	out: STRING is
			-- New string containing terse printable representation
			-- of current object
		do
			Result := character_format.out + font_height.out + text_color.out +
				highlight_color.out + is_bold.out + is_italic.out + is_striked_out.out +
				is_underlined.out + vertical_offset.out + 
				highlight_set.out + color_set.out
		end

feature -- Element change

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

invariant
	character_format_non_negative: character_format >= 0
	font_height_positive: font_height > 0
	text_color_non_negative: text_color >= 0
	highlight_color_non_negative: highlight_color >= 0

end -- class RTF_FORMAT_I
