indexing
	description	: "Command to add a breakpoint"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_STOPPOINTS_STATUS_COMMAND

inherit
	EB_COMMAND

	NEW_EB_CONSTANTS

	SHARED_APPLICATION_EXECUTION

	EB_SHARED_INTERFACE_TOOLS

 
feature -- Access
 
	enable_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	disable_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

--	name: STRING is
--			-- Name of editor operations
--		do
--			inspect
--				status_type
--			when disabled_type then
--				Result := Interface_names.f_Disable_stop_points
--			when enabled_type then
--				Result := Interface_names.f_Enable_stop_points
--			end
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			inspect
--				status_type
--			when disabled_type then
--				Result := Interface_names.m_Disable_stop_points
--			when enabled_type then
--				Result := Interface_names.m_Enable_stop_points
--			end
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

feature -- Execution

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Perform edit operations.
		local
			d_bp: EB_DEBUG_STOPIN_HOLE_CMD
			list: LINKED_LIST [E_FEATURE]
		do
			if argument = disable_it then
				list := Application.debugged_routines
			else
				list := Application.removed_routines
			end
			list.start
			list := list.duplicate (list.count)
			from
				list.start
			until
				list.after
			loop
				Application.switch_feature (list.item)
				tool_supervisor.feature_tool_mgr.resynchronize_debugger 
						(list.item)
				list.forth
			end
			create d_bp
			d_bp.execute (Void, Void)
		end

feature {NONE} -- Implementation

	update_debuggable_for (f: E_FEATURE) is
			-- Update the debuggable information for feature `f'.
			-- If `f' is already debuggable then switch it to another
			-- category. Otherwize, set the first breakpoint.
		require
			f_is_valid: f /= Void
			is_debuggable: f.is_debuggable
		do
			if Application.has_feature (f) then
				Application.switch_feature (f)
				tool_supervisor.feature_tool_mgr.resynchronize_debugger (f)
			else
				Application.add_feature (f)
				Application.switch_breakpoint (f, 1)
				tool_supervisor.feature_tool_mgr.show_stoppoint (f, 1)
				debug_tool.show_stoppoint (f, 1)
			end
		end

end -- class EB_STOPPOINTS_STATUS_CMD
