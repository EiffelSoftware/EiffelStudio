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
		
	EV_FONT_CONSTANTS
		export
			{NONE} all
		end
		
create
	set_rich_text

feature -- Status Setting

	set_rich_text (a_rich_text: EV_RICH_TEXT_I) is
			-- Assign `a_rich_text' to `rich_text' and initialize buffering structures.
		require
			a_rich_text_not_void: a_rich_text /= Void
		do
			rich_text := a_rich_text
			clear_structures
		end

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
			buffered_text := ""
		end
		
	initialize_for_saving is
			-- Initialize `Current' for saving'.
		do
			clear_structures
		end

	append_text_for_rtf (a_text: STRING; a_format: EV_CHARACTER_FORMAT) is
			-- Append RTF representation of `a_text' with format `a_format' to `internal_text'
			-- and store information required from `a_format' ready for completion of buffering.
		local
			hashed_character_format: STRING
			temp_string: STRING
			format_index: INTEGER
			vertical_offset, counter: INTEGER
			character: CHARACTER
			format_underlined, format_striked, format_bold, format_italic: BOOLEAN
			height_in_half_points: INTEGER
		do
			hashed_character_format := a_format.hash_value
			if not hashed_formats.has (hashed_character_format) then
				hashed_formats.put (a_format, hashed_character_format)
				formats.extend (a_format)
				heights.extend (pixels_to_half_points (a_format.font.height))
				format_offsets.put (hashed_formats.count, hashed_character_format)
			
				build_color_from_format (a_format)
				
				build_font_from_format (a_format)
			end

			format_index := format_offsets.item (hashed_character_format)
				
					-- Must clone otherwise we will always be modifying `highlight_string'.
			temp_string := highlight_string.twin
			temp_string.append (back_color_offset.i_th (format_index).out)
			temp_string.append (color_string)
			temp_string.append (color_offset.i_th (format_index).out)
			
			format_underlined := formats.i_th (format_index).effects.is_underlined
			if not is_current_format_underlined and format_underlined then
				temp_string.append (start_underline_string)
				is_current_format_underlined := True
			elseif is_current_format_underlined and not format_underlined then
				temp_string.append (end_underline_string)
				is_current_format_underlined := False
			end
			format_striked := formats.i_th (format_index).effects.is_striked_out
			if not is_current_format_striked_through and format_striked then
				temp_string.append (start_strikeout_string)
				is_current_format_striked_through := True
			elseif is_current_format_striked_through and not format_striked then
				temp_string.append (end_strikeout_string)
				is_current_format_striked_through := False
			end
			format_bold := formats.i_th (format_index).font.weight = feature {EV_FONT_CONSTANTS}.weight_bold
			if not is_current_format_bold and format_bold then
				temp_string.append (start_bold_string)
				is_current_format_bold := True
			elseif is_current_format_bold and not format_bold then
				temp_string.append (end_bold_string)
				is_current_format_bold := False
			end
			format_italic := formats.i_th (format_index).font.shape = feature {EV_FONT_CONSTANTS}.shape_italic
			if not is_current_format_italic and format_italic then
				temp_string.append (start_italic_string)
				is_current_format_italic := True
			elseif is_current_format_italic and not format_italic then
				temp_string.append (end_italic_string)
				is_current_format_italic := False
			end
			vertical_offset := formats.i_th (format_index).effects.vertical_offset
			if vertical_offset /= current_vertical_offset then
				temp_string.append (start_vertical_offset)
				height_in_half_points := (pixels_to_half_points (vertical_offset))
				temp_string.append (height_in_half_points.out)
				current_vertical_offset := vertical_offset
			end
			
			temp_string.append (font_string)
			temp_string.append (font_offset.i_th (format_index).out)
			temp_string.append (font_size_string)
			temp_string.append (heights.i_th (format_index).out)
			temp_string.append (space_string)
			internal_text.append (temp_string)
			from
				counter := 1
			until
				counter > a_text.count
			loop
				character := a_text.item (counter)
				if character = '%N' then
					internal_text.append (rtf_newline)
				elseif character = '\' then
					internal_text.append (rtf_backslash)
				elseif character = '{' then
					internal_text.append (rtf_open_brace)	
				elseif character = '}' then
					internal_text.append (rtf_close_brace)
				else
					internal_text.append_character (a_text.item (counter))
				end
				counter := counter + 1
			end
		end
		
	pixels_to_half_points (pixels: INTEGER): INTEGER is
			-- `Result' is pixels converted to half points, being
			-- the meaurement used for font sizes in RTF.
		do
			Result := (pixels * 72 // screen.vertical_resolution) * 2
		end

feature -- Access

	rich_text: EV_RICH_TEXT_I
			-- Rich text associated with `Current'.

	internal_text: STRING
			-- Text used for building RTF strings internally before buffering or saving.

feature {EV_ANY_I} -- Implementation			

	generate_complete_rtf_from_buffering is
			-- Generate the rtf heading for buffered operations into `internal_text'.
			-- Current contents of `internal_text' are lost.
		local
			internal_text_twin: STRING
		do
				-- `font_text' contents is generated by each call to `buffered_append',
				-- so simply close the tag.
			font_text.append ("}")

				-- `color_text' contents is generated by each call to `buffered_append',
				-- so simply close the tag.
			color_text.append ("}")
			
			internal_text_twin := internal_text.twin
			internal_text := font_text.twin
			internal_text.append ("%R%N")
			internal_text.append (color_text)
			internal_text.append ("%R%N")
			internal_text.append (internal_text_twin)
			internal_text.append ("}")
		end
		
feature {NONE} -- Implementation

	build_font_from_format (a_format: EV_CHARACTER_FORMAT) is
			-- Update font text `font_text' for addition of a new format to the buffering.
		local
			current_family: INTEGER
			family: STRING
			temp_string: STRING
			a_font: EV_FONT
		do
			a_font := a_format.font
			inspect current_family
			when family_screen then 
				family := "ftech"
			when family_roman then 
				family := "froman"
			when family_sans then 
				family := "fswiss"
			when family_typewriter then 
				family := "fscript"
			when family_modern then 
				family := "fmodern"
			else
				family := "fnil"
			end
			temp_string := "\"
			temp_string.append (family)
			temp_string.append ("\fcharset")
			temp_string.append (rich_text.font_char_set (a_font).out)
			temp_string.append (space_string)
			temp_string.append (a_font.name)
			hashed_fonts.search (temp_string)
			if not hashed_fonts.found then
				font_count := font_count + 1
				hashed_fonts.put (font_count, temp_string)
				font_offset.force (hashed_fonts.found_item)
				font_text.append ("{\f")
				font_text.append (font_count.out)
				font_text.append (temp_string)
				font_text.append ("}")
			else
				font_offset.force (hashed_fonts.item (temp_string))
			end
		end
		
		
	build_color_from_format (a_format: EV_CHARACTER_FORMAT) is
			-- Update color text `color_text' for addition of a new format to the buffering.
		local
			color, back_color: EV_COLOR
			hashed_color, hashed_back_color: STRING
		do
			color := a_format.color
			hashed_color := rtf_red.twin
			hashed_color.append (color.red_8_bit.out)
			hashed_color.append (rtf_green)
			hashed_color.append (color.green_8_bit.out)
			hashed_color.append (rtf_blue)
			hashed_color.append (color.blue_8_bit.out)
			hashed_color.append (";")

			hashed_colors.search (hashed_color)
				-- If the color does not already exist.
			if not hashed_colors.found then
					-- Add the color to `colors' for later retrieval.
				color_count := color_count + 1
				hashed_colors.put (color_count, hashed_color)
					-- Store the offset from the character index to the new color index for retrieval.
				color_offset.force (hashed_colors.found_item)
				color_text.append (hashed_color)
			else
				color_offset.force (hashed_colors.item (hashed_color))
			end
			
			back_color := a_format.background_color
			hashed_back_color := rtf_red.twin
			hashed_back_color.append (back_color.red_8_bit.out)
			hashed_back_color.append (rtf_green)
			hashed_back_color.append (back_color.green_8_bit.out)
			hashed_back_color.append (rtf_blue)
			hashed_back_color.append (back_color.blue_8_bit.out)
			hashed_back_color.append (";")

			hashed_colors.search (hashed_back_color)
				-- If the color does not already exist.
			if not hashed_colors.found then
				-- Add the color to `colors' for later retrieval.
				color_count := color_count + 1
				hashed_colors.put (color_count, hashed_back_color)
					-- Store the offset from the character index to the new color index for retrieval.
				back_color_offset.force (hashed_colors.found_item)
				color_text.append (hashed_back_color)
			else
				back_color_offset.force (hashed_colors.item (hashed_back_color))
			end
		end
			
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
		
	screen: EV_SCREEN is
			-- Once acces to EV_SCREEN object.
		once
			create Result
		end
		
invariant
	rich_text_not_void: rich_text /= Void

end -- class EV_RICH_TEXT_BUFFERING_STRUCTURES_I
