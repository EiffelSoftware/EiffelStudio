indexing
	description: "[
					Objects that manage menu sizes for a SD_MENU_ROW.
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_ROW_SIZER

create
	make

feature {NONE}  -- Initlization

	make (a_menu_row: SD_MENU_ROW) is
			-- Creation method.
		require
			not_void: a_menu_row /= Void
		local
			l_shared: SD_SHARED
		do
			internal_menu_row := a_menu_row
			create l_shared
			internal_mediator := l_shared.menu_docker_mediator_cell.item
		ensure
			set: internal_menu_row = a_menu_row
		end

feature -- Command

	resize_all_menus is
			-- Reisze all menus from start to end when not `is_enough_max_space'.
		local
			l_space_to_resize: INTEGER
		do
			if not is_enough_space then
				l_space_to_resize := space_to_resize
			end
		ensure
			enough_space: is_enough_space
		end

	start_drag_prepare is
			-- Do some prepare work when user start drag.
		local
			l_menus: DS_ARRAYED_LIST [SD_MENU_ZONE]
			l_shared: SD_SHARED
		do
			from
				l_menus := internal_menu_row.menu_zones
				l_menus.start
				create all_sizes.make (1)
			until
				l_menus.after
			loop
				all_sizes.extend (l_menus.item_for_iteration.size)
				l_menus.forth
			end
			create l_shared
			internal_mediator := l_shared.menu_docker_mediator_cell.item
		end

	end_drag_clean is
			-- Do some clean work when user end drag.
		do
			all_sizes := Void
		end

	resize_on_extend (a_new_menu: SD_MENU_ZONE) is
			-- When extend a_new_menu, if not `is_enough_max_space', then resize menus.
		require
			has: has (a_new_menu)
		local
			l_space_to_reduce: INTEGER
			l_menus: DS_ARRAYED_LIST [SD_MENU_ZONE]
		do
			if not is_enough_max_space then
				-- Not enough space, resize from right to left.
				l_space_to_reduce := space_to_resize
				l_menus := internal_menu_row.menu_zones
				l_menus.delete (a_new_menu)
				from
					l_menus.finish
				until
					l_menus.before or l_space_to_reduce <= 0
				loop
					l_space_to_reduce := l_space_to_reduce - l_menus.item_for_iteration.sizer.reduce_size (l_space_to_reduce)
					l_menus.back
				end
			end
		ensure
			enough_space: is_enough_space
		end

	resize_on_prune is
			-- Just after prune a menu from `internal_menu_row', we need to resize all menus if needed.
		local
			l_menus: DS_ARRAYED_LIST [SD_MENU_ZONE]
			l_size_to_expand: INTEGER
		do
			l_menus := internal_menu_row.menu_zones
			from
				l_size_to_expand := space_to_resize
				l_size_to_expand := - l_size_to_expand
				debug ("docking")
					print ("%NSD_MENU_ROW_SIZER reisze_on_prune l_size_to_expand ++++++++++ is: " + l_size_to_expand.out + " l_menus.count = " + l_menus.count.out)
				end
				l_menus.start
			until
				l_menus.after or l_size_to_expand <= 0
			loop
				debug ("docking")
					print ("%NSD_MENU_ROW_SIZER reisze_on_prune l_size_to_expand /////////// is: " + l_size_to_expand.out)
				end
				l_size_to_expand := l_size_to_expand - l_menus.item_for_iteration.sizer.expand_size (l_size_to_expand)
				l_menus.forth
			end
			if is_enough_max_space then
				-- Every body should extend to full size

			else
				-- Everyboy should extend
			end
			debug ("docking")
				print ("%NSD_MENU_ROW_SIZER reisze_on_prune l_size_to_expand =========== Result is: " + l_size_to_expand.out)
			end
		end

	try_to_solve_no_space_left (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_hot_index: INTEGER): BOOLEAN is
			-- After SD_POSITIONER calculation, there is not enough space at left side. Try to minmize some menus.
		do

		end

	try_to_solve_no_space_right (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_hot_index: INTEGER): BOOLEAN is
			-- After SD_POSITIONER calculation, there is not enough space at right side. Try to minmize some menus.
		do

		end

	try_to_solve_no_space_hot_menu_right (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]): BOOLEAN is
			-- After SD_POSITIONER calculation, there is not enough space for dragged menu at right side. Try to minmize dragged menu.
		do

		end

feature -- Query

	is_enough_max_space: BOOLEAN is
			-- If there is enough space without reduce size of all menu zones in Current?
		require

		local
			l_all_size: INTEGER
			l_menus: DS_ARRAYED_LIST [SD_MENU_ZONE]
			l_caller: SD_MENU_ZONE
			l_row_max_size: INTEGER
		do
			l_menus := internal_menu_row.menu_zones
			l_caller := internal_mediator.caller
			l_menus.delete (l_caller)

			from
				l_menus.start
			until
				l_menus.after
			loop
				l_row_max_size := l_row_max_size + l_menus.item_for_iteration.maximize_size
				l_menus.forth
			end
			if internal_menu_row.is_vertical then
				l_all_size := internal_menu_row.height
			else
				l_all_size := internal_menu_row.width
			end
			Result := l_all_size >= l_row_max_size + l_caller.maximize_size

		end

	is_enough_space: BOOLEAN is
			-- If there is enough space for all menus' current size?
		require
--			is_dragging: is_user_dragging
--			is_caller_in: is_caller_in
		do
			debug ("docking")
				print ("%NSD_MENU_ROW_SIZER is_enough_space space to reduce is: " + space_to_resize.out)
			end
			Result := space_to_resize <= 0
		end

	space_to_resize: INTEGER is
			-- Space that not enough, so have to reduce menus size.
			-- If space is enough, Result will negative, means size we can expand.
		local
			l_all_size: INTEGER
			l_menus: DS_ARRAYED_LIST [SD_MENU_ZONE]
			l_row_max_size: INTEGER
		do
			l_menus := internal_menu_row.menu_zones
			from
				l_menus.start
			until
				l_menus.after
			loop
				l_row_max_size := l_row_max_size + l_menus.item_for_iteration.size
				debug ("docking")
					print ("%NSD_MENU_ROW_SIZER: space_to_resize @@@@@@@@@@ iteration: menu size: " + l_menus.item_for_iteration.size.out)
				end
				l_menus.forth
			end
			if internal_menu_row.is_vertical then
				l_all_size := internal_menu_row.height
			else
				l_all_size := internal_menu_row.width
				debug ("docking")
					print ("%NSD_MENU_ROW_SIZER: space_to_resize @@@@@@@@@@ row width: " + l_all_size.out)
				end
			end
			Result := l_row_max_size - l_all_size
		ensure

		end

	has (a_menu: EV_WIDGET): BOOLEAN is
			-- If `internal_menu_row' has a_menu?
		do
			Result := internal_menu_row.has (a_menu)
		end

feature {NONE} -- Implementation

	internal_mediator: SD_MENU_DOCKER_MEDIATOR
			-- Docker mediator for one user dragging.

	internal_menu_row: SD_MENU_ROW
			-- Menu row which all it's menus' size are managed by Current.

	all_sizes: ARRAYED_LIST [INTEGER]
			-- All orignal sizes when user dragging.

end
