indexing
	description	: "Shared font constants for the editor"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SHARED_EDITOR_FONT

inherit
	EB_SHARED_EDITOR_DATA

feature -- Access

	line_height: INTEGER is
			-- Height of a line in the editor
		do
			Result := line_height_cell.item
		end

	font: EV_FONT is
			-- Font used in the editor
		do
			Result := font_cell.item
		end

	font_width: INTEGER is
			-- Width of character in the editor.
		do
			Result := font_width_cell.item
		end

feature {NONE} -- Implementation

	font_cell: CELL [EDITOR_FONT] is
			-- Cached version of `font'.
		once
			create Result.put (editor_preferences.font)
		end

	keyword_font_cell: CELL [EDITOR_FONT] is
			-- Cached version of `font' for keywords.
		once
			create Result.put (editor_preferences.keyword_font)
		end
		
	font_width_cell: CELL [INTEGER] is
			-- Cached version of `font_width'
		local
			loc_font_width: INTEGER
		once
			loc_font_width := font.width
			create Result.put (loc_font_width)
		end

	line_height_font: EV_FONT is
			-- Font used to calculate line height
		do
			if keyword_font_cell.item.height > font_cell.item.height then
				Result := keyword_font_cell.item
			else
				Result := font_cell.item
			end
		end

	line_height_cell: CELL [INTEGER] is
			-- Cached version of `line_height'.
		local
			loc_font: EV_FONT
			loc_line_height: INTEGER
		once
			loc_font := line_height_font
			loc_line_height := loc_font.height + loc_font.height // 6 + 1
			create Result.put (loc_line_height)
		end

	font_offset: INTEGER is
			-- Number of pixels from top of line to beginning of drawing operation
		local
			loc_font: EV_FONT
		once
			loc_font := line_height_font
			Result := loc_font.ascent
		end

end -- class EB_SHARED_EDITOR_FONT
