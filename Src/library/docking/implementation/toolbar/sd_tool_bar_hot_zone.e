note
	description: "Tool bar hot zone of four tool bar area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_HOT_ZONE

inherit
	SD_ACCESS

	SD_DOCKING_MANAGER_HOLDER

create
	make

feature {NONE} -- Initialization

	make (a_tool_bar_box: EV_BOX; a_vertical: BOOLEAN)
			-- Creation method
		require
			a_tool_bar_box_not_void: a_tool_bar_box /= Void
		do
			create internal_shared

			internal_box := a_tool_bar_box
			internal_vertical := a_vertical

			create area.make (internal_box.screen_x, internal_box.screen_y, internal_box.width, internal_box.height)
		ensure
			internal_box_set: a_tool_bar_box = internal_box
		end

feature -- Query

	area_managed: EV_RECTANGLE
			-- Managed area. Different from `area', it's bigger
		local
			l_area: EV_RECTANGLE
		do
			l_area := area.twin
			if internal_vertical then
				l_area.set_left (l_area.left - internal_shared.tool_bar_size)
				l_area.set_right (l_area.right + internal_shared.tool_bar_size)
			else
				l_area.set_top (l_area.top - internal_shared.tool_bar_size)
				l_area.set_bottom (l_area.bottom + internal_shared.tool_bar_size)
			end
			Result := l_area
		ensure
			not_void: Result /= Void
		end

feature -- Command

	on_pointer_motion (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- Handle pointer motion
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

	start_drag
			-- Start drag
		do
			from
				internal_box.start
			until
				internal_box.after
			loop
				if attached {SD_TOOL_BAR_ROW} internal_box.item as l_tool_bar_row then
					if attached {EV_WIDGET} docker_mediator.caller.tool_bar as lt_widget then
						l_tool_bar_row.start_drag (lt_widget)
					else
						check not_possible: False end
					end
				else
					check box_only_have_tool_bar_row: False end
				end

				internal_box.forth
			end
		ensure
			every_row_notified:
		end

	set_tool_bar_mediator (a_tool_bar_dock_mediator: like internal_dock_mediator)
			-- Set `internal_dock_mediator'
		require
			a_tool_bar_dock_mediator_not_void: a_tool_bar_dock_mediator /= Void
		do
			internal_dock_mediator := a_tool_bar_dock_mediator
			set_docking_manager (docker_mediator.docking_manager)
		ensure
			internal_tool_bar_dock_mediator_set: a_tool_bar_dock_mediator = internal_dock_mediator
		end

	docker_mediator: SD_TOOL_BAR_DOCKER_MEDIATOR
			-- Tool bar docker mediator
		require
			set: is_docker_mediator_set
		local
			l_result: like internal_dock_mediator
		do
			l_result := internal_dock_mediator
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	is_docker_mediator_set: BOOLEAN
			-- If `internal_dock_mediator' has been set?
		do
			Result := internal_dock_mediator /= Void
		end

feature {NONE} -- Implementation functions

	move_in (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- Handle pointer move in one row/column
		do
			from
				internal_box.start
			until
				internal_box.after or Result
			loop
				if attached {SD_TOOL_BAR_ROW} internal_box.item as l_tool_bar_row then
					if attached {EV_WIDGET} docker_mediator.caller.tool_bar as lt_widget then
						if not l_tool_bar_row.has (lt_widget)  then
							if (l_tool_bar_row.has_screen_y (a_screen_y) and not internal_vertical)
								or (l_tool_bar_row.has_screen_x (a_screen_x) and internal_vertical) then
								--Change caller's row.
								docking_manager.command.lock_update (Void, True)
								prune_internal_caller_from_parent
								l_tool_bar_row.extend (docker_mediator.caller)

								docker_mediator.caller.tool_bar.enable_capture
								debug ("docking")
									print ("%N SD_TOOL_BAR_HOT_ZONE move_in a_screen_x: " + a_screen_x.out + " .a_screen_y: " + a_screen_y.out)
								end
								if internal_vertical then
									l_tool_bar_row.on_pointer_motion (a_screen_y)
								else
									l_tool_bar_row.on_pointer_motion (a_screen_x)
								end
								docking_manager.command.resize (True)
								docking_manager.command.unlock_update
								Result := True
							end
						end
					else
						check not_possible: False end
					end

					if not internal_box.after then
						internal_box.forth
					end
				else
					check False end -- Implied by the design of `internal_box'
				end
			end
		end

	move_out (a_screen_y_or_x: INTEGER): BOOLEAN
			-- Handle pointer move into SD_TOOL_BAR_ROW
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
					docking_manager.command.lock_update (Void, True)
					if docker_mediator.caller.is_floating then
						-- Ignore focus out actions during the process of changing from floating to docking.
						docker_mediator.set_ignore_focus_out_actions (True)
						docker_mediator.caller.dock
						docker_mediator.set_ignore_focus_out_actions (False)
					end
					create_new_row_by_position (a_screen_y_or_x)
					docking_manager.command.unlock_update
				end
			end
		end

	create_new_row_by_position (a_screen_y_or_x: INTEGER)
			-- Create new row base on `a_screen_or_x'
			-- `a_screen_y_or_x' is y for top and bottom tool bar areas
			-- `a_screen_y_or_x' is x for left and right tool bar areas
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

	create_new_row (a_start: BOOLEAN; a_screen_position: INTEGER)
			-- Create a new row at top if a_start is True, otherwise create a new row at bottom
		local
			l_new_row: SD_TOOL_BAR_ROW
		do
			create l_new_row.make (docking_manager, internal_vertical)
			if a_start then
				internal_box.start
				internal_box.put_left (l_new_row)
			else
				internal_box.extend (l_new_row)
			end
			l_new_row.extend (docker_mediator.caller)
			-- On windows, following line is not needed,
			-- But on Gtk, we need first disable_capture (in SD_TOOL_BAR_ZONE dock) then enable capture,
			-- because it's off-screen widget, it'll not have capture when it show again.
			docker_mediator.caller.tool_bar.enable_capture

			docking_manager.command.resize (True)
			docking_manager.command.resize (True) -- FIXIT: We have to call it twice on Windows since when a tool bar dock vertically, otherwise the width of right tool bar main area is not correct. New void-safe Vision2 bug?
			debug ("docking")
				print ("%N SD_TOOL_BAR_HOT_ZONE create new row. Docking Manage Resize *****************")
			end
		ensure
			extended: old internal_box.count = internal_box.count - 1
		end

	prune_internal_caller_from_parent
			-- Prune `caller' from parent
		local
			l_row: detachable SD_TOOL_BAR_ROW
			l_parent: detachable EV_CONTAINER
		do
			l_row := docker_mediator.caller.row
			if l_row /= Void then
				l_row.prune (docker_mediator.caller)
				check pruned: docker_mediator.caller.row = Void end
				if l_row.count = 0 then
					l_parent := l_row.parent
					if l_parent /= Void then
						l_parent.prune (l_row)
					end
					l_row.destroy
					docking_manager.command.resize (True)
				end
			end
			-- Maybe parent is floating tool bar zone
			if attached {EV_WIDGET} docker_mediator.caller.tool_bar as lt_widget then
				if lt_widget.parent /= Void then
					check is_floating: docker_mediator.caller.is_floating end
					docker_mediator.set_ignore_focus_out_actions (True)
					docker_mediator.caller.dock
					docker_mediator.set_ignore_focus_out_actions (False)
				end
			else
				check not_possible: False end
			end

		ensure
			pruned: (attached docker_mediator.caller.row as le_row and then attached {EV_WIDGET} docker_mediator.caller.tool_bar as lt_widget_2)
			implies not le_row.has (lt_widget_2)
			parent_row_void: docker_mediator.caller.row = Void
			parent_void: attached {EV_WIDGET} docker_mediator.caller.tool_bar as lt_widget_3 implies lt_widget_3.parent = Void
		end

feature {NONE}  -- Implementation query

	caller_in_single_row: BOOLEAN
			-- If caller's SD_tool_bar_ROW only has caller?
		require
			set: attached docker_mediator.caller.row
		do
			if attached docker_mediator.caller.row as l_row then
				Result := l_row.count = 1
			else
				check False end -- Implied by precondition
			end
		end

	caller_in_current_area: BOOLEAN
			-- If caller already in `Current'?
		do
			from
				internal_box.start
			until
				internal_box.after or Result
			loop
				if attached {SD_TOOL_BAR_ROW} internal_box.item as l_tool_bar_row then
					if attached {EV_WIDGET} docker_mediator.caller.tool_bar as lt_widget then
						Result := l_tool_bar_row.has (lt_widget)
					else
						check not_possible: False end
					end
				else
					check False end -- Implied by design of `internal_box'
				end
				internal_box.forth
			end
		end

feature {NONE} -- Implementation arrtibutes

	area: EV_RECTANGLE
			-- Tool bar area

	internal_box: EV_BOX
			-- Tool bar container which contain SD_TOOL_BAR_ROW

	internal_vertical: BOOLEAN
			-- If `Current' vertical?

	internal_dock_mediator: detachable SD_TOOL_BAR_DOCKER_MEDIATOR
			-- Tool bar docker mediator

	internal_shared: SD_SHARED
			-- All singletons

	last_screen_x, last_screen_y: INTEGER
			-- Last pointer screen position when called on_pointer_motion

invariant

	internal_shared_not_void: internal_shared /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
