note
	description: "Summary description for {SCM_UNSUPPORTED_ROW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_UNSUPPORTED_ROW

inherit
	SCM_STATUS_WC_ROW

create
	make

feature -- Operation

	populate_row (a_grid: SCM_STATUS_GRID; a_row: EV_GRID_ROW)
		local
			glab: EV_GRID_LABEL_ITEM
		do
			a_row.set_item (a_grid.checkbox_column, create {EV_GRID_ITEM})

			create glab.make_with_text (root_location.location.name)
			a_row.set_item (a_grid.name_column, glab)
			a_row.set_item (a_grid.scm_column, create {EV_GRID_LABEL_ITEM}.make_with_text ("?"))

			across
				1 |..| a_row.count as idx
			loop
				if
					attached {EV_GRID_LABEL_ITEM} a_row.item (idx.item) as l_label
				then
					l_label.set_font (a_grid.bold_font)
					l_label.set_foreground_color (a_grid.stock_colors.grey)
				end
			end
			a_grid.fill_empty_grid_items (a_row)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
