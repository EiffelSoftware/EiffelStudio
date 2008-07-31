indexing
	description: "Objects help SD_DOCKING_MANAGER with agents issues."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_AGENTS

inherit
	ANY

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	SD_ACCESS

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
			internal_docking_manager.main_window.focus_out_actions.extend (agent on_main_window_focus_out)
			internal_docking_manager.main_window.focus_in_actions.extend (agent on_main_window_focus_in)
			pnd_motion_actions_handler := agent on_pnd_motions
			pick_actions_handler := agent on_pick_actions
			drop_actions_handler := agent on_drop_actions
			theme_changed_handler := agent on_theme_changed
			ev_application.pnd_motion_actions.extend (pnd_motion_actions_handler)
			ev_application.pick_actions.extend (pick_actions_handler)
			ev_application.drop_actions.extend (drop_actions_handler)
			ev_application.theme_changed_actions.extend (theme_changed_handler)

			create internal_shared
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Command

	init_actions is
			-- Initlialize actions.
		do
			internal_docking_manager.contents.add_actions.extend (agent on_added_content)
			internal_docking_manager.contents.remove_actions.extend (agent on_prune_content)
			internal_docking_manager.zones.zones.add_actions.extend (agent on_added_zone)
			internal_docking_manager.zones.zones.remove_actions.extend (agent on_pruned_zone)
			internal_docking_manager.internal_viewport.resize_actions.extend (agent on_resize (?, ?, ?, ?, False))
			widget_pointer_press_handler := agent on_widget_pointer_press
			widget_pointer_press_for_upper_zone_handler := agent on_widget_pointer_press_for_upper_zone
			ev_application.pointer_button_press_actions.extend (widget_pointer_press_handler)
			ev_application.pointer_button_press_actions.extend (widget_pointer_press_for_upper_zone_handler)
			internal_docking_manager.main_window.focus_out_actions.extend (agent on_top_level_window_focus_out)
			internal_docking_manager.main_window.focus_in_actions.extend (agent on_top_level_window_focus_in)
		end

feature  -- Agents

	on_widget_pointer_press (a_widget: EV_WIDGET; a_button, a_x, a_y: INTEGER) is
			-- Handle EV_APPLICATION's pointer button press actions.
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_content: SD_CONTENT
		do
			l_zones := internal_docking_manager.zones.zones.twin
			from
				l_zones.start
			until
				l_zones.after
			loop
				if not l_zones.item.is_destroyed and then (l_zones.item.has_recursive (a_widget) and not ignore_additional_click) and l_zones.item.content /= internal_docking_manager.zones.place_holder_content then
					if internal_docking_manager.property.last_focus_content /= l_zones.item.content then
						internal_docking_manager.property.set_last_focus_content (l_zones.item.content)
						l_zones.item.on_focus_in (Void)
						if l_zones.item.content.focus_in_actions /= Void then
							l_zones.item.content.focus_in_actions.call (Void)
						end
					else
						l_content := internal_docking_manager.property.last_focus_content
						if l_content /= Void then
							l_auto_hide_zone ?= l_content.state.zone
						end
						if l_auto_hide_zone = Void and not ignore_additional_click then
							internal_docking_manager.command.remove_auto_hide_zones (True)
						elseif l_auto_hide_zone /= Void then
							l_auto_hide_zone.set_focus_color (True)
						end
					end
				end
				l_zones.forth
			end

			ignore_additional_click := False
		end

	on_widget_pointer_press_for_upper_zone (a_widget: EV_WIDGET; a_button, a_x, a_y: INTEGER) is
			-- Handle EV_APPLICATION's pointer button press actions, for recover SD_UPPER_ZONE's size.
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_upper_zone: SD_UPPER_ZONE
			l_tool_bar: EV_TOOL_BAR
		do
			l_zones := internal_docking_manager.zones.zones.twin
			from
				l_zones.start
			until
				l_zones.after
			loop
				l_upper_zone ?= l_zones.item
				if l_upper_zone /= Void then
					if l_zones.item.has_recursive (a_widget) then
						l_tool_bar ?= a_widget
						-- We ignore click on tool bar.
						if l_tool_bar = Void and then not l_upper_zone.is_ignore_restore_area then
							l_upper_zone.recover_normal_size_from_minimize
						end
					end
				end
				l_zones.forth
			end
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER; a_force: BOOLEAN) is
			-- Handle resize zone event. Resize all the widgets in fixed_area (EV_FIXED).
		local
			l_width: INTEGER
			l_main_container: SD_MULTI_DOCK_AREA
		do
			debug ("docking")
				io.put_string ("%N SD_DOCKING_MANAGER on_resize ~~~~~~~~~~~~~~~~~~~~")
			end
			internal_docking_manager.command.remove_auto_hide_zones (False)

			-- This is to make sure item in `fixed_area' is resized, otherwise zone's size is incorrect when maximize a zone.
			internal_docking_manager.fixed_area.set_minimum_size (0, 0)

			if a_width > 0 then
				internal_docking_manager.internal_viewport.set_item_width (internal_docking_manager.internal_viewport.width)

				-- We have to make sure `l_width' not smaller than the minimum width of `l_main_container''s item.
				-- Otherwise, it will cause bug#12065. This bug ONLY happens on Solaris (both CDE and JDS), not happens on Windows, Ubuntu.
				-- And we don't need to care about the height of `l_main_container''s item since it works fine.
				l_main_container := internal_docking_manager.query.inner_container_main
				l_width := internal_docking_manager.fixed_area.width
				if l_main_container.readable and then l_main_container.item /= Void and then l_width < l_main_container.item.minimum_width then
					l_width := l_main_container.item.minimum_width
				end
				internal_docking_manager.fixed_area.set_item_width (l_main_container , l_width)
			end
			if a_height > 0 then
				internal_docking_manager.internal_viewport.set_item_height (internal_docking_manager.internal_viewport.height)
				internal_docking_manager.fixed_area.set_item_height (internal_docking_manager.query.inner_container_main, internal_docking_manager.fixed_area.height)
			end
			internal_docking_manager.tool_bar_manager.on_resize (a_x, a_y, internal_docking_manager.internal_viewport.width, internal_docking_manager.internal_viewport.height, a_force)
		end

	on_added_zone (a_zone: SD_ZONE) is
			-- Handle inserted a zone event.
		do
		end

	on_pruned_zone (a_zone: SD_ZONE) is
			-- Handle pruned a zone event.
		require
			a_zone_not_void: a_zone /= Void
		do
		end

	on_added_content (a_content: SD_CONTENT) is
			--  Handle added a content to contents.
		require
			a_content_widget_valid: user_widget_valid (a_content)
			title_unique: title_unique (a_content)
		do
			a_content.set_docking_manager (internal_docking_manager)
		ensure
			set: a_content.docking_manager = internal_docking_manager
		end

	on_prune_content (a_content: SD_CONTENT) is
			--  Handle prune a content from contents.
		require
			not_void: a_content /= Void
		do
			a_content.set_docking_manager (Void)
		ensure
			set: a_content.docking_manager = Void
		end

	on_main_window_focus_out is
			-- Handle window lost focus event.
		local
			l_content: SD_CONTENT
			l_zone: SD_ZONE
		do
			if internal_docking_manager /= Void then
				l_content := internal_docking_manager.property.last_focus_content
				l_zone := internal_docking_manager.zones.zone_by_content (l_content)
				if l_zone /= Void and then internal_docking_manager.main_container.has_recursive (l_zone) then
					l_zone.set_non_focus_selection_color
				end
			end
			debug ("docking")
				print ("%NSD_DOCKING_MANAGER_AGENTS on_main_window_focus_out ")
			end
		end

	on_main_window_focus_in is
			-- Handle window get focus event.
		local
			l_content: SD_CONTENT
			l_zone: SD_ZONE
		do
			if internal_docking_manager /= Void then
				l_content := internal_docking_manager.property.last_focus_content
				l_zone := internal_docking_manager.zones.zone_by_content (l_content)
				if l_zone /= Void and then internal_docking_manager.main_container.has_recursive (l_zone) then
					l_zone.set_focus_color (True)
				end
			end
			debug ("docking")
				print ("%NSD_DOCKING_MANAGER_AGENTS on_main_window_focus_in ")
			end
		end

	on_top_level_window_focus_out
			-- Handle top level window focus out actions.
		local
			l_floating_zones: ARRAYED_LIST [SD_FLOATING_ZONE]
			l_has_focus: BOOLEAN
		do
			if internal_docking_manager /= Void then
				if not internal_docking_manager.main_window.is_destroyed and not internal_docking_manager.property.is_opening_config then
					l_floating_zones := internal_docking_manager.query.floating_zones
					l_has_focus := internal_docking_manager.main_window.has_focus
					if not l_has_focus then
						from
							l_floating_zones.start
						until
							l_floating_zones.after or l_has_focus
						loop
							l_has_focus := l_floating_zones.item.has_focus
							l_floating_zones.forth
						end
					end
					if not l_has_focus then
						--FIXIT: Currently we disable this feature.
						-- Because when show a dialog, it'll get focus, make main window lost focus.
						-- We should make a window can never get focus first.
		--				internal_docking_manager.tool_bar_manager.hide_all_floating
					end
				end
			end
		end

	on_top_level_window_focus_in is
			-- Handle top level window focus in actions.
		do
--			internal_docking_manager.tool_bar_manager.show_all_floating
		end

	on_pick_actions (a_pebble: ANY) is
			-- Handle pick actions.
		do
			focused_tab_stub := Void
		end

	on_drop_actions (a_pebble: ANY) is
			-- Handle drop actions.
		do
			ignore_additional_click := True
		end

	on_theme_changed is
			-- Handle theme changed actions.
		do
			internal_docking_manager.query.auto_hide_panel ({SD_ENUMERATION}.top).set_background_color (internal_shared.non_focused_color_lightness)
			internal_docking_manager.query.auto_hide_panel ({SD_ENUMERATION}.bottom).set_background_color (internal_shared.non_focused_color_lightness)
			internal_docking_manager.query.auto_hide_panel ({SD_ENUMERATION}.left).set_background_color (internal_shared.non_focused_color_lightness)
			internal_docking_manager.query.auto_hide_panel ({SD_ENUMERATION}.right).set_background_color (internal_shared.non_focused_color_lightness)
			internal_docking_manager.main_container.set_background_color (internal_shared.non_focused_color_lightness)
		end

	on_pnd_motions (a_x, a_y: INTEGER; a_target: EV_ABSTRACT_PICK_AND_DROPABLE) is
			-- Handle pick and drop motion actions.
			-- We notify all auto hide tab stubs when pick and drop shere.
		local
			l_widget: EV_WIDGET
			l_screen_x, l_screen_y: INTEGER
			l_screen: EV_SCREEN
			l_position: EV_COORDINATE
		do
			create l_screen
			l_position := l_screen.pointer_position

			l_screen_x := l_position.x
			l_screen_y := l_position.y

			if not notify_one_auto_hide_panel ({SD_ENUMERATION}.top, l_widget, l_screen_x, l_screen_y) then
				if not notify_one_auto_hide_panel ({SD_ENUMERATION}.bottom, l_widget, l_screen_x, l_screen_y) then
					if not notify_one_auto_hide_panel ({SD_ENUMERATION}.left, l_widget, l_screen_x, l_screen_y) then
						if not notify_one_auto_hide_panel ({SD_ENUMERATION}.right, l_widget, l_screen_x, l_screen_y) then
							if not pointer_in_tab then
								focused_tab_stub := Void
							end
						end
					end
				end
			end
			debug ("docking")
				print ("%N SD_DOCKING_MANAGER_AGETNS on_pnd_motions: " + l_screen_x.out + " " + l_screen_y.out)
			end
		end

	focused_tab_stub: SD_TAB_STUB
			-- Current focused auto hide tab stub during pick and drop.

	pointer_in_tab: BOOLEAN
			-- During pick and drop, if pointer position with in a tab stub?

	notify_one_auto_hide_panel (a_direction: INTEGER; a_target: EV_WIDGET; a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Notify one auto hide
			-- Result is if notified one tab stub
		require
			vaild: (create {SD_ENUMERATION}).is_direction_valid (a_direction)
		local
			l_panel: SD_AUTO_HIDE_PANEL
			l_stubs: ARRAYED_LIST [SD_TAB_STUB]
			l_state: SD_AUTO_HIDE_STATE
			l_stub: SD_TAB_STUB
		do
			l_panel := internal_docking_manager.query.auto_hide_panel (a_direction)
			l_stubs := l_panel.tab_stubs

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
				l_state ?= l_stubs.item.content.state
				check must_be_auto_hide_state: l_state /= Void end
				-- a_target not correct?
				l_state.animation.on_pointer_motion (a_target, a_screen_x, a_screen_y)

				debug ("docking")
					print ("%N SD_DOCKING_MANAGER_AGETNS notify_one_auto_hide_panel l_stubs.item screen_x, screen_y, width, height: " + l_stub.screen_x.out + " " + l_stub.screen_y.out + " " + l_stub.width.out + " " + l_stub.height.out)
				end

				l_stubs.forth
			end
		end

feature -- Destory

	destroy is
			-- Destory all underline objects
		local
			l_viewport: EV_VIEWPORT
		do
			if internal_docking_manager /= Void then
				l_viewport := internal_docking_manager.internal_viewport
				check not_void: l_viewport /= Void end
				l_viewport.resize_actions.wipe_out
			end

			ev_application.pnd_motion_actions.prune_all (pnd_motion_actions_handler)
			ev_application.pick_actions.prune_all (pick_actions_handler)
			ev_application.drop_actions.prune_all (drop_actions_handler)
			ev_application.theme_changed_actions.prune_all (theme_changed_handler)
			ev_application.pointer_button_press_actions.prune_all (widget_pointer_press_handler)
			ev_application.pointer_button_press_actions.prune_all (widget_pointer_press_for_upper_zone_handler)
			focused_tab_stub := Void
			internal_docking_manager := Void
		end

feature -- Contract support

	user_widget_valid (a_content: SD_CONTENT): BOOLEAN is
			-- Dose a_widget alreay in docking library?
		local
			l_container: EV_CONTAINER
			l_found: BOOLEAN
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			l_contents := internal_docking_manager.contents.twin

			from
				l_contents.start
			until
				l_contents.after or l_found
			loop
				if l_contents.item /= a_content then
					l_container ?= l_contents.item.user_widget
					if l_container /= Void then
						if l_container.has_recursive (a_content.user_widget) then
							l_found := True
						end
					end

					if a_content.user_widget = l_contents.item.user_widget then
						l_found := True
					end
				end

				l_contents.forth
			end
			Result := not l_found
		end

	title_unique (a_content: SD_CONTENT): BOOLEAN is
			-- If `a_unique_title' really unique?
		require
			a_content_not_void: a_content /= Void
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			l_contents := internal_docking_manager.contents.twin
			Result := True

			from
				l_contents.start
			until
				l_contents.after or not Result
			loop
				if l_contents.item /= a_content then
					Result := not l_contents.item.unique_title.as_string_32.is_equal (a_content.unique_title.as_string_32)
				end
				l_contents.forth
			end
		end

feature {SD_DEBUG_ACCESS} -- For debug.

	show_inner_container_structure is
			-- For debug.
		do
			io.put_string ("%N --------------------- SD_DOCKING_MANAGER inner container -------------------")
			internal_docking_manager.inner_containers.start
			show_inner_container_structure_imp (internal_docking_manager.inner_containers.item.item, " ")
		end

	show_inner_container_structure_imp (a_container: EV_WIDGET; a_indent: STRING_GENERAL) is
			-- For debug.
		local
			l_split_area: EV_SPLIT_AREA
			l_docking_zone: SD_DOCKING_ZONE
		do
			l_docking_zone ?= a_container
			if l_docking_zone /= Void then
				io.put_string ("%N " + a_indent.as_string_8 + a_container.generating_type + " " + l_docking_zone.content.unique_title.as_string_8)
			else
				if a_container /= Void then
					io.put_string ("%N " + a_indent.as_string_8 + a_container.generating_type)
				else
					io.put_string ("%N " + a_indent.as_string_8 + "Void")
				end
			end
			l_split_area ?= a_container
			if l_split_area /= Void then
				show_inner_container_structure_imp (l_split_area.first, a_indent.as_string_8 + " ")
				show_inner_container_structure_imp (l_split_area.second, a_indent.as_string_8 + " ")
			end
		end

feature {NONE}  -- Implementation

	internal_shared: SD_SHARED
			-- All singletons.

	widget_pointer_press_handler: PROCEDURE [SD_DOCKING_MANAGER_AGENTS, TUPLE [EV_WIDGET, INTEGER_32, INTEGER_32, INTEGER_32]]
			-- Pointer press actions.

	widget_pointer_press_for_upper_zone_handler: PROCEDURE [SD_DOCKING_MANAGER_AGENTS, TUPLE [EV_WIDGET, INTEGER_32, INTEGER_32, INTEGER_32]]
			-- Pointer press actions for SD_UPPER_ZONEs.

	pnd_motion_actions_handler: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, EV_ABSTRACT_PICK_AND_DROPABLE]]
			-- Pick and Drop pointer motion action handler.

	pick_actions_handler: PROCEDURE [SD_DOCKING_MANAGER_AGENTS, TUPLE [ANY]]
			-- Pick actions handler

	drop_actions_handler: PROCEDURE [SD_DOCKING_MANAGER_AGENTS, TUPLE [ANY]]
			-- Drop actions handler

	theme_changed_handler: PROCEDURE [SD_DOCKING_MANAGER_AGENTS, TUPLE[]]
			-- Theme changed actions handler.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current associate with.

	ignore_additional_click: BOOLEAN
			-- Ingore additional pointer click after pick and drop.

invariant
	not_void: pnd_motion_actions_handler /= Void
	not_void: theme_changed_handler /= Void
	not_void: internal_shared /= Void

indexing
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
