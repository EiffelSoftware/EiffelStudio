note
	description: "Objects that hold SD_CONTENT's user widgets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_ZONE

inherit
	SD_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

	SD_DOCKING_MANAGER_HOLDER
		undefine
			default_create,
			is_equal,
			copy
		end

feature -- Command

	on_normal_max_window
			-- Normal or max `Current'
		local
			l_split_area: detachable EV_SPLIT_AREA
			l_main_area: like main_area
			l_internal_parent: detachable EV_CONTAINER
		do
			if attached {EV_WIDGET} Current as lt_widget then
				docking_manager.command.lock_update (lt_widget, False)
				l_main_area := docking_manager.query.inner_container (Current)
				main_area := l_main_area
				if not is_maximized then
					main_area_widget := l_main_area.item
					internal_parent := lt_widget.parent
					l_split_area ?= internal_parent
					if l_split_area /= Void then
						internal_parent_split_position := l_split_area.split_position
					end
					l_internal_parent := internal_parent
					check l_internal_parent /= Void end -- Implied by current displaying in main window
					l_internal_parent.prune (lt_widget)
					l_main_area.wipe_out
					l_main_area.extend (lt_widget)
					set_max (True)
					docking_manager.command.resize (True)
				else
					recover_to_normal_state
				end
				docking_manager.command.unlock_update
			else
				check not_possible: False end
			end
		end

	close
			-- Close window
		local
			l_main_area: like main_area
			l_main_area_widget: like main_area_widget
		do
			if attached {EV_WIDGET} Current as lt_widget then
				docking_manager.command.lock_update (lt_widget, False)
			else
				check not_possible: False end
			end

			if is_maximized then
				l_main_area := main_area
				check l_main_area /= Void end -- Implied by `is_maximized'
				l_main_area.wipe_out

				l_main_area_widget := main_area_widget
				check l_main_area_widget /= Void end -- Implied by `is_maximized'
				l_main_area.extend (l_main_area_widget)
				main_area := Void
			end

			docking_manager.command.unlock_update
		end

	recover_to_normal_state
			-- If Current maximized, then normal Current
		local
			l_split_area: detachable EV_SPLIT_AREA
			l_main_area: like main_area
			l_main_area_widget: like main_area_widget
			l_internal_parent: like internal_parent
		do
			if is_maximized then
				if attached {EV_WIDGET} Current as lt_widget then
					docking_manager.command.lock_update (lt_widget, False)

					if internal_parent /= main_area then
						l_main_area := main_area
						check l_main_area /= Void end -- Implied by `is_maximized'
						l_main_area.wipe_out
						if attached lt_widget.parent as l_parent then
							l_parent.prune (lt_widget)
						end
						l_internal_parent := internal_parent
						check l_internal_parent /= Void end -- Implied by `is_maximized'
						l_internal_parent.extend (lt_widget)
						l_main_area_widget := main_area_widget
						check l_main_area_widget /= Void end -- Implied by `is_maximized'
						l_main_area.extend (l_main_area_widget)
					end

					main_area := Void

					l_split_area ?= internal_parent
					-- FIXIT: Only have to check if split position in bounds on GTK, mswin is not needed
					if l_split_area /= Void and then (internal_parent_split_position >= l_split_area.minimum_split_position and
						 internal_parent_split_position <= l_split_area.maximum_split_position) then
						l_split_area.set_split_position (internal_parent_split_position)
					end
					main_area_widget := Void
					internal_parent := Void
					set_max (False)
					docking_manager.command.resize (True)
					docking_manager.command.unlock_update
				else
					check not_possible: False end
				end
			end
		end

	set_max (a_max: BOOLEAN)
			-- Set if current is maximized
		do
		end

	set_focus_color (a_focus: BOOLEAN)
			-- Set title bar focuse color
		do
		end

	set_non_focus_selection_color
			-- Set title bar non-focuse color
		do
		end

	set_last_floating_width (a_width: INTEGER)
			-- Set `last_floating_width' of zone's state
		require
			vaild: a_width >= 0
		do
			content.state.set_last_floating_width (a_width)
		ensure
			set: content.state.last_floating_width = a_width
		end

	set_last_floating_height (a_height: INTEGER)
			-- Set `last_floating_height' of a zone's state
		require
			valid: a_height >= 0
		do
			content.state.set_last_floating_height (a_height)
		ensure
			set: content.state.last_floating_height = a_height
		end

	update_mini_tool_bar_size
			-- Update mini tool bar size since client programmers mini tool bar widget size changed
		do
		end

feature {SD_DOCKING_STATE, SD_TAB_STATE} -- Maximize state initlization

	set_widget_main_area (a_widget: EV_WIDGET; a_main_area: SD_MULTI_DOCK_AREA; a_parent: EV_CONTAINER; a_split_position: INTEGER)
			-- Set widget and main area which used for normal window
		require
			a_widget_not_void: a_widget /= Void
			a_main_area_not_void: a_main_area /= Void
			a_parent_not_void: a_parent /= Void
		do
			main_area_widget := a_widget
			main_area := a_main_area
			internal_parent := a_parent
			internal_parent_split_position := a_split_position
		ensure
			set: main_area_widget = a_widget and main_area = a_main_area and internal_parent = a_parent and internal_parent_split_position = a_split_position
		end

feature -- Query

	state: SD_STATE
			-- State which `Current' is
		do
			Result := content.state
		ensure
			not_void: Result /= Void
		end

	content: SD_CONTENT
			-- Content which `Current' holded
		require
			valid: is_floating_zone implies child_zone_count = 1
		deferred
		ensure
			not_void: Result /= Void
		end

	child_zone_count: INTEGER
			-- How many zone in Current
		do
			Result := 1
		end

	extend (a_content: SD_CONTENT)
			-- Set `a_content'
		require
			a_content_not_void: a_content /= Void
		deferred
		end

	type: INTEGER
			-- Type
		do
			Result := content.type
		end

	has (a_content: SD_CONTENT): BOOLEAN
			-- `Current' has `a_content'?
		require
			a_content_not_void: a_content /= Void
		deferred
		end

	is_maximized: BOOLEAN
			-- If current maximized?
		do
			Result := False
		end

	is_floating_zone: BOOLEAN
			-- If current an instance of SD_FLOATNG_ZONE?
		local
			l_floating_zone: detachable SD_FLOATING_ZONE
		do
			l_floating_zone ?= Current
			Result := l_floating_zone /= Void
		end

feature {SD_SAVE_CONFIG_MEDIATOR} -- Save config

	save_content_title (a_config_data: SD_INNER_CONTAINER_DATA)
			-- save content(s) title(s) to `a_config_data'.
		require
			a_config_data_not_void: a_config_data /= Void
		deferred
		end

feature {SD_DOCKING_MANAGER_ZONES} -- Focus out

	on_focus_out
			-- Handle focus out
		local
			l_multi_dock_area: SD_MULTI_DOCK_AREA
		do
			l_multi_dock_area := docking_manager.query.inner_container (Current)

			if not docking_manager.query.is_main_inner_container (l_multi_dock_area) then
				if attached l_multi_dock_area.parent_floating_zone as l_parent_zone then
					l_parent_zone.set_title_focus (False)
				else
					check False end -- Implied by not `is_main_inner_container'
				end
			end
			content.focus_out_actions.call (Void)
		end

feature {SD_DOCKING_MANAGER, SD_DOCKING_MANAGER_AGENTS, SD_CONTENT, SD_STATE, SD_FLOATING_ZONE}  -- Focus in

	on_focus_in (a_content: detachable SD_CONTENT)
			-- Handle focus in
		require
			has: a_content /= Void implies has (a_content)
		local
			l_multi_dock_area: SD_MULTI_DOCK_AREA
		do
			docking_manager.zones.disable_all_zones_focus_color (Current)
			l_multi_dock_area := docking_manager.query.inner_container (Current)
			if not docking_manager.query.is_main_inner_container (l_multi_dock_area) then
				if attached l_multi_dock_area.parent_floating_zone as l_floating_zone then
					l_floating_zone.set_title_focus (True)
				else
					check False end -- Implied by not `is_main_inner_container'
				end
			end
		end

feature {SD_TAB_STATE_ASSISTANT, SD_TAB_STATE, SD_DOCKING_MANAGER_QUERY} -- Maximum issues

	main_area_widget: detachable EV_WIDGET
			-- Other user widgets when `Current' is maximized

	main_area: detachable SD_MULTI_DOCK_AREA
			-- SD_MULTI_DOCK_AREA current zone belong to

	internal_parent_split_position: INTEGER
			-- Parent split position

	internal_parent: detachable EV_CONTAINER
			-- Parent

	restore_from_maximized
			-- Restore to normal size if current maximized
		do
			if is_maximized then
				on_normal_max_window
			end
		end

feature {NONE} -- Implementation

	on_close_request
			-- Handle close request actions
		do
			content.close_request_actions.call (Void)
		end

	internal_shared: SD_SHARED
			-- All singletons

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
