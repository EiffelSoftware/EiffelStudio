indexing
	description : "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred
class
	EV_GRID_HELPER

inherit
	REFACTORING_HELPER

feature -- Access

	grid_cell_set_text (a_cell: EV_GRID_LABEL_ITEM; v: STRING) is
		require
			cell_not_void: a_cell /= Void
		do
			a_cell.set_text (v)
			if a_cell.tooltip = Void then
				grid_cell_set_tooltip (a_cell, v)
			end
		end

	grid_cell_set_tooltip (a_cell: EV_GRID_ITEM; v: STRING) is
		require
			cell_not_void: a_cell /= Void
		do
			a_cell.set_tooltip (v)
		end

	pixmap_enabled: BOOLEAN is True

	grid_cell_set_pixmap (a_cell: EV_GRID_ITEM; v: EV_PIXMAP) is
		require
			cell_not_void: a_cell /= Void
		local
			glab: EV_GRID_LABEL_ITEM
		do
			if pixmap_enabled then
				glab ?= a_cell
				if glab /= Void then
					if v /= Void then
						glab.set_pixmap (v)
					else
						glab.remove_pixmap
					end
				end
			end
		end
		
	grid_move_to_end_of_grid (a_row: EV_GRID_ROW) is
		require
			a_row /= Void
			a_row.parent /= Void
		do
			a_row.parent.move_rows (a_row.index, a_row.parent.row_count + 1, 1 + a_row.subrow_count_recursive)
		end

	grid_move_top_row_node_by (grid: EV_GRID; row_index: INTEGER; offset: INTEGER): INTEGER is
		require
			grid /= Void
			row_index > 0 and then row_index <= grid.row_count
			offset /= 0
		local
			to_index: INTEGER
		do
			to_index := grid_next_top_row (grid, row_index, offset)
			if to_index /= row_index then
				if offset > 0 then
					to_index := to_index + 1
				end
				grid.move_rows (row_index, to_index, 1 + grid.row (row_index).subrow_count_recursive)
			end
			Result := to_index
		end

	grid_next_top_row (grid: EV_GRID; row_index: INTEGER; offset: INTEGER): INTEGER is
		require
			non_parented_row: grid.row (row_index).parent_row = Void
			row_index > 0 and then row_index <= grid.row_count
		local
			j,k: INTEGER
			r: EV_GRID_ROW
		do
			from
				j := 1
				k := row_index
				r := grid.row (row_index)
			until
				(j > offset.abs) or not (k > 0 and k <= grid.row_count)
			loop
				if offset < 0 then
					k := k - 1
				else
					k := k + r.subrow_count_recursive + 1
				end
				if k > 0 and k <= grid.row_count then
					r := grid.row (k)
					r := r.parent_row_root
					k := r.index
					if offset > 0 then
						k := k + r.subrow_count_recursive
						r := grid.row (k)
					end
				end
				j := j + 1
			end
			if r /= Void then
				Result := r.index
			else
				Result := row_index
			end
		end

	grid_top_row (a_grid: EV_GRID; a_index: INTEGER): EV_GRID_ROW is
			-- Return the `a_index' i_th top row of `a_grid'.
		require
			a_grid /= Void
			a_index >= 1
		local
			tr, r: INTEGER
		do
			if a_grid.row_count > 0 then
				from
					tr := 1
					r := 1
					Result := a_grid.row (r)
				until
					(Result /= Void) or (r > a_grid.row_count)
				loop
					if tr = a_index then
						Result := a_grid.row (r)
					end
					r := r + a_grid.row (r).subrow_count_recursive + 1
					tr := tr + 1
				end
			end
		ensure
			Result /= Void implies Result.parent_row = Void
		end

	grid_selected_top_rows (a_grid: EV_GRID): ARRAYED_LIST [EV_GRID_ROW] is
			-- Return the selected_rows filtered to keep only top rows
		require
			a_grid /= Void
		local
			r: EV_GRID_ROW
		do
			Result := a_grid.selected_rows
			from
				Result.start
			until
				Result.after
			loop
				r := Result.item
				if r = Void or else r.parent = Void or else r.parent_row /= Void then
					Result.remove
				else
					Result.forth
				end
			end
		ensure
			Result /= Void
		end

	grid_front_new_row (a_grid: EV_GRID): EV_GRID_ROW is
		require
			a_grid /= Void
		do
			a_grid.insert_new_row (1)
			Result := a_grid.row (1)
		end

	grid_extended_new_row (a_grid: EV_GRID): EV_GRID_ROW is
		require
			a_grid /= Void
		local
			r: INTEGER
		do
			r := a_grid.row_count + 1
			a_grid.insert_new_row (r)
			Result := a_grid.row (r)
		end

	grid_extended_new_subrow (a_row: EV_GRID_ROW): EV_GRID_ROW is
		require
			a_row /= Void
		local
			r: INTEGER
			g: EV_GRID
		do
			g := a_row.parent
			r := a_row.index + a_row.subrow_count_recursive + 1
			g.insert_new_row_parented (r, a_row)
			Result := g.row (r)
		end	

	grid_remove_and_clear_subrows_from (a_row: EV_GRID_ROW) is
			-- Remove all subrows of `a_row' and clear the subrows
			-- as much as possible
			-- but do not clear `a_row'
		require
			a_row /= Void
		local
			g: EV_GRID
		do
			g := a_row.parent
			if g /= Void then
				if a_row.subrow_count > 0 then
					g.remove_rows (a_row.index + 1, a_row.index + a_row.subrow_count_recursive)
				end
			end
		ensure
			a_row.subrow_count = 0
			a_row.subrow_count_recursive = 0
		end

	grid_remove_and_clear_all_rows (g: EV_GRID) is
		require
			g /= Void
		do
			if g.row_count > 0 then
				g.remove_rows (1, g.row_count)
			end
		ensure
			g.row_count = 0
			g.selected_rows.count = 0
		end

	grid_clear_row (row: EV_GRID_ROW) is
			-- Clear the row
		do
			row.set_data (Void)
			row.clear
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

end
