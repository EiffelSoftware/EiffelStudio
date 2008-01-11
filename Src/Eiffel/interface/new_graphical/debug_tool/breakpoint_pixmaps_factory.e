indexing
	description: "Pixmaps factory for breakpoints status ..."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BREAKPOINT_PIXMAPS_FACTORY

feature

	pixmap_for_routine_index (a_dm: DEBUGGER_MANAGER; a_routine: E_FEATURE; a_index: INTEGER; in_execution: BOOLEAN): EV_PIXMAP is
			-- Graphical representation of the breakable mark.
			-- 10 different representations whether the breakpoint
			-- is enabled, disabled or not set , whether it has a condition or not,
			-- and whether the application is stopped at this point or not,
			-- and whether we want to be `in_execution' context or not.
		local
			pixmaps: ARRAY [EV_PIXMAP]
			status: APPLICATION_STATUS
			bp: BREAKPOINT
			bm: BREAKPOINTS_MANAGER
			s: INTEGER  -- bp status
			i: INTEGER 	-- index in the pixmap array.
						--  1 = not stopped version
						--  2 = stopped version.
		do
			if in_execution and then a_dm.safe_application_is_stopped then
				status := a_dm.application_status
				if status.is_top (a_routine.body_index, a_index) then
					i := 2
				elseif status.is_at (a_routine.body_index, a_index) then
					i := 3
				else
					i := 1
				end
			else
				i := 1
			end

			bm := a_dm.breakpoints_manager
			s := bm.user_breakpoint_status (a_routine, a_index)
			if s = {BREAKPOINTS_MANAGER}.breakpoint_not_set then
				pixmaps := icon_group_bp_slot
			else
				bp := bm.user_breakpoint (a_routine, a_index)
				check bp_not_void: bp /= Void end
				inspect s
				when {BREAKPOINTS_MANAGER}.breakpoint_set then
					if bp.has_condition then
						pixmaps := icon_group_bp_enabled_condition
					else
						pixmaps := icon_group_bp_enabled
					end
				when {BREAKPOINTS_MANAGER}.breakpoint_disabled then
					if bp.has_condition then
						pixmaps := icon_group_bp_disabled_condition
					else
						pixmaps := icon_group_bp_disabled
					end
				else
					pixmaps := icon_group_bp_slot
				end
			end
			Result := pixmaps[i]
		end

feature {NONE} -- Pixmap resources

	Shared_pixmaps: EB_SHARED_PIXMAPS is
		once
			create Result
		end

	frozen icons: ES_PIXMAPS_12X12 is
			-- Breakpoint icon resources
		once
			Result := shared_pixmaps.small_pixmaps
		ensure
			result_not_void: Result /= Void
		end

	icon_group_bp_slot: ARRAY [EV_PIXMAP] is
			-- Regular (no modifiers) breakpoint icon group.
		once
			Result := <<icons.bp_slot_icon, icons.bp_slot_other_frame_icon, icons.bp_slot_current_line_icon>>
		ensure
			result_not_void: Result /= Void
		end

	icon_group_bp_enabled: ARRAY [EV_PIXMAP] is
			-- Enabled breakpoint icon group.
		once
			Result := <<icons.bp_enabled_icon, icons.bp_enabled_other_frame_icon, icons.bp_enabled_current_line_icon>>
		ensure
			result_not_void: Result /= Void
		end

	icon_group_bp_disabled: ARRAY [EV_PIXMAP] is
			-- Disabled breakpoint icon group.
		once
			Result := <<icons.bp_disabled_icon, icons.bp_disabled_other_frame_icon, icons.bp_disabled_current_line_icon>>
		ensure
			result_not_void: Result /= Void
		end

	icon_group_bp_enabled_condition: ARRAY [EV_PIXMAP] is
			-- Conditional, enabled breakpoint icon group.
		once
			Result := <<icons.bp_enabled_conditional_icon, icons.bp_enabled_other_frame_icon, icons.bp_enabled_current_line_icon>>
		ensure
			result_not_void: Result /= Void
		end

	icon_group_bp_disabled_condition: ARRAY [EV_PIXMAP] is
			-- Conditional, disabled breakpoint icon group.
		once
			Result := <<icons.bp_disabled_conditional_icon, icons.bp_disabled_other_frame_icon, icons.bp_disabled_current_line_icon>>
		ensure
			result_not_void: Result /= Void
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
