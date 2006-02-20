indexing
	description: "[
					Objects that manage menu positions for a SD_MENU_ROW.
					This is when there is enough space for every menu in row.
																				]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_ROW_POSITIONER

create
	make

feature {NONE}  -- Initlization

	make (a_menu_row: SD_MENU_ROW) is
			-- Creation method.
		require
			not_void: a_menu_row /= Void
		local
			l_menus: DS_ARRAYED_LIST [SD_MENU_ZONE]
			l_shared: SD_SHARED
		do
			create l_shared
			create internal_sizer.make (a_menu_row)
			l_menus := a_menu_row.menu_zones
			internal_menu_row := a_menu_row
			internal_mediator := l_shared.menu_docker_mediator_cell.item
			create positions_and_sizes.make (1)
		ensure
			set: internal_menu_row = a_menu_row
		end

feature -- Command

	position_resize_on_extend (a_new_menu: SD_MENU_ZONE; a_relative_pointer_position: INTEGER) is
			-- When extend a_new_menu, if not `is_enough_max_space', then resize menus.
		require
			has: has (a_new_menu)
		local
			l_hot_index: INTEGER
			l_menus: DS_ARRAYED_LIST [SD_MENU_ZONE]
			l_last_end_position: INTEGER
		do
			if is_dragging then
				internal_sizer.resize_on_extend (a_new_menu)
				l_hot_index := put_hot_menu_at (a_relative_pointer_position)
				l_menus := internal_menu_row.menu_zones
				l_menus.delete (a_new_menu)
				if l_hot_index = 0 then
					internal_menu_row.set_item_position_internal (a_new_menu, 0)
					l_last_end_position := a_new_menu.size
				end
				from
					l_menus.start
				until
					l_menus.after
				loop
					internal_menu_row.set_item_position_internal (l_menus.item_for_iteration, l_last_end_position + 1)
					l_last_end_position := l_menus.item_for_iteration.position + l_menus.item_for_iteration.size
					if l_menus.index = l_hot_index then
						internal_menu_row.set_item_position_internal (a_new_menu, l_last_end_position + 1)
						l_last_end_position := a_new_menu.position + a_new_menu.size
					end
					l_menus.forth
				end
			end
		end

	position_resize_on_prune is
			-- Position and resize menus when prune a menu from Current.
		local
			l_menus: DS_ARRAYED_LIST [SD_MENU_ZONE]
		do
			internal_sizer.resize_on_prune
			if internal_sizer.is_enough_max_space then
				l_menus := internal_menu_row.menu_zones
				from
					l_menus.start
				until
					l_menus.after
				loop

					l_menus.forth
				end
			end
		end

	on_pointer_motion (a_relative_position: INTEGER) is
			-- Handle pointer motion in Current. Position dragging menu and others.
		local
			l_menus: DS_ARRAYED_LIST [SD_MENU_ZONE]
			l_hot_index: INTEGER
		do
			l_hot_index := put_hot_menu_at (a_relative_position)
			try_set_position (a_relative_position, l_hot_index)
			if is_possible_set_position (a_relative_position, l_hot_index) then
				from
					l_menus := internal_menu_row.menu_zones
					l_menus.delete (internal_mediator.caller)
					internal_menu_row.set_item_position_internal (internal_mediator.caller, a_relative_position)
					positions_and_sizes_try.start
					l_menus.start
				until
					positions_and_sizes_try.after
				loop
					internal_menu_row.set_item_position_internal (l_menus.item_for_iteration, positions_and_sizes_try.item.integer_32_item (1))

					l_menus.forth
					positions_and_sizes_try.forth
				end
			end

		ensure

		end

	start_drag is
			-- Do some prepare work when user start dragging.
		local
			l_shared: SD_SHARED
			l_menus: DS_ARRAYED_LIST [SD_MENU_ZONE]
		do
			create l_shared
			internal_mediator := l_shared.menu_docker_mediator_cell.item
			internal_sizer.start_drag_prepare

			from
				create positions_and_sizes.make (1)
				l_menus := internal_menu_row.menu_zones
				l_menus.delete (internal_mediator.caller)
				l_menus.start
			until
				l_menus.after
			loop
				positions_and_sizes.extend ([l_menus.item_for_iteration.position, l_menus.item_for_iteration.size])
				l_menus.forth
			end
		end

	end_drag is
			-- Do some clean work when user end dragging.
		do
			internal_mediator := Void
			internal_sizer.end_drag_clean
			positions_and_sizes.wipe_out
		end

feature -- Query

	has (a_widget: EV_WIDGET): BOOLEAN is
			-- If `internal_menu_row' has a_widget?
		do
			Result := internal_menu_row.has (a_widget)
		end

	is_dragging: BOOLEAN is
			-- If user dragging a menu now?
		do
			Result := internal_mediator /= Void
		end

feature {NONE}  -- Implementation

	put_hot_menu_at (a_position: INTEGER): INTEGER is
			-- Which index we should put hot menu?
			-- 0 is before 1st menu, 1 is after 1st menu, 2 is after 2nd menu...
			-- a_position is relative position.
		local
			l_found: BOOLEAN
			l_last_end_position: INTEGER
		do
			if positions_and_sizes.count > 0 and then a_position <= positions_and_sizes.first.integer_32_item (1) then
				l_found := True
				Result := 0
			else
				from
					positions_and_sizes.start
				until
					positions_and_sizes.after or l_found
				loop
					if l_last_end_position <= a_position and a_position < positions_and_sizes.item.integer_32_item (1) then
						Result := positions_and_sizes.index - 1
						l_found := True
					end
					if not l_found then
						if positions_and_sizes.item.integer_32_item (1) <= a_position and a_position <= positions_and_sizes.item.integer_32_item (1) + positions_and_sizes.item.integer_32_item (2) then
							Result := positions_and_sizes.index
							l_found := True
						end
					end
					positions_and_sizes.forth
				end
			end
			if not l_found then
				Result := positions_and_sizes.count
			end
		ensure
			valid: Result >= 0 and Result <= positions_and_sizes.count
		end

	try_set_position (a_position: INTEGER; a_hot_index: INTEGER) is
			 -- Try to position every menu. a_hot_index is Result from `put_hot_menu_at'.
		local
			l_last_position: INTEGER
			l_temp: TUPLE [INTEGER, INTEGER]
		do
			positions_and_sizes_try := positions_and_sizes.deep_twin
			-- Position every menu before hot menu.
			from
				positions_and_sizes.go_i_th (a_hot_index)
				l_last_position := a_position
			until
				positions_and_sizes.before
			loop
				if (positions_and_sizes.item.integer_32_item (1) + positions_and_sizes.item.integer_32_item (2) >= l_last_position)	then
					-- There is position conflict
					l_temp := positions_and_sizes_try.i_th (positions_and_sizes.index)
					l_temp.put_integer_32 (l_last_position - positions_and_sizes.item.integer_32_item (2) - 1, 1)
				end
				l_last_position := positions_and_sizes_try.i_th (positions_and_sizes.index).integer_32_item (1)
				positions_and_sizes.back
			end
			-- Position every menu after hot menu.
			from
				if a_hot_index = 0  then
					positions_and_sizes.go_i_th (1)
				else
					positions_and_sizes.go_i_th (a_hot_index + 1)
				end

				l_last_position := a_position + internal_mediator.caller.size
			until
				positions_and_sizes.after
			loop
				if l_last_position >= positions_and_sizes.item.integer_32_item (1) then
					-- There is position conflict
					l_temp := positions_and_sizes_try.i_th (positions_and_sizes.index)
					l_temp.put_integer_32 (l_last_position + 1, 1)
				end
				l_last_position := positions_and_sizes_try.i_th (positions_and_sizes.index).integer_32_item (1) + positions_and_sizes.item.integer_32_item (2)
				positions_and_sizes.forth
			end
		end

	is_possible_set_position (a_hot_pointer_position: INTEGER; a_hot_index: INTEGER): BOOLEAN is
			-- After `try_set_position' is it possible to set postion to `positions_and_sizes_try'?
		do
			Result := True
				-- Check if first out of border
				if positions_and_sizes_try /= Void and then positions_and_sizes_try.count > 0 then
					if positions_and_sizes_try.first.integer_32_item (1) < 0 then
						if internal_sizer.is_enough_max_space then
							Result := False
						else
							Result := internal_sizer.try_to_solve_no_space_left (positions_and_sizes_try, a_hot_index)
						end

					end
					-- Check if last out of border
					if positions_and_sizes_try.last.integer_32_item (1) + positions_and_sizes_try.last.integer_32_item (2) > internal_menu_row.size then
						if internal_sizer.is_enough_max_space then
							Result := False
						else
							Result := internal_sizer.try_to_solve_no_space_right (positions_and_sizes_try, a_hot_index)
						end
					end
				end
				-- Check if dragged menu right edge outside.
				if a_hot_pointer_position + internal_mediator.caller.size > internal_menu_row.width then
					if internal_sizer.is_enough_max_space then
						Result := False
					else
						Result := internal_sizer.try_to_solve_no_space_hot_menu_right (positions_and_sizes_try)
					end

				end
		end

	positions_and_sizes_try: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]
			-- Try to set menu positions and sizes.
			-- First is position, Second is size.

	position_one_menu (a_menu: SD_MENU_ZONE; l_position: INTEGER) is
			-- Position one menu position.
		do
			internal_menu_row.set_item_position_internal (a_menu, l_position)
		end

	internal_menu_row: SD_MENU_ROW
			-- Menu row which Current managed.

	positions_and_sizes: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]
			-- Before drag a meun bar, we should remember all (except dragged menu) positions and sizes of menu bars.
			-- First is position, Second is size.
			-- FIXIT: We should also remember which menu zone datas belong to.

	internal_mediator: SD_MENU_DOCKER_MEDIATOR
			-- Menu docker mendiator.

	internal_sizer: SD_MENU_ROW_SIZER
			-- Menu sizer.
invariant
	not_void: internal_mediator /= Void
end
