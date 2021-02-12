note
	description: "Shared font constants for the editor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_EDITOR_FONT

feature -- Access

	line_height: INTEGER
			-- Height of a line in the editor
		do
			Result := line_height_cell.item
		end

	font_offset: INTEGER
			--
		do
			Result := font_offset_cell.item
		end

	font: EV_FONT
			-- Font used in the editor
		require
			has_font: has_font
		local
			l_pref: detachable FONT_PREFERENCE
		do
			l_pref := font_cell.item
			check l_pref /= Void end -- Implied by precondition
			Result := l_pref.value
		end

	keyword_font: EV_FONT
			-- Keyword Font used in the editor
		require
			has_keyword_font: has_keyword_font
		local
			l_pref: detachable FONT_PREFERENCE
		do
			l_pref := keyword_font_cell.item
			check l_pref /= Void end -- Implied by precondition
			Result := l_pref.value
		end

	header_font: EV_FONT
			-- Font used in the header control
		require
			has_header_fontn: has_header_font
		local
			l_pref: detachable FONT_PREFERENCE
		do
			l_pref := header_font_cell.item
			check l_pref /= Void end -- Implied by precondition
			Result := l_pref.value
		end

	font_width: INTEGER
			-- Width of character in the editor.
		require
			is_fixed_width: is_fixed_width
		do
			Result := font_width_cell.item
		end

	is_fixed_width: BOOLEAN
			-- Is `font' a fixed-width font?
		do
			Result := is_fixed_width_cell.item
		end

feature -- Query

	has_font: BOOLEAN
			-- Is `header_font' set?
		do
			Result := font_cell.item /= Void
		end

	has_keyword_font: BOOLEAN
			-- Is `header_font' set?
		do
			Result := keyword_font_cell.item /= Void
		end

	has_header_font: BOOLEAN
			-- Is `header_font' set?
		do
			Result := header_font_cell.item /= Void
		end

feature {EDITOR_DATA} -- Implementation

	font_cell: CELL [detachable FONT_PREFERENCE]
			-- Cached version of `font'.
		once
			create Result.put (Void)
		end

	keyword_font_cell: CELL [detachable FONT_PREFERENCE]
			-- Cached version of `font' for keywords.
		once
			create Result.put (Void)
		end

	font_zoom_factor_cell: CELL [detachable INTEGER_PREFERENCE]
			-- Cached version of font factory for `font' and `keyword_font'
		once
			create Result.put (Void)
		end

	header_font_cell: CELL [detachable FONT_PREFERENCE]
			-- Cached version of `font' for header panel.
		once
			create Result.put (Void)
		end

	font_width_cell: CELL [INTEGER]
			-- Cached version of `font_width'
		local
			loc_font_width: INTEGER
		once
			loc_font_width := font_with_zoom_factor_cell.item.width
			create Result.put (loc_font_width)
		end

	is_fixed_width_cell: CELL [BOOLEAN]
			-- Cached version of `is_fixed_width'
		once
			create Result.put (False)
		ensure
			is_fixed_width_cell_not_void: Result /= Void
		end

	font_with_zoom_factor_cell: CELL [EV_FONT]
			-- Font with zoom factor cell
		once
			create Result.put (calculate_font_with_zoom_factor)
		ensure
			not_void: Result /= Void
		end

	keyword_font_with_zoom_factor_cell: CELL [EV_FONT]
			-- Keyword font with zoom factor cell
		once
			create Result.put (calculate_keyword_font_with_zoom_factor)
		ensure
			not_void: Result /= Void
		end

	line_height_font: EV_FONT
			-- Font used to calculate line height
		do
			if keyword_font_with_zoom_factor_cell.item.height > font_with_zoom_factor_cell.item.height then
				Result := keyword_font_with_zoom_factor_cell.item
			else
				Result := font_with_zoom_factor_cell.item
			end
		end

	line_height_cell: CELL [INTEGER]
			-- Cached version of `line_height'.
		once
			create Result.put (calculate_line_height)
		end

	font_offset_cell: CELL [INTEGER]
			-- Number of pixels from top of line to beginning of drawing operation
		once
			create Result.put (calculate_font_offset)
		end

	calculate_font_offset: INTEGER
			-- Calculate `font_offset' based on current font sizes
		do
			Result := line_height - line_height_font.descent
		end

	calculate_line_height: INTEGER
			-- Calculate the  `line_height' based on current font sizes
		do
			Result := line_height_font.line_height
		end

	calculate_font_with_zoom_factor: EV_FONT
			-- Font with zoom factor
		require
			font_cell_item_set: has_font
			font_zoom_factor_cell_set: font_zoom_factor_cell.item /= Void
		local
			l_height: INTEGER
			l_pref: detachable FONT_PREFERENCE
			l_pref_factor: detachable INTEGER_PREFERENCE
		do
			l_pref := font_cell.item
			check l_pref /= Void end -- Implied by precondition
			Result := l_pref.value.twin
			l_pref_factor := font_zoom_factor_cell.item
			check l_pref_factor /= Void end -- Implied by precondition
			l_height := Result.height + l_pref_factor.value
			if l_height > 0 then
				Result.set_height (l_height)
			end
		end

	calculate_keyword_font_with_zoom_factor: EV_FONT
			-- Keyword font with zoom factor
		require
			keyword_font_cell_set: has_keyword_font
			font_zoom_factor_cell_set: font_zoom_factor_cell.item /= Void
		local
			l_height: INTEGER
			l_pref: detachable FONT_PREFERENCE
			l_pref_factor: detachable INTEGER_PREFERENCE
		do
			l_pref := keyword_font_cell.item
			check l_pref /= Void end -- Implied by precondition
			Result := l_pref.value.twin
			l_pref_factor := font_zoom_factor_cell.item
			check l_pref_factor /= Void end -- Implied by precondition
			l_height := Result.height + l_pref_factor.value
			if l_height > 0 then
				Result.set_height (l_height)
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end