indexing
	description	: "Shared font constants for the editor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			Result := line_height - loc_font.descent
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_SHARED_EDITOR_FONT
