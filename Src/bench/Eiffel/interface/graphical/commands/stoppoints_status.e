indexing

	description: 
		"Command to enable/disable all stoppoints";
	date: "$Date$";
	revision: "$Revision $"

class STOPPOINTS_STATUS

inherit

	ISE_COMMAND;
	EB_CONSTANTS;
	SHARED_APPLICATION_EXECUTION;
	WINDOWS

creation
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
 
	disabled_type, enabled_type: INTEGER is unique

end -- class STOPPOINTS_STATUS
