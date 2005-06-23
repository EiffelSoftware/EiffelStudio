indexing
	description : "Objects that ..."
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
			r: EV_GRID_ROW
			g: EV_GRID
		do
			g := a_row.parent
			if g /= Void then
				from
				until
					a_row.subrow_count = 0
				loop
					r := a_row.subrow (a_row.subrow_count)
					grid_remove_and_clear_subrows_from (r)
					grid_clear_row (r)
					g.remove_row (r.index)
				end
			end
		ensure
			a_row.subrow_count = 0
			a_row.subrow_count_recursive = 0
		end

	grid_remove_and_clear_all_rows (g: EV_GRID) is
		require
			g /= Void
		local
			rc: INTEGER
		do
			from
				rc := g.row_count
			until
				rc = 0
			loop
				grid_clear_row (g.row (rc))
				g.remove_row (rc)
				rc := g.row_count				
			end
			g.clear
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

end
