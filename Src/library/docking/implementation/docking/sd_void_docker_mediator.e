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
			-- Redefine
		do
			caller := a_caller
			docking_manager := a_docking_manager
			create cancel_actions
		end

feature -- Hanlde pointer events

	start_tracing_pointer (a_offset_x, a_offset_y: INTEGER_32)
			-- Redefine
		local
			l_env: EV_ENVIRONMENT
		do
			is_tracing := True
			offset_x := a_offset_x
			offset_y := a_offset_y

			focus_out_agent := agent on_focus_out
			create l_env
			l_env.application.focus_out_actions.extend (focus_out_agent)
		end

	cancel_tracing_pointer
			-- Redefine
		do
			is_tracing := False
			clear_up
		end

	end_tracing_pointer (a_screen_x, a_screen_y: INTEGER_32)
			-- Redefine
		do
			is_tracing := False
			clear_up
		end

	on_pointer_motion (a_screen_x, a_screen_y: INTEGER_32)
			-- Redefine
		local
			l_floating_zone: SD_FLOATING_ZONE
			l_orignal_multi_dock_area: SD_MULTI_DOCK_AREA
			l_x, l_y: INTEGER
		do
			screen_x := a_screen_x
			screen_y := a_screen_y
			l_floating_zone ?= caller
			l_x := a_screen_x - offset_x
			l_y := a_screen_y - offset_y
			if l_floating_zone /= Void then
				l_floating_zone.set_position (l_x, l_y)
			else
				l_orignal_multi_dock_area := docking_manager.query.inner_container (caller)
				if {lt_widget: EV_WIDGET} caller then
					if l_orignal_multi_dock_area.has (lt_widget) and l_orignal_multi_dock_area.parent_floating_zone /= Void then
						l_orignal_multi_dock_area.parent_floating_zone.set_position (l_x, l_y)
					end
				else
					check not_possible: False end
				end
			end
		end

feature {NONE} -- Implementation

	clear_up
			-- Redefine
		local
			l_env: EV_ENVIRONMENT
		do
			cancel_actions.wipe_out
			create l_env
			l_env.application.focus_out_actions.start
			l_env.application.focus_out_actions.prune (focus_out_agent)
		end

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
