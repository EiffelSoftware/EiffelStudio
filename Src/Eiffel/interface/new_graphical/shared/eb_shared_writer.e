note
	description: "Shared writers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_WRITER

inherit
	ANY

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature -- Access

	token_writer: EB_EDITOR_TOKEN_GENERATOR
			-- Editor token writer used to generate `tokens'
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

feature -- Font tables

	label_font_table: SPECIAL [EV_FONT]
			-- Label font substitute for editor fonts.
		local
			l_bold_font: EV_FONT
		once
			Result := preferences.editor_data.fonts.twin
			Result.put ((create {EV_LABEL}).font, preferences.editor_data.editor_font_id)
			l_bold_font := (create {EV_LABEL}).font
			l_bold_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
			Result.put (l_bold_font, preferences.editor_data.keyword_font_id)
			update_label_font_height
		end

	label_font_height_cell: CELL [INTEGER]
		once
			create Result.put (0)
		end

	label_font_height: INTEGER
			-- Height in pixel of `label_font_table'
		do
			Result := label_font_height_cell.item
		end

	update_label_font_height
		do
			label_font_height_cell.replace ({EVS_UTILITY}.grid_row_height_for_fonts (label_font_table))
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
