note
	description: "Objects help SD_DOCKING_MANAGER with agents issues."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_AGENTS

inherit
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	SD_ACCESS

	SD_DOCKING_MANAGER_HOLDER

	EV_BUILDER

create
	make

feature {NONE} -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER)
			-- Associate new object with `a_docking_manager'.
		do
			docking_manager := a_docking_manager
			main_window_focus_out := agent on_main_window_focus_out
			main_window_focus_in := agent on_main_window_focus_in
			pnd_motion_actions_handler := agent on_pnd_motions
			pick_actions_handler := agent on_pick_actions
			drop_actions_handler := agent on_drop_actions
			theme_changed_handler := agent on_theme_changed
			create internal_shared

			widget_pointer_press_handler := agent on_widget_pointer_press
			widget_pointer_press_for_upper_zone_handler := agent on_widget_pointer_press_for_upper_zone
			top_level_window_focus_out := agent on_top_level_window_focus_out
			top_level_window_focus_in := agent on_top_level_window_focus_in
		end

feature {SD_DOCKING_MANAGER} -- Initialization

	add_actions
			-- Register required actions.
		do
			ev_application.pnd_motion_actions.extend (pnd_motion_actions_handler)
			ev_application.pick_actions.extend (pick_actions_handler)
			ev_application.drop_actions.extend (drop_actions_handler)
			ev_application.theme_changed_actions.extend (theme_changed_handler)
			docking_manager.main_window.focus_out_actions.extend (main_window_focus_out)
			docking_manager.main_window.focus_in_actions.extend (main_window_focus_in)
		end

feature -- Command

	init_actions
			-- Initlialize actions
		require
			not_destroyed: not is_destroyed
		local
			l_docking_manager: like docking_manager
		do
			l_docking_manager := docking_manager
			l_docking_manager.contents.add_actions.extend (agent on_added_content)
			l_docking_manager.contents.remove_actions.extend (agent on_prune_content)
			l_docking_manager.zones.zones.add_actions.extend (agent on_added_zone)
			l_docking_manager.zones.zones.remove_actions.extend (agent on_pruned_zone)
			l_docking_manager.internal_viewport.resize_actions.extend (agent on_resize (?, ?, ?, ?, False))
			l_docking_manager.internal_viewport.dpi_changed_actions.extend (agent on_dpi_change_resize (?, ?, ?, ?, ?, False))

			ev_application.pointer_button_press_actions.extend (widget_pointer_press_handler)
			ev_application.pointer_button_press_actions.extend (widget_pointer_press_for_upper_zone_handler)

			l_docking_manager.main_window.focus_out_actions.extend (top_level_window_focus_out)
			l_docking_manager.main_window.focus_in_actions.extend (top_level_window_focus_in)
		end

feature -- Agents

	on_widget_pointer_press (a_widget: EV_WIDGET; a_button, a_x, a_y: INTEGER)
			-- Handle EV_APPLICATION's pointer button press actions
		require
			not_destroyed: not is_destroyed
		local
			l_auto_hide_zone: detachable SD_AUTO_HIDE_ZONE
			l_content: detachable SD_CONTENT
			l_setter: SD_SYSTEM_SETTER
			l_docking_manager: like docking_manager
		do
			create {SD_SYSTEM_SETTER_IMP} l_setter
			if not l_setter.is_during_pnd then
				l_docking_manager := docking_manager
				across
					l_docking_manager.zones.zones.twin as ic
				loop
					if
						attached ic as l_zone and then
						attached {EV_CONTAINER} l_zone as lt_container then
						if
							not lt_container.is_destroyed and then
							(is_parent_recursive (lt_container, a_widget) and not ignore_additional_click) and
							l_zone.content /= l_docking_manager.zones.place_holder_content
						then
							if l_docking_manager.property.last_focus_content = l_zone.content then
								l_content := l_docking_manager.property.last_focus_content
								if
									l_content /= Void and then
									attached {SD_AUTO_HIDE_ZONE} l_content.state.zone as z
								then
									l_auto_hide_zone := z
								end
								if l_auto_hide_zone = Void and not ignore_additional_click then
									l_docking_manager.command.remove_auto_hide_zones (True)
								elseif l_auto_hide_zone /= Void then
									l_auto_hide_zone.set_focus_color (True)
								end
							else
								l_docking_manager.property.set_last_focus_content (l_zone.content)
								l_zone.on_focus_in (Void)
								l_zone.content.focus_in_actions.call (Void)
							end
						end
					else
						check not_possible: False end
					end
				end

				ignore_additional_click := False
			end
		end

	on_widget_pointer_press_for_upper_zone (a_widget: EV_WIDGET; a_button, a_x, a_y: INTEGER)
			-- Handle EV_APPLICATION's pointer button press actions, for recover SD_UPPER_ZONE's size
		require
			not_destroyed: not is_destroyed
		do
			across
				docking_manager.zones.zones.twin as ic
			loop
				if attached {SD_UPPER_ZONE} ic as l_upper_zone then
					if attached {EV_CONTAINER} ic as lt_container then
						if
							is_parent_recursive (lt_container, a_widget) and then
							not attached {EV_TOOL_BAR} a_widget and then -- We ignore click on tool bar.
							not l_upper_zone.is_ignore_restore_area and then
							l_upper_zone.is_notebook_set
						then
							l_upper_zone.recover_normal_size_from_minimize
						end
					else
						check not_possible: False end
					end
				end
			end
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER; a_force: BOOLEAN)
			-- Handle resize zone event. Resize all the widgets in fixed_area (EV_FIXED)
		require
			not_destroyed: not is_destroyed
		local
			l_viewport_width, l_viewport_height: INTEGER
			l_fixed_area_width, l_fixed_area_height: INTEGER
			l_main_container: SD_MULTI_DOCK_AREA
			l_fixed_area: EV_FIXED
			l_internal_viewport: EV_VIEWPORT
			l_docking_manager: like docking_manager
		do
			debug ("docking")
				io.put_string ("%N SD_DOCKING_MANAGER {" + generator + "}.on_resize ~~~~~~~~~~~~~~~~~~~~%N")
				io.put_string (  " SD_DOCKING_MANAGER -> (" + a_x.out + ", " + a_y.out + ") " + a_width.out + " x " + a_height.out + "%N")
			end
			l_docking_manager := docking_manager
			l_docking_manager.command.remove_auto_hide_zones (False)

			l_internal_viewport := l_docking_manager.internal_viewport
			l_fixed_area := l_docking_manager.fixed_area

			l_viewport_width := l_internal_viewport.width
			l_viewport_height := l_internal_viewport.height

				-- This is to make sure item in `fixed_area' is resized, otherwise zone's size is incorrect when maximize a zone
			l_fixed_area.set_minimum_size (1, 1)

			check same_size_as_viewport: l_viewport_width = a_width and l_viewport_height = a_height end

			l_main_container := l_docking_manager.query.inner_container_main

			if a_width > 0 and a_height > 0 then
				if l_viewport_width > 0 or l_viewport_height > 0 then
					if attached l_internal_viewport.item as l_viewport_item then
						l_viewport_item.reset_minimum_size
						l_internal_viewport.set_item_size (l_viewport_width.max (l_viewport_item.minimum_width), l_viewport_height.max (l_viewport_item.minimum_height))
					else
						check False end
						l_internal_viewport.set_item_size (l_viewport_width, l_viewport_height)
					end
				end

					-- We have to make sure `l_width' not smaller than the minimum width of `l_main_container''s item
					-- Otherwise, it will cause bug#12065. This bug ONLY happens on Solaris (both CDE and JDS), not happens on Windows, Ubuntu
					-- And we don't need to care about the height of `l_main_container''s item since it works fine
				l_fixed_area_width := l_fixed_area.width
				l_fixed_area_height :=  l_fixed_area.height
				if
					l_main_container.readable and then
					attached l_main_container.item as l_main_container_item
				then
					l_fixed_area_width := l_fixed_area_width.max (l_main_container_item.minimum_width)
					l_fixed_area_height := l_fixed_area_height.max (l_main_container_item.minimum_height)
				end
				if l_fixed_area_width > 0 or l_fixed_area_height > 0 then
					l_main_container.reset_minimum_size
					l_fixed_area.set_item_size (l_main_container, l_fixed_area_width, l_fixed_area_height)
				end
			elseif a_width > 0 then
				if l_viewport_width > 0 then
					if attached l_internal_viewport.item as l_viewport_item then
						l_viewport_item.reset_minimum_width
						l_internal_viewport.set_item_width (l_viewport_width.max (l_viewport_item.minimum_width))
					else
						check False end
						l_internal_viewport.set_item_width (l_viewport_width)
					end
				end

					-- We have to make sure `l_width' not smaller than the minimum width of `l_main_container''s item
					-- Otherwise, it will cause bug#12065. This bug ONLY happens on Solaris (both CDE and JDS), not happens on Windows, Ubuntu
					-- And we don't need to care about the height of `l_main_container''s item since it works fine
				l_fixed_area_width := l_fixed_area.width
				if
					l_main_container.readable and then
					attached l_main_container.item as l_main_container_item
				then
					l_fixed_area_width := l_fixed_area_width.max (l_main_container_item.minimum_width)
				end
				if l_fixed_area_width > 0 then
					l_main_container.reset_minimum_width
					l_fixed_area.set_item_width (l_main_container, l_fixed_area_width)
				end
			elseif a_height > 0 then
				if l_viewport_height > 0 then
					if attached l_internal_viewport.item as l_viewport_item then
						l_viewport_item.reset_minimum_height
						l_internal_viewport.set_item_height (l_viewport_height.max (l_viewport_item.minimum_height))
					else
						check False end
						l_internal_viewport.set_item_height (l_viewport_height)
					end
				end
				l_fixed_area_height := l_fixed_area.height
				if l_fixed_area_height > 0 then
					l_main_container.reset_minimum_height
					l_fixed_area.set_item_height (l_main_container, l_fixed_area_height)
				end
			end
			l_docking_manager.tool_bar_manager.on_resize (a_x, a_y, l_viewport_width, l_viewport_height, a_force)
			if attached l_internal_viewport.item as l_viewport_item then
					-- Make sure the viewport item is also resized when the viewport is resized.
					-- note: without this code, the behavior is unexpected whenever the window is resized (until a sd tool is maximized then unmaximized)
				l_viewport_item.reset_minimum_size
				l_internal_viewport.set_item_size (a_width.max (l_viewport_item.minimum_width), a_height.max (l_viewport_item.minimum_height))
			end
		end

	on_dpi_change_resize (a_dpi: NATURAL_32; a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER; a_force: BOOLEAN)
			-- Handle dpi change zone event. Resize all the widgets in fixed_area (EV_FIXED)
		require
			not_destroyed: not is_destroyed
		do
			on_resize (a_x, a_y, a_width, a_height, a_force)
		end

	on_added_zone (a_zone: SD_ZONE)
			-- Handle inserted a zone event
		require
			not_destroyed: not is_destroyed
		do
		end

	on_pruned_zone (a_zone: SD_ZONE)
			-- Handle pruned a zone event
		require
			not_destroyed: not is_destroyed
			a_zone_not_void: a_zone /= Void
		do
		end

	on_added_content (a_content: SD_CONTENT)
			--  Handle added a content to contents
		require
			not_destroyed: not is_destroyed
			a_content_widget_valid: user_widget_valid (a_content)
			title_unique: title_unique (a_content)
		do
			a_content.set_docking_manager (docking_manager)
		ensure
			set: a_content.docking_manager = docking_manager
		end

	on_prune_content (a_content: SD_CONTENT)
			--  Handle prune a content from contents
		require
			not_void: a_content /= Void
		do
			a_content.clear_docking_manager
		end

	on_main_window_focus_out
			-- Handle window lost focus event
		require
			not_destroyed: not is_destroyed
		local
			l_zone: detachable SD_ZONE
		do
			if attached docking_manager as l_docking_manager then
				check is_docking_manager_attached end
				if attached l_docking_manager.property.last_focus_content as l_content then
					l_zone := l_docking_manager.zones.zone_by_content (l_content)
				end
				if l_zone /= Void then
					if attached {EV_WIDGET} l_zone as lt_widget then
						if l_docking_manager.main_container.has_recursive (lt_widget) then
							l_zone.set_non_focus_selection_color
						end
					else
						check not_possible: False end
					end
				end
			end
			debug ("docking")
				print ("%NSD_DOCKING_MANAGER_AGENTS on_main_window_focus_out ")
			end
		end

	on_main_window_focus_in
			-- Handle window get focus event
		require
			not_destroyed: not is_destroyed
		local
			l_content: detachable SD_CONTENT
			l_zone: detachable SD_ZONE
		do
			if attached docking_manager as l_docking_manager then
				check is_docking_manager_attached end
				l_content := l_docking_manager.property.last_focus_content
				if l_content /= Void then
					l_zone := l_docking_manager.zones.zone_by_content (l_content)
				end
				if l_zone /= Void then
					if attached {EV_WIDGET} l_zone as lt_widget then
						if l_docking_manager.main_container.has_recursive (lt_widget) then
							l_zone.set_focus_color (True)
						end
					else
						check not_possible: False end
					end
				end
			end
			debug ("docking")
				print ("%NSD_DOCKING_MANAGER_AGENTS on_main_window_focus_in ")
			end
		end

	on_top_level_window_focus_out
			-- Handle top level window focus out actions.
		do
			if
				not is_destroyed and then
				is_docking_manager_attached and then
				not docking_manager.main_window.is_destroyed and
				not docking_manager.property.is_opening_config and then
				not docking_manager.main_window.has_focus and then
				not ∃ ic: docking_manager.query.floating_zones ¦ ic.has_focus
			then
					-- TODO: Currently we disable this feature
					-- Because when show a dialog, it'll get focus, make main window lost focus
					-- We should make a window can never get focus first
					-- docking_manager.tool_bar_manager.hide_all_floating
			end
		end

	on_top_level_window_focus_in
			-- Handle top level window focus in actions
		require
			not_destroyed: not is_destroyed
		do
--			docking_manager.tool_bar_manager.show_all_floating
		end

	on_pick_actions (a_pebble: ANY)
			-- Handle pick actions
		require
			not_destroyed: not is_destroyed
		do
			focused_tab_stub := Void
		end

	on_drop_actions (a_pebble: ANY)
			-- Handle drop actions
		require
			not_destroyed: not is_destroyed
		do
			ignore_additional_click := True
		end

	on_theme_changed
			-- Handle theme changed actions
		require
			not_destroyed: not is_destroyed
		do
			docking_manager.query.auto_hide_panel ({SD_ENUMERATION}.top).set_background_color (internal_shared.non_focused_color_lightness)
			docking_manager.query.auto_hide_panel ({SD_ENUMERATION}.bottom).set_background_color (internal_shared.non_focused_color_lightness)
			docking_manager.query.auto_hide_panel ({SD_ENUMERATION}.left).set_background_color (internal_shared.non_focused_color_lightness)
			docking_manager.query.auto_hide_panel ({SD_ENUMERATION}.right).set_background_color (internal_shared.non_focused_color_lightness)
			docking_manager.main_container.set_background_color (internal_shared.non_focused_color_lightness)
		end

	on_pnd_motions (a_x, a_y: INTEGER; a_target: detachable EV_ABSTRACT_PICK_AND_DROPABLE)
			-- Handle pick and drop motion actions
			-- We notify all auto hide tab stubs when pick and drop shere
		require
			not_destroyed: not is_destroyed
		local
			l_screen_x, l_screen_y: INTEGER
			l_position: EV_COORDINATE
			l_widget: EV_WIDGET
		do
				-- When set_capture, if pointer moving at area outside captured widget,
				-- the `a_target' parameter in {EV_APPLICATION}.pnd_motion_actions is void
				-- on both GTK and Windows platforms
			if attached {EV_WIDGET} a_target as w then
				l_widget := w
			end

			l_position := (create {EV_SCREEN}).pointer_position

			l_screen_x := l_position.x
			l_screen_y := l_position.y

			if
				not notify_one_auto_hide_panel ({SD_ENUMERATION}.top, l_widget, l_screen_x, l_screen_y) and then
				not notify_one_auto_hide_panel ({SD_ENUMERATION}.bottom, l_widget, l_screen_x, l_screen_y) and then
				not notify_one_auto_hide_panel ({SD_ENUMERATION}.left, l_widget, l_screen_x, l_screen_y) and then
				not notify_one_auto_hide_panel ({SD_ENUMERATION}.right, l_widget, l_screen_x, l_screen_y) and then
				not pointer_in_tab
			then
				focused_tab_stub := Void
			end

			debug ("docking")
				print ("%N SD_DOCKING_MANAGER_AGETNS on_pnd_motions: " + l_screen_x.out + " " + l_screen_y.out)
			end
		end

	focused_tab_stub: detachable SD_TAB_STUB
			-- Current focused auto hide tab stub during pick and drop

	pointer_in_tab: BOOLEAN
			-- During pick and drop, if pointer position with in a tab stub?

	notify_one_auto_hide_panel (a_direction: INTEGER; a_target: detachable EV_WIDGET; a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- Notify one auto hide
			-- Result is if notified one tab stub
		require
			not_destroyed: not is_destroyed
			vaild: (create {SD_ENUMERATION}).is_direction_valid (a_direction)
		local
			l_stubs: ARRAYED_LIST [SD_TAB_STUB]
			l_stub: SD_TAB_STUB
		do
			l_stubs := docking_manager.query.auto_hide_panel (a_direction).tab_stubs

			from
				l_stubs.start
			until
				l_stubs.after or Result
			loop
				l_stub := l_stubs.item
				if l_stub.screen_x <= a_screen_x and l_stub.screen_y <= a_screen_y and l_stub.screen_x + l_stub.width >= a_screen_x and l_stub.screen_y + l_stub.height >= a_screen_y then

					if l_stubs.item /= focused_tab_stub then
						l_stubs.item.on_pointer_enter
						focused_tab_stub := l_stubs.item
					end
					pointer_in_tab := True
					Result := True
				else
					pointer_in_tab := False
				end
				if attached {SD_AUTO_HIDE_STATE} l_stubs.item.content.state as l_state then
						-- a_target not correct?
					l_state.animation.on_pointer_motion (a_target, a_screen_x, a_screen_y)
				else
					check must_be_auto_hide_state: False end
				end

				debug ("docking")
					print ("%N SD_DOCKING_MANAGER_AGETNS notify_one_auto_hide_panel l_stubs.item screen_x, screen_y, width, height: " + l_stub.screen_x.out + " " + l_stub.screen_y.out + " " + l_stub.width.out + " " + l_stub.height.out)
				end

				l_stubs.forth
			end
		end

feature -- Destory

	destroy
			-- Destory all underline objects
		local
			l_main_window: EV_WINDOW
			ev_app: like ev_application
		do
			if attached docking_manager as l_docking_manager then
				if attached l_docking_manager.internal_viewport as l_viewport then
					l_viewport.resize_actions.wipe_out
					l_viewport.dpi_changed_actions.wipe_out
				else
					check viewport_attached: False end
				end
				l_main_window := l_docking_manager.main_window
				l_main_window.focus_out_actions.prune_all (main_window_focus_out)
				l_main_window.focus_in_actions.prune_all (main_window_focus_in)
				l_main_window.focus_out_actions.prune_all (top_level_window_focus_out)
				l_main_window.focus_in_actions.prune_all (top_level_window_focus_in)
			end
			ev_app := ev_application
			ev_app.pnd_motion_actions.prune_all (pnd_motion_actions_handler)
			ev_app.pick_actions.prune_all (pick_actions_handler)
			ev_app.drop_actions.prune_all (drop_actions_handler)
			ev_app.theme_changed_actions.prune_all (theme_changed_handler)
			ev_app.pointer_button_press_actions.prune_all (widget_pointer_press_handler)
			ev_app.pointer_button_press_actions.prune_all (widget_pointer_press_for_upper_zone_handler)
			focused_tab_stub := Void
			clear_docking_manager

			is_destroyed := True
		ensure
			destroyed: is_destroyed
		end

feature -- Contract support

	user_widget_valid (a_content: SD_CONTENT): BOOLEAN
			-- Does a_content alreay in docking system?
		require
			not_destroyed: not is_destroyed
		do
			Result := not ∃ ic: docking_manager.contents ¦
					ic /= a_content and then
					(attached {EV_CONTAINER} ic.user_widget as l_container and then
						l_container.has_recursive (a_content.user_widget) or else
						ic.user_widget = a_content.user_widget)
		end

	title_unique (a_content: SD_CONTENT): BOOLEAN
			-- If `a_unique_title' really unique?
		require
			not_destroyed: not is_destroyed
			a_content_not_void: a_content /= Void
		do
			Result :=
				∀ ic: docking_manager.contents ¦
					ic = a_content or else not ic.unique_title.same_string (a_content.unique_title)
		end

	is_destroyed: BOOLEAN
			-- If Current destroyed?

feature {NONE} -- Implementation

	is_parent_recursive (a_parent: EV_CONTAINER; a_child: EV_WIDGET): BOOLEAN
			-- If `a_parent' is parent of `a_child' ?
		require
			not_void: a_parent /= Void
			not_void: a_child /= Void
		do
			if attached a_child.parent as l_parent then
				Result := a_parent = l_parent
				if not Result then
					Result := is_parent_recursive (a_parent, l_parent)
				end
			end
		end

	internal_shared: SD_SHARED
			-- All singletons

	main_window_focus_out, main_window_focus_in,
	top_level_window_focus_out, top_level_window_focus_in: PROCEDURE
			-- Agents registered into the main window's focus in and out actions

	widget_pointer_press_handler: PROCEDURE [EV_WIDGET, INTEGER_32, INTEGER_32, INTEGER_32]
			-- Pointer press actions

	widget_pointer_press_for_upper_zone_handler: PROCEDURE [EV_WIDGET, INTEGER_32, INTEGER_32, INTEGER_32]
			-- Pointer press actions for SD_UPPER_ZONEs

	pnd_motion_actions_handler: PROCEDURE [INTEGER, INTEGER, detachable EV_ABSTRACT_PICK_AND_DROPABLE]
			-- Pick and Drop pointer motion action handler

	pick_actions_handler: PROCEDURE [ANY]
			-- Pick actions handler

	drop_actions_handler: PROCEDURE [ANY]
			-- Drop actions handler

	theme_changed_handler: PROCEDURE
			-- Theme changed actions handler

	ignore_additional_click: BOOLEAN
			-- Ingore additional pointer click after pick and drop

invariant
	pnd_motion_actions_handler_not_void: pnd_motion_actions_handler /= Void
	theme_changed_handler_not_void: theme_changed_handler /= Void
	internal_shared_not_void: internal_shared /= Void

note
	library: "SmartDocking: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
