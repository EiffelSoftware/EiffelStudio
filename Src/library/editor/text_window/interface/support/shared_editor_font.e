indexing
	description	: "Shared font constants for the editor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	font_offset: INTEGER is
			--
		do
			Result := font_offset_cell.item
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
		require
			is_fixed_width: is_fixed_width
		do
			Result := font_width_cell.item
		end

	is_fixed_width: BOOLEAN is
			-- Is `font' a fixed-width font?
		do
			Result := is_fixed_width_cell.item
		end

feature {EDITOR_DATA} -- Implementation

	font_cell: CELL [FONT_PREFERENCE] is
			-- Cached version of `font'.
		once
			create Result.put (Void)
		end

	keyword_font_cell: CELL [FONT_PREFERENCE] is
			-- Cached version of `font' for keywords.
		once
			create Result.put (Void)
		end

	font_zoom_factor_cell: CELL [INTEGER_PREFERENCE] is
			-- Cached version of font factory for `font' and `keyword_font'
		once
			create Result.put (Void)
		end

	header_font_cell: CELL [FONT_PREFERENCE] is
			-- Cached version of `font' for header panel.
		once
			create Result.put (Void)
		end

	font_width_cell: CELL [INTEGER] is
			-- Cached version of `font_width'
		local
			loc_font_width: INTEGER
		once
			loc_font_width := font_with_zoom_factor_cell.item.width
			create Result.put (loc_font_width)
		end

	is_fixed_width_cell: CELL [BOOLEAN] is
			-- Cached version of `is_fixed_width'
		once
			create Result.put (False)
		ensure
			is_fixed_width_cell_not_void: Result /= Void
		end

	font_with_zoom_factor_cell: CELL [EV_FONT] is
			-- Font with zoom factor cell
		once
			create Result.put (calculate_font_with_zoom_factor)
		ensure
			not_void: Result /= Void
		end

	keyword_font_with_zoom_factor_cell: CELL [EV_FONT] is
			-- Keyword font with zoom factor cell
		once
			create Result.put (calculate_keyword_font_with_zoom_factor)
		ensure
			not_void: Result /= Void
		end

	line_height_font: EV_FONT is
			-- Font used to calculate line height
		do
			if keyword_font_with_zoom_factor_cell.item.height > font_with_zoom_factor_cell.item.height then
				Result := keyword_font_with_zoom_factor_cell.item
			else
				Result := font_with_zoom_factor_cell.item
			end
		end

	line_height_cell: CELL [INTEGER] is
			-- Cached version of `line_height'.
		once
			create Result.put (calculate_line_height)
		end

	font_offset_cell: CELL [INTEGER] is
			-- Number of pixels from top of line to beginning of drawing operation
		once
			create Result.put (calculate_font_offset)
		end

	calculate_font_offset: INTEGER is
			-- Calculate `font_offset' based on current font sizes
		do
			Result := line_height - line_height_font.descent
		end

	calculate_line_height: INTEGER is
			-- Calculate the  `line_height' based on current font sizes
		local
			loc_font: EV_FONT
		do
			loc_font := line_height_font
				-- Windows text editors seem to use an extra pixel spacing.
			Result := loc_font.ascent + loc_font.descent + {PLATFORM}.is_windows.to_integer
		end

	calculate_font_with_zoom_factor: EV_FONT is
			-- Font with zoom factor
		local
			l_height: INTEGER
		do
			Result := font_cell.item.value.twin
			l_height := Result.height + font_zoom_factor_cell.item.value
			if l_height > 0 then
				Result.set_height (l_height)
			end
		end

	calculate_keyword_font_with_zoom_factor: EV_FONT is
			-- Keyword font with zoom factor
		local
			l_height: INTEGER
		do
			Result := keyword_font_cell.item.value.twin
			l_height := Result.height + font_zoom_factor_cell.item.value
			if l_height > 0 then
				Result.set_height (l_height)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EB_SHARED_EDITOR_FONT
