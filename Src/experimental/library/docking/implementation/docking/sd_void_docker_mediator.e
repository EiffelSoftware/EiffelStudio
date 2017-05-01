note
	description: "When Docking Manager is locked, use this one instead of SD_DOCKER_MANAGER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_VOID_DOCKER_MEDIATOR

inherit
	SD_DOCKER_MEDIATOR
		redefine
			make,
			start_tracing_pointer,
			cancel_tracing_pointer,
			end_tracing_pointer,
			on_pointer_motion,
			clear_up
		end

create
	make

feature {NONE} -- Initlization

	make (a_caller: like caller; a_docking_manager: SD_DOCKING_MANAGER)
			-- <Precursor>
		do
			caller := a_caller
			docking_manager := a_docking_manager
			create cancel_actions
			create internal_shared
			create hot_zones
		end

feature -- Hanlde pointer events

	start_tracing_pointer (a_offset_x, a_offset_y: INTEGER_32)
			-- <Precursor>
		local
			l_env: EV_ENVIRONMENT
			l_agent: like focus_out_agent
		do
			is_tracing := True
			offset_x := a_offset_x
			offset_y := a_offset_y

			l_agent := agent on_focus_out
			focus_out_agent := l_agent
			create l_env
			if attached l_env.application as l_app then
				l_app.focus_out_actions.extend (l_agent)
			else
				check False end --Implied by application is running
			end
		end

	cancel_tracing_pointer
			-- <Precursor>
		do
			is_tracing := False
			clear_up
		end

	end_tracing_pointer (a_screen_x, a_screen_y: INTEGER_32)
			-- <Precursor>
		do
			is_tracing := False
			clear_up
		end

	on_pointer_motion (a_screen_x, a_screen_y: INTEGER_32)
			-- <Precursor>
		local
			l_orignal_multi_dock_area: SD_MULTI_DOCK_AREA
			l_x, l_y: INTEGER
		do
			screen_x := a_screen_x
			screen_y := a_screen_y
			l_x := a_screen_x - offset_x
			l_y := a_screen_y - offset_y
			if attached {SD_FLOATING_ZONE} caller as l_floating_zone then
				l_floating_zone.set_position (l_x, l_y)
			else
				l_orignal_multi_dock_area := docking_manager.query.inner_container (caller)
				if attached {EV_WIDGET} caller as lt_widget then
					if l_orignal_multi_dock_area.has (lt_widget) and attached l_orignal_multi_dock_area.parent_floating_zone as l_zone then
						l_zone.set_position (l_x, l_y)
					end
				else
					check not_possible: False end
				end
			end
		end

feature {NONE} -- Implementation

	clear_up
			-- <Precursor>
		local
			l_env: EV_ENVIRONMENT
		do
			cancel_actions.wipe_out
			create l_env
			if attached l_env.application as l_app and attached focus_out_agent as l_agent then
				l_app.focus_out_actions.start
				l_app.focus_out_actions.prune (l_agent)
			end
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
