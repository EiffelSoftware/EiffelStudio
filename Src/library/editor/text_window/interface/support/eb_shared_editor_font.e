indexing
	description	: "Shared font constants for the editor"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	SHARED_EDITOR_FONT

feature -- Access

	line_height: INTEGER is
			-- Height of a line in the editor
		do
			Result := line_height_cell.item
		end

	font: EV_FONT is
			-- Font used in the editor
		do
			Result := font_cell.item.value
		end

	keyword_font: EV_FONT is
			-- Keyword Font used in the editor
		do
			Result := keyword_font_cell.item.value
		end

	header_font: EV_FONT is
			-- Font used in the header control
		do
			Result := header_font_cell.item.value
		end

	font_width: INTEGER is
			-- Width of character in the editor.
		do
			Result := font_width_cell.item
		end
	
feature {EDITOR_DATA} -- Implementation

	font_cell: CELL [FONT_PREFERENCE] is
			-- Cached version of `font'.
		once
			create Result
		end

	keyword_font_cell: CELL [FONT_PREFERENCE] is
			-- Cached version of `font' for keywords.
		once
			create Result
		end
		
	header_font_cell: CELL [FONT_PREFERENCE] is
			-- Cached version of `font' for header panel.
		once
			create Result
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
			if keyword_font_cell.item.value.height > font_cell.item.value.height then
				Result := keyword_font_cell.item.value
			else
				Result := font_cell.item.value
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
