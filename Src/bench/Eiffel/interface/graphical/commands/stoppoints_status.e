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
			d_bp: DEBUG_STOPIN_HOLE;
			list: LINKED_LIST [E_FEATURE]
		do
			inspect
				status_type
			when disabled_type then
				list := Application.debugged_routines;
			when enabled_type then
				list := Application.removed_routines;
			end;
			list.start;
			list := list.duplicate (list.count);
			from
				list.start
			until
				list.after
			loop
				Application.switch_feature (list.item);
				Window_manager.routine_win_mgr.resynchronize_debugger 
						(list.item)
				list.forth
			end
			!! d_bp.do_nothing;
			d_bp.work (Void);
		end;

feature {NONE} -- Implementation
 
	status_type: INTEGER;
			-- Status type
 
	disabled_type, enabled_type: INTEGER is unique

	update_debuggable_for (f: E_FEATURE) is
			-- Update the debuggable information for feature `f'.
			-- If `f' is already debuggable then switch it to another
			-- category. Otherwize, set the first breakpoint.
		require
			f_is_valid: f /= Void;
			is_debuggable: f.is_debuggable
		do
			if Application.has_feature (f) then
				Application.switch_feature (f);
				Window_manager.routine_win_mgr.resynchronize_debugger (f)
			else
				Application.add_feature (f);
				Application.switch_breakpoint (f, 1);
				Window_manager.routine_win_mgr.show_stoppoint (f, 1);
				Project_tool.show_stoppoint (f, 1)
			end
		end;
 
end -- class STOPPOINTS_STATUS
