indexing
	description: "[
		Objects that contain all structures required for buffering RTF for saving/loading/implementation.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_BUFFERING_STRUCTURES_I
	
inherit
	EV_RICH_TEXT_CONSTANTS_I
		export
			{NONE} all
		end
	
feature -- Status Setting

	clear_structures is
			-- Clear all structures used for buffering into RTF format.
		do
				-- Rebuild structures used for buffering RTF.
			create start_formats.make (default_structure_size)
			create end_formats.make (default_structure_size)
			create formats.make (default_structure_size)
			create formats_index.make (default_structure_size)
			create heights.make (default_structure_size)
			create hashed_formats.make (default_structure_size)
			create format_offsets.make (default_structure_size)
			
				-- Rebuild structures used for optimizing contents of RTF.
				-- i.e. those that prevent repeated fonts and colors from being defined.
			create hashed_colors.make (default_structure_size)
			create color_offset.make (default_structure_size)
			create back_color_offset.make (default_structure_size)
			create hashed_fonts.make (default_structure_size)
			create font_offset.make (default_structure_size)

				-- Reset all other attributes used by buffering.			
			internal_text := ""
			internal_text.resize (default_string_size)
			is_current_format_underlined := False
			is_current_format_striked_through := False
			is_current_format_bold := False
			is_current_format_italic := False
			current_vertical_offset := 0
			color_text := color_table_start.twin
			font_text := font_table_start.twin
			font_count := 0
			color_count := 0
		end
		
feature -- Access

	internal_text: STRING
			-- Text used for building RTF strings internally before buffering or saving.
			
feature {NONE} -- Implementation

	default_structure_size: INTEGER is 20
		-- Default size used to initalize all buffering structures.

	default_string_size: INTEGER is 50000
		-- Default size used for all internal strings for buffering.
		-- This reduces the need to resize the string as the formatting is applied.
		-- Resizing strings can be slow, so is to be avoided wherever possible.

	-- `hashed_formats', `format_offsets' and `color_offsets' are only used in the
	-- buffered append operations, while the other lists and hash tables are used
	-- in the buffered formatting operations.

	hashed_formats: HASH_TABLE [EV_CHARACTER_FORMAT, STRING]
			-- A list of all character formats to be applied to buffering, accessible
			-- through `hash_value' of EV_CHARACTER_FORMAT. This ensures that repeated formats
			-- are not stored multiple times.
		
	format_offsets: HASH_TABLE [INTEGER, STRING]
			-- The index of each format in `hashed_formats' within the RTF document that must be generated.
			-- For each set of formatting that must be applied, a reference to the format in the document
			-- must be specified, and this table holds the appropriate offset of that formatting.

	buffered_text: STRING
		-- Internal representation of `text' used only when flushing the buffers. Prevents the need
		-- to stream the contents of `current', every time that the `text' is needed.
		
	lowest_buffered_value, highest_buffered_value: INTEGER
		-- Used when applying a buffered format, these values represent the lowest and highest character indexes
		-- that have been buffered. This allows implementations to only stream between these indexes if possible.
		
	formats: ARRAYED_LIST [EV_CHARACTER_FORMAT]
			-- All character formats used in `Current'.
		
	heights: ARRAYED_LIST [INTEGER]
			-- All heights of formats used in `Current', corresponding to contents of `forrmats'.

	formats_index: HASH_TABLE [INTEGER, INTEGER]
			-- The index of each format relative to a paticular character index. This permits the correct
			-- format to be looked up when the start positions of the formats are traversed.

	start_formats: HASH_TABLE [STRING, INTEGER]
			-- The format type applicable at a paticular character position. The `item' is used to look up the
			-- character format from `hashed_formats'.

	end_formats: HASH_TABLE [STRING, INTEGER]
			-- The format type applicable at a paticular character position. The integer represents the index of the
			-- closing caret index.

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
