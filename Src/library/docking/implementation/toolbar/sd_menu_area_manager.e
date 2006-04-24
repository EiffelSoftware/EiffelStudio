indexing
	description: "Tool bar hot zone of four tool bar area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_HOT_ZONE

create
	make

feature {NONE} -- Initialization

	make (a_tool_bar_box: EV_BOX; a_vertical: BOOLEAN; a_tool_bar_dock_mediator: like internal_dock_mediator) is
			-- Creation method.
		require
			a_tool_bar_box_not_void: a_tool_bar_box /= Void
			a_tool_bar_dock_mediator_not_void: a_tool_bar_dock_mediator /= Void
		do
			create internal_shared
			internal_docking_manager := a_tool_bar_dock_mediator.docking_manager
			internal_box := a_tool_bar_box
			internal_vertical := a_vertical
			internal_dock_mediator := a_tool_bar_dock_mediator
			create area.make (internal_box.screen_x, internal_box.screen_y, internal_box.width, internal_box.height)
		ensure
			internal_box_set: a_tool_bar_box = internal_box
			internal_tool_bar_dock_mediator_set: a_tool_bar_dock_mediator = internal_dock_mediator
		end

feature -- Status report

	area_managed: EV_RECTANGLE is
			-- Managed area. Different from `area', it's bigger.
		local
			l_area: EV_RECTANGLE
		do
			l_area := area.twin
			if internal_vertical then
				l_area.set_left (l_area.left - {SD_SHARED}.tool_bar_size)
				l_area.set_right (l_area.right + {SD_SHARED}.tool_bar_size)
			else
				l_area.set_top (l_area.top - {SD_SHARED}.tool_bar_size)
				l_area.set_bottom (l_area.bottom + {SD_SHARED}.tool_bar_size)
			end
			Result := l_area
		ensure
			not_void: Result /= Void
		end

feature -- Basic operation

	set_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Set docking manager
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
		ensure
			set: internal_docking_manager = a_docking_manager
		end

	on_pointer_motion (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Handle pointer motion.
		do
			-- It we don't compare a_screen_y_or_x with last_screen_y_or_x
			-- Some position will be infinite calculation.
			if last_screen_x /= a_screen_x or last_screen_y /= a_screen_y then
				Result := move_in (a_screen_x, a_screen_y)
				if not Result then
					if not internal_vertical then
						Result := move_out (a_screen_y)
					else
						Result := move_out (a_screen_x)
					end
				end
				last_screen_x := a_screen_x
				last_screen_y := a_screen_y
			end
		end

	start_drag is
			-- Start drag.
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
		do
			from
				internal_box.start
			until
				internal_box.after
			loop
				l_tool_bar_row := Void
				l_tool_bar_row ?= internal_box.item
				check box_only_have_tool_bar_row: l_tool_bar_row /= Void end
				l_tool_bar_row.start_drag (internal_dock_mediator.caller)
				internal_box.forth
			end
		ensure
			every_row_notifyed:
		end

feature {NONE} -- Implementation functions.

	move_in (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Handle pointer move in one row/column.
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
		do
			from
				internal_box.start
			until
				internal_box.after or Result
			loop
				l_tool_bar_row ?= internal_box.item
				check l_tool_bar_row /= Void end

				if not l_tool_bar_row.has (internal_dock_mediator.caller)  then
					if (l_tool_bar_row.has_screen_y (a_screen_y) and not internal_vertical)
						or (l_tool_bar_row.has_screen_x (a_screen_x) and internal_vertical) then
						--Change caller's row.
						internal_docking_manager.command.lock_update (Void, True)
						prune_internal_caller_from_parent
						l_tool_bar_row.extend (internal_dock_mediator.caller)
						debug ("docking")
							print ("%N SD_TOOL_BAR_HOT_ZONE move_in a_screen_x: " + a_screen_x.out + " .a_screen_y: " + a_screen_y.out)
						end
						if internal_vertical then
							l_tool_bar_row.on_pointer_motion (a_screen_y)
						else
							l_tool_bar_row.on_pointer_motion (a_screen_x)
						end
						internal_docking_manager.command.resize (True)
						internal_docking_manager.command.unlock_update
						Result := True
					end
				end
				if not internal_box.after then
					internal_box.forth
				end
			end
		end

	move_out (a_screen_y_or_x: INTEGER): BOOLEAN is
			-- Handle pointer move into SD_TOOL_BAR_ROW.
		local
			l_at_side: BOOLEAN
		do
			if not caller_in_current_area or not caller_in_single_row then
				l_at_side := (not internal_vertical and a_screen_y_or_x < area.top) or
							(internal_vertical and a_screen_y_or_x < area.left)	or
							(not internal_vertical and a_screen_y_or_x > area.bottom) or
							(internal_vertical and a_screen_y_or_x > area.right)
				if l_at_side then
					Result := True
					internal_docking_manager.command.lock_update (Void, True)
					if internal_dock_mediator.caller.is_floating then
						internal_dock_mediator.caller.dock
					end
					create_new_row_by_position (a_screen_y_or_x)
					internal_docking_manager.command.unlock_update
				end
			end
		end

	create_new_row_by_position (a_screen_y_or_x: INTEGER) is
			-- Create new row base on `a_screen_or_x'.
			-- `a_screen_y_or_x' is y for top and bottom tool bar areas.
			-- `a_screen_y_or_x' is x for left and right tool bar areas.
		do
			if (not internal_vertical and a_screen_y_or_x < area.top) or (internal_vertical and a_screen_y_or_x < area.left) then
				prune_internal_caller_from_parent
				create_new_row (True, a_screen_y_or_x)

			elseif (not internal_vertical and a_screen_y_or_x > area.bottom) or (internal_vertical and a_screen_y_or_x > area.right) then
				prune_internal_caller_from_parent
				create_new_row (False, a_screen_y_or_x)

			end
		ensure
			row_first_pruned_then_added:
		end

	create_new_row (a_start: BOOLEAN; a_screen_position: INTEGER) is
			-- Create a new row at top if a_start is True, otherwise create a new row at bottom.
		local
			l_new_row: SD_TOOL_BAR_ROW
		do
			create l_new_row.make (internal_vertical)
			if a_start then
				internal_box.start
				internal_box.put_left (l_new_row)
			else
				internal_box.extend (l_new_row)
			end
			l_new_row.extend (internal_dock_mediator.caller)
			-- On windows, following line is not needed,
			-- But on Gtk, we need first disable_capture (in SD_TOOL_BAR_ZONE dock) then enable capture,
			-- because it's off-screen widget, it'll not have capture when it show again.
			internal_dock_mediator.caller.enable_capture
			
			internal_docking_manager.command.resize (True)
			debug ("docking")
				print ("%N SD_TOOL_BAR_HOT_ZONE create new row. Docking Manage Resize *****************")
			end
		ensure
			extended: old internal_box.count = internal_box.count - 1
		end

	prune_internal_caller_from_parent is
			-- Prune `caller' from parent.
		do
			if internal_dock_mediator.caller.row /= Void then
				if caller_in_single_row then
					internal_dock_mediator.caller.row.parent.prune (internal_dock_mediator.caller.row)
					internal_docking_manager.command.resize (True)
				end
				internal_dock_mediator.caller.row.prune (internal_dock_mediator.caller)
			end
			if internal_dock_mediator.caller.parent /= Void then
				internal_dock_mediator.caller.parent.prune (internal_dock_mediator.caller)
			end
		ensure
			pruned: internal_dock_mediator.caller.row /= Void implies
				 not internal_dock_mediator.caller.row.has (internal_dock_mediator.caller)
			parent_void: internal_dock_mediator.caller.parent = Void
		end

feature {NONE}  -- Implementation query

	caller_in_single_row: BOOLEAN is
			-- If caller's SD_tool_bar_ROW only has caller?
		do
			Result := internal_dock_mediator.caller.row.count = 1
		end

	caller_in_current_area: BOOLEAN is
			-- If caller already in `Current'?
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
		do
			from
				internal_box.start
			until
				internal_box.after or Result
			loop
				l_tool_bar_row ?= internal_box.item
				check l_tool_bar_row /= Void end
				Result := l_tool_bar_row.has (internal_dock_mediator.caller)
				internal_box.forth
			end
		end

feature {NONE} -- Implementation arrtibutes

	area: EV_RECTANGLE
			-- Tool bar area.

	internal_box: EV_BOX
			-- Tool bar container which contain SD_TOOL_BAR_ROW.

	internal_vertical: BOOLEAN
			-- If `Current' vertical?

	internal_dock_mediator: SD_TOOL_BAR_DOCKER_MEDIATOR
			-- Tool bar docker mediator.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

	last_screen_x, last_screen_y: INTEGER
			-- Last pointer screen position when called on_pointer_motion

invariant

	internal_shared_not_void: internal_shared /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
