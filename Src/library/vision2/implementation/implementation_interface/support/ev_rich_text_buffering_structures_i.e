indexing
	description: "[
		Objects that contain all structures required for buffering RTF for saving/loading/implementation.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_BUFFERING_STRUCTURES_I

feature -- Access

			-- These attributes are used to stop multiple versions of the same color being
			-- generated in the RTF.

	hashed_colors: HASH_TABLE [INTEGER, STRING]
			-- All colors currently stored for buffering, accessible via the
			-- actual RTF output, in the form ";\red255\green0\blue0". The integer `item'
			-- corresponds to the offset of the color in `colors'.
		
	color_offset: ARRAYED_LIST [INTEGER]
			-- All color indexes to use for foreground colors in document,
			-- indexed by their corresponding character format index.
			-- So, for example, item 20 would correspond to the color offset to use from
			-- the color table for the 20th character format.
		
	back_color_offset: ARRAYED_LIST [INTEGER]
			-- All color indexes to use for background colors in document,
			-- indexed by their corresponding character format index.
			-- So, for example, item 20 would correspond to the color offset to use from
			-- the color table for the 20th character format.
			
	color_count: INTEGER
		-- Number of colors currently buffered.		
	
	color_text: STRING
		-- The RTF string correponding to all colors in the document.
		
			-- These attributes are used to stop multiple versions of the same font being
			-- generate in the RTF.
			
	hashed_fonts: HASH_TABLE [INTEGER, STRING]
			-- All fonts currently stored for buffering, accessible via the
			-- actual RTF output, in the form "\froman\fcharset0 System". The integer `item'
			-- corresponds to the offset of the font in `fonts'.
	
	font_offset: ARRAYED_LIST [INTEGER]
			-- All font indexes  in document,
			-- indexed by their corresponding character format index.
			-- So, for example, item 20 would correspond to the font offset to use from
			-- the font table for the 20th character format.
	
	font_count: INTEGER
		-- Number of fonts currently buffered.
	
	font_text:STRING
		-- The RTF string corresponding to all fonts in the document.
		
	is_current_format_underlined: BOOLEAN
	is_current_format_striked_through: BOOLEAN
	is_current_format_bold: BOOLEAN
	is_current_format_italic: BOOLEAN
	current_vertical_offset: INTEGER
		-- Booleans used to determine current formatting. These are used to prevent
		-- repeatedly opening the same tags each time a new format is encountered.

end -- class EV_RICH_TEXT_BUFFERING_STRUCTURES_I
