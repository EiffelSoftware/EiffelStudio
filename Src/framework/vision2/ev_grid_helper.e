note
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

feature -- Properties

	pixmap_enabled: BOOLEAN = True
			-- Is pixmap enabled ?

feature -- Access

	grid_cell_set_text (a_cell: EV_GRID_LABEL_ITEM; v: READABLE_STRING_GENERAL)
			-- Set text and tooltip to `a_cell'
		require
			cell_not_void: a_cell /= Void
		local
			s: READABLE_STRING_GENERAL
		do
			s := v
			if s = Void then
				s := ""
			end
			a_cell.set_text (s)
			if a_cell.tooltip = Void then
				grid_cell_set_tooltip (a_cell, s)
			end
		end

	grid_cell_set_tooltip (a_cell: EV_GRID_ITEM; v: READABLE_STRING_GENERAL)
			-- Set tool tip to `a_cell'
		require
			cell_not_void: a_cell /= Void
		do
			a_cell.set_tooltip (v)
		end

	grid_cell_set_pixmap (a_cell: EV_GRID_ITEM; v: EV_PIXMAP)
			-- Set pixmap to `a_cell'
			-- if possible, i.e on EV_GRID_LABEL_ITEM
		require
			cell_not_void: a_cell /= Void
		do
			if pixmap_enabled then
				if attached {EV_GRID_LABEL_ITEM} a_cell as glab then
					if v /= Void then
						glab.set_pixmap (v)
					else
						glab.remove_pixmap
					end
				end
			end
		end

	grid_row_fill_empty_cells (a_row: EV_GRID_ROW)
			-- Fills a grid row with items if no items exist at any cell location
		require
			a_row_attached: a_row /= Void
		local
			i, l_count: INTEGER
		do
			from
				i := 1
				l_count := a_row.count
			until
				i > l_count
			loop
				if a_row.item (i) = Void and then (a_row.is_part_of_tree_structure implies a_row.is_index_valid_for_item_setting_if_tree_node (i)) then
					a_row.set_item (i, create {EV_GRID_ITEM})
				end
				i := i + 1
			end
		end

	grid_move_to_end_of_grid (a_row: EV_GRID_ROW)
			-- Move `a_row' to the end of the grid
		require
			a_row /= Void
			a_row.parent /= Void
		do
			if attached a_row.parent as p then
				p.move_rows (a_row.index, p.row_count + 1, 1 + a_row.subrow_count_recursive)
			end
		end

	grid_move_top_row_node_by (grid: EV_GRID; row_index: INTEGER; offset: INTEGER): INTEGER
			-- move top row from `grid' at `row_index' by `offset' top row
		require
			grid_not_void: grid /= Void
			row_index_valid: row_index > 0 and then row_index <= grid.row_count
			offset_non_zero: offset /= 0
		local
			to_index: INTEGER
		do
			to_index := grid_next_top_row (grid, row_index, offset)
			if to_index > 0 and then to_index /= row_index then
				if offset > 0 then
					to_index := to_index + 1
				end
				grid.move_rows (row_index, to_index, 1 + grid.row (row_index).subrow_count_recursive)
			end
			Result := to_index
		end

	grid_next_top_row (grid: EV_GRID; row_index: INTEGER; offset: INTEGER): INTEGER
			-- Row index of the i_th `offset' top row from `row_index' row.
		require
			non_parented_row: grid.row (row_index).parent_row = Void
			in_range: row_index > 0 and then row_index <= grid.row_count
		local
			j,k: INTEGER
			r: detachable EV_GRID_ROW
		do
			if grid.is_tree_enabled then
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
						if r /= Void then
							k := r.index
							if offset > 0 then
								k := k + r.subrow_count_recursive
								r := grid.row (k)
							end
						else
							check
								tree_enabled: False
							end
								-- Should not occurs since is_tree_enabled = True
								-- however, handle the case							
							k := k + 1
							r := grid.row (k)
						end
					end
					j := j + 1
				end
			else
				if row_index + offset <= grid.row_count then
					r := grid.row (row_index + offset)
				end
			end
			if r /= Void then
				Result := r.index
			else
				Result := row_index
			end
		ensure
			result_in_range: Result > 0 implies Result <= grid.row_count
		end

	grid_ith_top_row (a_grid: EV_GRID; a_index: INTEGER): detachable EV_GRID_ROW
			-- I_th's top row of `a_grid'.
		local
			r: INTEGER
		do
			if a_grid.row_count > 0 then
				if a_index = 1 then
					Result := a_grid.row (1)
				else
					r := grid_next_top_row (a_grid, 1, a_index - 1)
					if r > 1 then
						Result := a_grid.row (r)
					end
				end
			end
		end

	grid_top_row (a_grid: EV_GRID; a_index: INTEGER): detachable EV_GRID_ROW
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

	grid_selected_top_rows (a_grid: EV_GRID): ARRAYED_LIST [EV_GRID_ROW]
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

	grid_front_new_row (a_grid: EV_GRID): EV_GRID_ROW
			-- New row inserted in the front of `a_grid'
		require
			a_grid /= Void
		do
			a_grid.insert_new_row (1)
			Result := a_grid.row (1)
		end

	grid_extended_new_row (a_grid: EV_GRID): EV_GRID_ROW
			-- New row inserted in the end of `a_grid'	
		require
			a_grid /= Void
		local
			r: INTEGER
		do
			r := a_grid.row_count + 1
			a_grid.insert_new_row (r)
			Result := a_grid.row (r)
		end

	grid_extended_new_subrow (a_row: EV_GRID_ROW): EV_GRID_ROW
			-- New subrow inserted in `a_row'
		require
			attached_row: a_row /= Void
			parented: a_row.parent /= Void
		local
			r: INTEGER
			g: detachable EV_GRID
		do
			g := a_row.parent
			check g /= Void then
				r := a_row.index + a_row.subrow_count_recursive + 1
				g.insert_new_row_parented (r, a_row)
				Result := g.row (r)
			end
		end

	grid_remove_and_clear_subrows_from (a_row: EV_GRID_ROW)
			-- Remove all subrows of `a_row' and clear the subrows
			-- as much as possible
			-- but do not clear `a_row'
		require
			a_row /= Void
		do
			if attached a_row.parent as g then
				if a_row.subrow_count > 0 then
					g.remove_rows (a_row.index + 1, a_row.index + a_row.subrow_count_recursive)
				end
			end
		ensure
			a_row.subrow_count = 0
			a_row.subrow_count_recursive = 0
		end

	grid_remove_and_clear_subrows_from_until (a_row: EV_GRID_ROW; a_until_row: EV_GRID_ROW)
			-- Remove all subrows of `a_row' and clear the subrows
			-- as much as possible
			-- but do not clear `a_row'
		require
			a_row /= Void
			a_until_row.parent_row = a_row
		do
			if attached a_row.parent as g then
				if a_row.subrow_count > 0 then
					g.remove_rows (a_row.index + 1, a_until_row.index - 1)
				end
			end
		ensure
			a_row.subrow (1) = a_until_row
		end

	grid_remove_and_clear_all_rows (g: EV_GRID)
			-- Remove and clear all rows from `g'
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

	grid_clear_row (row: EV_GRID_ROW)
			-- Clear `row'
		do
			row.set_data (Void)
			row.clear
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
