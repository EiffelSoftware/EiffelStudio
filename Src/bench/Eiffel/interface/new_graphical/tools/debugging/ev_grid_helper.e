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
				grid_move_row_node_to (grid, row_index, to_index, Void)
			end
			Result := to_index
		end

	grid_move_row_node_to (grid: EV_GRID; from_index, to_index: INTEGER; parent_row: EV_GRID_ROW) is
			-- Move row (and subrows) at index `from_index' to row index `to_index'
			-- then if `parent_row' is not Void, make the moved row a child of `parent_row'
		require
			indexes_not_equal: from_index /= to_index
			valid_from_index: from_index > 0 and from_index <= grid.row_count
			valid_to_index: to_index > 0 and to_index <= grid.row_count
		local
			from_row, to_row: EV_GRID_ROW
			real_to_index: INTEGER
			go_up: BOOLEAN
			from_p, to_p: EV_GRID_ROW
			r: EV_GRID_ROW
			subrows: LINKED_LIST [EV_GRID_ROW]
		do
			from_row := grid.row (from_index)
			from_p := from_row.parent_row

			to_row := grid.row (to_index)
			to_p := to_row.parent_row

			if parent_row /= Void then
				to_p := parent_row
			end

			go_up := from_index > to_index

				--| Move top row
			if from_p /= Void then
				from_p.remove_subrow (from_row)
			end
			if from_row.subrow_count > 0 then
				create subrows.make
				from
				until
					from_row.subrow_count = 0
				loop
					r := from_row.subrow (from_row.subrow_count)
					check
						r.parent_row= from_row
					end
					from_row.remove_subrow (r)
					subrows.put_front (r)
				end
			end
			check
				from_row.subrow_count = 0
			end
			if to_row.subrow_count > 0 and not go_up then
				real_to_index := to_row.index + to_row.subrow_count_recursive
			else
				real_to_index := to_index
			end
			grid.move_row (from_index, real_to_index)
			check
				from_row.index = real_to_index
			end
			if to_p /= Void then
				to_p.add_subrow (from_row)
			end
			check
				from_row.parent_row = to_p
			end

			if subrows /= Void then
				from
					subrows.start
				until
					subrows.after
				loop
					r := subrows.item
					if from_row.subrow_count > 0 and not go_up then
						real_to_index := from_row.index + from_row.subrow_count_recursive
					elseif go_up then
						real_to_index := from_row.index + from_row.subrow_count_recursive + 1
					else
						real_to_index := from_row.index
					end
					grid_move_row_node_to (grid, r.index, real_to_index, from_row)
					subrows.forth
				end
			end
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
				end
				j := j + 1
			end
			if r /= Void then
				Result := r.index
			else
				Result := row_index
			end
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

	grid_remove_subrows_from (a_row: EV_GRID_ROW) is
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
					r := a_row.subrow (1)
					g.remove_row (r.index)
				end				
			end
		ensure
			a_row.subrow_count = 0
			a_row.subrow_count_recursive = 0
		end

	grid_remove_all_rows (g: EV_GRID) is
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
				g.remove_row (rc)
				rc := g.row_count				
			end
		ensure
			g.row_count = 0
			g.selected_rows.count = 0
		end


end
