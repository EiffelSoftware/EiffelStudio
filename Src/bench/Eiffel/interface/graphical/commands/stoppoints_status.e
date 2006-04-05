indexing

	description: 
		"Command to enable/disable all stoppoints"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class STOPPOINTS_STATUS

inherit

	ISE_COMMAND;
	EB_CONSTANTS;
	SHARED_APPLICATION_EXECUTION;
	WINDOWS

create
	make_enabled, 
	make_disabled 

feature {NONE} -- Initialization

	make_enabled is
			-- Initialize command to enable all stoppoints.
		do
			status_type := enabled_type
		end;
 
	make_disabled is
			-- Initialize command to disable all stoppoints.
		do
			status_type := disabled_type
		end;
 
feature -- Status report
 
	name: STRING is
			-- Name of editor operations
		do
			inspect
				status_type
			when disabled_type then
				Result := Interface_names.f_Disable_stop_points
			when enabled_type then
				Result := Interface_names.f_Enable_stop_points
			end
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			inspect
				status_type
			when disabled_type then
				Result := Interface_names.m_Disable_stop_points
			when enabled_type then
				Result := Interface_names.m_Enable_stop_points
			end
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature -- Execution

	work (argument: ANY) is
			-- Perform edit operations.
		local
			d_bp: DEBUG_STOPIN_HOLE
			bps: BREAK_LIST
			bp: BREAKPOINT
		do

			-- loop on the breakpoint list and disable/enable every breakpoint
			bps := Application.debug_info.breakpoints
			from
				bps.start
			until
				bps.after
			loop
				bp := bps.item_for_iteration
				
				if not bp.is_not_set then
						-- enable/disable only the breakpoint that are set
					inspect	status_type
					when disabled_type then
						bp.disable
					when enabled_type then
						bp.enable
					end
				end
				
--				Window_manager.routine_win_mgr.resynchronize_debugger(bp.routine)
				Window_manager.routine_win_mgr.resynchronize_debugger(Void)
				Project_tool.resynchronize_debugger
				bps.forth
			end
			
			create d_bp.do_nothing
			d_bp.work (Void)
		end

feature {NONE} -- Implementation
 
	status_type: INTEGER;
			-- Status type
 
	disabled_type, enabled_type: INTEGER is unique;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class STOPPOINTS_STATUS
