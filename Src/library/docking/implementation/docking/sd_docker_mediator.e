indexing
	description: "Manager that control SD_DOCKER_SOURCE(s) and SD_HOT_ZONE(s)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKER_MEDIATOR

inherit
	ANY

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature -- Initlization

	make (a_caller: like caller; a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method
		require
			a_caller_not_void: a_caller /= Void
		local
			l_screen: SD_SCREEN
			l_factory: SD_HOT_ZONE_FACTORY_FACTORY
		do
			debug ("docking")
				print ("%NSD_DOCKER_MEDIATOR creating.....")
			end
			create internal_shared
			docking_manager := a_docking_manager
			docking_manager.command.recover_normal_state

			create {SD_HOT_ZONE_FACTORY_FACTORY_IMP} l_factory
			internal_shared.set_hot_zone_factory (l_factory.hot_zone_factory)
			internal_shared.hot_zone_factory.set_docker_mediator (Current)
			create hot_zones
			caller := a_caller
			create l_screen

			create cancel_actions
			internal_key_press_function := agent on_key_press
			internal_key_release_function := agent on_key_release
			ev_application.key_press_actions.extend (internal_key_press_function)
			ev_application.key_release_actions.extend (internal_key_release_function)

			is_dockable := True
			setter.before_enable_capture
		ensure
			set: caller = a_caller
			set: docking_manager = a_docking_manager
		end

feature -- Query

	content: SD_CONTENT is
			-- Content which is dragged by user.
		do
			Result := caller.content
		ensure
			not_void: Result /= Void
		end

	capture_enabled: like is_tracing is
			-- If is_tracing pointer motion?
		do
			Result := is_tracing
		end

	caller: SD_ZONE
			-- Zone which call this mediator.

feature -- Hanlde pointer events

	start_tracing_pointer (a_offset_x, a_offset_y: INTEGER) is
			-- Begin to trace mouss positions.
		local
			l_env: EV_ENVIRONMENT
		do
			is_tracing := True
			generate_hot_zones
			offset_x := a_offset_x
			offset_y := a_offset_y

			focus_out_agent := agent on_focus_out
			create l_env
			l_env.application.focus_out_actions.extend_kamikaze (focus_out_agent)
		ensure
			set: offset_x = a_offset_x and offset_y = a_offset_y
		end

	cancel_tracing_pointer is
			-- Cancel tracing pointer.
		do
			cancel_actions.call (Void)
			clear_up
		ensure
			not_tracing: is_tracing = False
		end

	end_tracing_pointer (a_screen_x, a_screen_y: INTEGER) is
			-- Stop is_tracing mouse positions.
		local
			changed: BOOLEAN
			l_floating_zone: SD_FLOATING_ZONE
		do
			debug ("docking")
				print ("%NSD_DOCKER_MEDIATOR end_tracing_pointer a_screen_x, a_screen_y: " + a_screen_x.out + " " + a_screen_y.out)
			end
			clear_up

			from
				hot_zones.start
			until
				hot_zones.after or changed
			loop
				changed := hot_zones.item.apply_change (a_screen_x, a_screen_y)
				hot_zones.forth
			end

			l_floating_zone ?= caller
			if not changed and l_floating_zone /= Void then
				l_floating_zone.set_position (a_screen_x - offset_x, a_screen_y - offset_y)
				debug ("docking")
					io.put_string ("%N SD_DOCKER_MEDIATOR not changed and set floating position")
				end
			end

		ensure
			not_tracing: is_tracing = False
		end

	is_tracing_pointer: BOOLEAN is
			-- If `Current' is_tracing pointer motion?
		do
			Result := is_tracing
		end

	on_pointer_motion (a_screen_x, a_screen_y: INTEGER) is
			-- When user dragging something for docking, show hot zone which allow to dock.
		require
			is_tracing: is_tracing
		local
			l_drawed: BOOLEAN
		do
			debug ("docking")
				print ("%N SD_DOCKER_MEDIATOR on_pointer_motion screen_x, screen_y: " + a_screen_x.out + " " + a_screen_y.out)
			end
			-- We only handle the case that pointer position changed
			if screen_x /= a_screen_x or screen_y /= a_screen_y then
				screen_x := a_screen_x
				screen_y := a_screen_y

				from
					hot_zones.start
				until
					hot_zones.after or l_drawed
				loop
					l_drawed := hot_zones.item.update_for_feedback (a_screen_x, a_screen_y, is_dockable)
					hot_zones.forth
					debug ("docking")
						print ("%N SD_DOCKER_MEDIATOR on_pointer_motion")
					end
				end
				debug ("docking")
					print ("%N SD_DOCKER_MEDIATOR on_pointer_motion step 2")
				end
				if is_dockable then
					on_pointer_motion_for_indicator (a_screen_x, a_screen_y)
					if not internal_shared.show_all_feedback_indicator then
						on_pointer_motion_for_clear_indicator (a_screen_x, a_screen_y)
					end
				end
			end
		end

feature -- Query

	screen_x, screen_y: INTEGER
			-- Current pointer position.

	is_tracing: BOOLEAN
			-- Whether is is_tracing pointer events.

	is_dockable: BOOLEAN
			-- If current dragging widget dockable?

	cancel_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Handle user canel dragging event.

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

feature {SD_HOT_ZONE} -- Hot zone infos.

	drag_window_width: INTEGER is
			-- Width of dragged window.
		local
			l_widget: EV_WIDGET
		do
			l_widget ?= caller
			check caller_is_widget: l_widget /= Void end
			Result := l_widget.width
		end

	drag_window_height: INTEGER is
			-- Height of dragged window.
		local
			l_widget: EV_WIDGET
		do
			l_widget ?= caller
			check caller_is_widget: l_widget /= Void end
			Result := l_widget.height
		end

	offset_x: INTEGER
			-- Offset x of `caller' when user start dragging.

	offset_y: INTEGER
			-- Offset y of `caller' when user start dragging.

feature {NONE} -- Implementation functions

	clear_up is
			-- Clear up all resources.
		local
			l_env: EV_ENVIRONMENT
		do
			is_tracing := False
			clear_all_indicator
			internal_shared.feedback.clear

			ev_application.key_press_actions.prune_all (internal_key_press_function)
			ev_application.key_release_actions.prune_all (internal_key_release_function)

			setter.after_disable_capture

			create l_env
			l_env.application.focus_out_actions.start
			l_env.application.focus_out_actions.prune (focus_out_agent)
		end

	on_key_press (a_widget: EV_WIDGET; a_key: EV_KEY) is
			-- Handle user press key to canel event or not allow to dock.
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_escape then
				cancel_tracing_pointer
			when {EV_KEY_CONSTANTS}.key_ctrl then
				is_dockable := False
				clear_all_indicator
				on_pointer_motion (screen_x, screen_y)
				-- FIXIT: Vision2 bugs here
				-- key press actions only called for one time.
				debug ("docking")
					print ("%N on key press")
				end
			else

			end
		end

	on_key_release (a_widget: EV_WIDGET; a_key: EV_KEY) is
			-- Handle user release key to allow dock.
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_ctrl then
				is_dockable := True
				build_all_indicator
				on_pointer_motion (screen_x, screen_y)
			else

			end
		end
		
	on_focus_out (a_widget: EV_WIDGET) is
			-- Handle focus out actions.
		do
			cancel_tracing_pointer
		end

	clear_all_indicator is
			-- Clear all indicators.
		do
			from
				hot_zones.start
			until
				hot_zones.after
			loop
				hot_zones.item.clear_indicator
				hot_zones.forth
			end
		end

	build_all_indicator is
			-- Build all indicators.
		do
			from
				hot_zones.start
			until
				hot_zones.after
			loop
				hot_zones.item.build_indicator
				hot_zones.forth
			end
		end

	generate_hot_zones is
			-- Generate all hot zones which allow user to dock.
		local
			l_zone_list: ARRAYED_LIST [SD_ZONE]
		do
			l_zone_list := docking_manager.zones.zones

			create hot_zones
			generate_hot_zones_imp (l_zone_list)

				hot_zones.extend (internal_shared.hot_zone_factory.hot_zone_main (caller, docking_manager))
				debug ("docking")
					io.put_string ("%N SD_DOCKER_MEDIATOR hot zone main added.")
				end
		ensure
			hot_zones_created: hot_zones /= Void
		end

	generate_hot_zones_imp (a_list: ARRAYED_LIST [SD_ZONE]) is
			-- Filte zone in same SD_MULTI_DOCK_AREA.
		require
			a_list_not_void: a_list /= Void
		local
			l_floating_zone: SD_FLOATING_ZONE
			l_zones_filted: like a_list
		do
			l_zones_filted := a_list.twin
			l_floating_zone ?= caller
			if l_floating_zone /= Void then
				from
					a_list.start
				until
					a_list.after
				loop
					if l_floating_zone.inner_container.has_zone (a_list.item) then
						l_zones_filted.start
						l_zones_filted.prune (a_list.item)
					end
					a_list.forth
				end
			end

			generate_hot_zone_in_area (l_zones_filted)
		end

	generate_hot_zone_in_area (a_list: ARRAYED_LIST [SD_ZONE]) is
			-- Generate all hot zones for a SD_MULIT_DOCK_AREA.
		require
			a_list_not_void: a_list /= Void
		local
			l_zone: SD_ZONE
			l_hot_zone_source: SD_DOCKER_SOURCE
			l_mutli_zone: SD_TAB_ZONE
		do
			from
				a_list.start
			until
				a_list.after
			loop
				l_zone := a_list.item
				l_hot_zone_source ?= l_zone
				-- Ingore the classes we don't care.
				if l_hot_zone_source /= Void and l_zone.is_displayed then
					l_mutli_zone ?= l_zone
					if l_mutli_zone /= Void and then not l_mutli_zone.is_drag_title_bar then
						add_hot_zone_on_type (l_zone, l_hot_zone_source)
					elseif l_zone /= caller then
						add_hot_zone_on_type (l_zone, l_hot_zone_source)
					end
				end
				a_list.forth
			end
		end

	add_hot_zone_on_type (a_zone: SD_ZONE; a_source: SD_DOCKER_SOURCE) is
			-- Add a_zone's hot zone base on zone type.
		require
			a_zone_not_void: a_zone /= Void
			a_source_not_void: a_source /= Void
		local
			l_floating_zone: SD_FLOATING_ZONE
		do
			l_floating_zone ?= a_zone
			if l_floating_zone = Void then
				if a_zone.type = caller.type then
					a_source.add_hot_zones (Current, hot_zones)
				end
			end
		end

	on_pointer_motion_for_indicator (a_screen_x, a_screen_y: INTEGER) is
			-- Handle pointer motion event for draw docking indicator.
		local
			l_drawed: BOOLEAN
		do
			from
				hot_zones.start
			until
				hot_zones.after or l_drawed
			loop
				l_drawed := hot_zones.item.update_for_indicator (a_screen_x, a_screen_y)
				hot_zones.forth
			end

			if not hot_zones.after then
				l_drawed := hot_zones.last.update_for_indicator (a_screen_x, a_screen_y)
			end
		end

	on_pointer_motion_for_clear_indicator (a_screen_x, a_screen_y: INTEGER) is
			-- Handle pointer motion for clear docking indicator.
		do
			from
				hot_zones.start
			until
				hot_zones.after
			loop
				hot_zones.item.update_for_indicator_clear (a_screen_x, a_screen_y)
				hot_zones.forth
			end
		end

feature {NONE} -- Implementation attributes

	setter: SD_SYSTEM_SETTER is
			--
		once
			create {SD_SYSTEM_SETTER_IMP} Result
		end

	hot_zones: ACTIVE_LIST [SD_HOT_ZONE]
			-- Hot zones.

	internal_shared: SD_SHARED
			-- All singletons.

	last_hot_zone: SD_HOT_ZONE
			-- When moving cursor, last SD_HOT_ZONE where pointer in.

	internal_key_press_function: PROCEDURE [ANY, TUPLE [EV_WIDGET, EV_KEY]]
			-- Golbal key press action.

	internal_key_release_function: PROCEDURE [ANY, TUPLE [EV_WIDGET, EV_KEY]]
			-- Golbal key release action.

	focus_out_agent: PROCEDURE [SD_DOCKER_MEDIATOR, TUPLE [EV_WIDGET]]
			-- Focus out agent.

invariant

	internal_shared_not_void: internal_shared /= Void
	hot_zones_not_void: hot_zones /= Void
	cancel_actions_not_void: cancel_actions /= Void

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
