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

	font_width_cell: CELL [INTEGER] is
			-- Cached version of `font_width'
		local
			loc_font_width: INTEGER
		once
			loc_font_width := font.width
			create Result.put (loc_font_width)
		end

	line_height_cell: CELL [INTEGER] is
			-- Cached version of `line_height'.
		local
			loc_font_height: INTEGER
			loc_line_height: INTEGER
		once
			loc_font_height := font.height
			loc_line_height := loc_font_height + (loc_font_height // 4) + 1
			create Result.put (loc_line_height)
		end

end -- class EB_SHARED_EDITOR_FONT
