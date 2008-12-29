note
	description: "Utilities for EV_GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_UTILITY

feature -- Access

	grid_item_at_position (a_grid: EV_GRID; a_x, a_y: INTEGER): EV_GRID_ITEM
			-- Item at position (`a_x', `a_y') which is related to the top-left coordinate of `a_grid'
			-- Void if no item is found.
		require
			a_grid_attached: a_grid /= Void
			not_a_grid_is_destroyed: not a_grid.is_destroyed
		local
			l_header_height: INTEGER
			l_x, l_y: INTEGER
		do
			if a_grid.is_header_displayed then
				l_header_height := a_grid.header.height
			end
			l_x := a_grid.virtual_x_position + a_x
			l_y := a_grid.virtual_y_position + a_y - l_header_height
			if
				l_x >=0 and then l_x <= a_grid.virtual_width and then
				l_y >=0 and then l_y <= a_grid.virtual_height
			then
				Result := a_grid.item_at_virtual_position (l_x, l_y)
			end
		end

feature -- Resizeing

	auto_resize_columns (a_grid: EV_GRID; a_size_table: HASH_TABLE [TUPLE [min_width: INTEGER; max_width: INTEGER] ,INTEGER])
			-- Auto resize columns in `a_grid'.
			-- Keys of `a_size_table' are column indexes indicating those columns to be resized.
			-- Value of a key indicates the min and max width of that column.
			-- To perform resizing, the requrested width of a column is first retrieved and considered.
			-- But the actual resized width will be within [min_width, max_width].
			-- If width range tuple of a specified column is void, resize that column to its required width.
		require
			a_grid_attached: a_grid /= Void
			a_size_table_attached: a_size_table /= Void
		local
			l_size_range: TUPLE [min_width, max_width: INTEGER]
			l_column: EV_GRID_COLUMN
			l_row_count: INTEGER
			l_required_width: INTEGER
		do
			l_row_count := a_Grid.row_count
			if l_row_count > 0 then
				from
					a_size_table.start
				until
					a_size_table.after
				loop
					l_column := a_grid.column (a_size_table.key_for_iteration)
					l_size_range := a_size_table.item_for_iteration
					check
						l_column /= Void
					end
					l_required_width := l_column.required_width_of_item_span (1, l_row_count)
					if l_size_range /= Void then
						l_column.set_width (l_required_width.max (l_size_range.min_width).min (l_size_range.max_width))
					else
						l_column.set_width (l_required_width)
					end
					a_size_table.forth
				end
			end
		end

note
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

end
