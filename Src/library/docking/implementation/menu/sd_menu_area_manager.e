indexing
	description: "Objects that manage one of menu area"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_AREA_MANAGER
		-- FIXIT: should rename to SD_MENU_HOT_ZONE ?
create
	make

feature {NONE} -- Initialization

	make (a_menu_box: EV_BOX; a_vertical: BOOLEAN; a_menu_dock_mediator: like internal_menu_dock_mediator) is
			--
		require
			a_menu_box_not_void: a_menu_box /= Void
			a_menu_dock_mediator /= Void
		do

			internal_box := a_menu_box
			internal_vertical := a_vertical
			internal_menu_dock_mediator := a_menu_dock_mediator
			create internal_area.make (internal_box.screen_x, internal_box.screen_y, internal_box.width, internal_box.height)


		ensure
			internal_box_set: a_menu_box = internal_box
			internal_menu_dock_mediator_set: a_menu_dock_mediator = internal_menu_dock_mediator
		end

feature -- Status report

	area_managed: EV_RECTANGLE is
			-- Menu area EV_RECTANGLE. Different from internal_area, it's bigger.
		local
			l_area: EV_RECTANGLE
		do
			l_area := internal_area.twin
			if internal_vertical then
				l_area.set_left (l_area.left - {SD_SHARED}.menu_size)
				l_area.set_right (l_area.right + {SD_SHARED}.menu_size)
			else
				l_area.set_top (l_area.top - {SD_SHARED}.menu_size)
				l_area.set_bottom (l_area.bottom + {SD_SHARED}.menu_size)
			end
			Result := l_area
		end

	area: EV_RECTANGLE is
			--
		do
			Result := internal_area
		end

feature -- Basic operation

	on_pointer_motion (a_screen_y_or_x: INTEGER): BOOLEAN is
			--
		do
			Result := move_in (a_screen_y_or_x)

			if not Result then
				Result := move_out (a_screen_y_or_x)

			end
		end

	start_drag is
			--
		local
			l_menu_row: SD_MENU_ROW
		do
			from
				internal_box.start
			until
				internal_box.after
			loop
				l_menu_row := Void
				l_menu_row ?= internal_box.item
				check box_only_have_menu_row: l_menu_row /= Void end
				l_menu_row.start_drag (internal_menu_dock_mediator.caller)
				internal_box.forth
			end

		end

feature {NONE} -- Implementation

	move_in (a_screen_y_or_x: INTEGER): BOOLEAN is
			--
		local
			l_menu_row: SD_MENU_ROW
		do
			from
				internal_box.start
			until
				internal_box.after or Result
			loop
				l_menu_row ?= internal_box.item
				check l_menu_row /= Void end

				if not l_menu_row.has (internal_menu_dock_mediator.caller)  then

					if not internal_vertical then
						if l_menu_row.has_screen_y (a_screen_y_or_x) then
							--Change caller's row.
							prune_internal_caller_from_parent
							l_menu_row.extend (internal_menu_dock_mediator.caller)
							Result := True
						end
					else
						-- When vertical, we should do....

					end

				end
				internal_box.forth
			end
		end

	move_out (a_screen_y_or_x: INTEGER): BOOLEAN is
			--
		do
			if not caller_in_current_area or not caller_in_single_row then
				if internal_menu_dock_mediator.caller.is_floating then
					internal_menu_dock_mediator.caller.dock
				end
				create_new_row_by_position (a_screen_y_or_x)
				Result := True
			end
		end

	caller_in_single_row: BOOLEAN is
			--
		do
			Result := internal_menu_dock_mediator.caller.row.count = 1
		end

	caller_in_current_area: BOOLEAN is
			--
		local
--			l_in_current_area: BOOLEAN
			l_menu_row: SD_MENU_ROW
		do

			from
				internal_box.start
			until
				internal_box.after or Result
			loop
				l_menu_row ?= internal_box.item
				check l_menu_row /= Void end
				Result := l_menu_row.has (internal_menu_dock_mediator.caller)
				internal_box.forth
			end
		end

	create_new_row_by_position (a_screen_y_or_x: INTEGER) is
			--
		do
			if (not internal_vertical and a_screen_y_or_x < internal_area.top) or (internal_vertical and a_screen_y_or_x < internal_area.left) then
				prune_internal_caller_from_parent
				create_new_row (True)

			elseif (not internal_vertical and a_screen_y_or_x > internal_area.bottom) or (internal_vertical and a_screen_y_or_x > internal_area.right) then
				prune_internal_caller_from_parent
				create_new_row (False)

			end
		end

	create_new_row (a_start: BOOLEAN) is
			-- Create a new row at top if a_start is True, otherwise create a new row at bottom.
		local
			l_new_row: SD_MENU_ROW
--			l_tool_bar_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
--			l_new_zone: SD_MENU_ZONE
--			l_drawable_test: EV_DRAWING_AREA
		do
--				-- Should create a new row	
--			

--			
			create l_new_row.make (internal_vertical)

			if a_start then
				internal_box.start
				internal_box.put_left (l_new_row)
			else
				internal_box.extend (l_new_row)
			end

			l_new_row.extend (internal_menu_dock_mediator.caller)
			debug ("larry")
				io.put_string ("%N SD_MENU_AREA_MANAGER new row created, and zone inserted.")
			end
		end

	prune_internal_caller_from_parent is
			--
		do
			if internal_menu_dock_mediator.caller.row /= Void then
				if caller_in_single_row then
					internal_menu_dock_mediator.caller.row.parent.prune (internal_menu_dock_mediator.caller.row)
				end
				internal_menu_dock_mediator.caller.row.prune (internal_menu_dock_mediator.caller)
			end
		end

	internal_area: EV_RECTANGLE

	internal_box: EV_BOX

--	internal_menu_rows: ARRAYED_LIST [SD_MENU_ROW]

	internal_vertical: BOOLEAN

	internal_menu_dock_mediator: SD_MENU_DOCKER_MEDIATOR

end
