indexing

	description:	
		"Command to clear debugging information."
	date: "$Date$"
	revision: "$Revision$"

class EB_CLEAR_STOP_POINTS_CMD

inherit

--	HOLE_COMMAND
--		redefine
--			compatible, process_breakable,
--			process_feature, process_class
--		end
	EB_EDITOR_COMMAND
		redefine
			tool
		end
	SHARED_APPLICATION_EXECUTION
	SHARED_EIFFEL_PROJECT
	EB_SHARED_INTERFACE_TOOLS
--	WARNER_CALLBACKS
	NEW_EB_CONSTANTS

creation
	make

feature -- Properties

	tool: EB_DEBUG_TOOL

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Clear_breakpoints
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Clear_breakpoints
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

--	symbol: EV_PIXMAP is 
--			-- Pixmap for the button.
--		do 
--			Result := Pixmaps.bm_Clear_breakpoints 
--		end

	clear_it_action: EV_ARGUMENT1 [ANY] is
			-- Action to signify imediate clearing of breakpoints
		once
			create Result.make (Void)
		end

	stone_type: INTEGER is
		do
		end

feature -- Access

--	compatible (dropped: STONE): BOOLEAN is
--			-- Can `Current' accept `dropped' ?
--		do
--			Result := dropped /= Void and then
--					(dropped.stone_type = Breakable_type or else
--					dropped.stone_type = Class_type or else
--					dropped.stone_type = Routine_type)
--		end

feature -- Update

	process_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone
		do
			tool.process_breakable (bs)
		end

	process_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			f: E_FEATURE
			disp_bp: EB_DEBUG_STOPIN_HOLE_CMD
--			mp: MOUSE_PTR
		do
			if Eiffel_project.successful then
				f := fs.e_feature
				if f /= Void and then f.is_debuggable and then Application.has_feature (f) then
--					!! mp.set_watch_cursor
					Application.remove_feature (f)
					create disp_bp
					disp_bp.execute (Void, Void)	
					tool_supervisor.feature_tool_mgr.resynchronize_debugger (Void)
					tool.resynchronize_debugger
--					mp.restore
				end
			end
		end

	process_class (cs: CLASSC_STONE) is
			-- Process class stone.
		local
			disp_bp: EB_DEBUG_STOPIN_HOLE_CMD
--			mp: MOUSE_PTR
		do
			if Eiffel_project.successful and then cs.e_class /= Void then
--				!! mp.set_watch_cursor
				Application.remove_class (cs.e_class)
				create disp_bp
				disp_bp.execute (Void, Void)	
				tool_supervisor.feature_tool_mgr.resynchronize_debugger (Void)
				tool.resynchronize_debugger
--				mp.restore
			end
		end

feature -- Execution

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Continue execution.
		local
			status: APPLICATION_STATUS	
			disp_bp: EB_DEBUG_STOPIN_HOLE_CMD
			qd: EV_QUESTION_DIALOG
		do
			if Application.has_debugging_information then
				if argument = clear_it_action then
					Application.clear_debugging_information
					create disp_bp
					disp_bp.execute (Void, Void)	
					tool_supervisor.feature_tool_mgr.resynchronize_debugger (Void)
					tool.resynchronize_debugger
				else
					create qd.make_default (tool.parent, Interface_names.t_Confirm,
						Warning_messages.w_Clear_breakpoints)
					qd.add_yes_command (Current, clear_it_action)
				end
			end
		end

	execute_warner_ok (arg: ANY) is
			-- Executed when ok is pressed (clear the
			-- debugging information).
		do
--			work (clear_it_action)
		end

	execute_warner_help is
		do
		end	

end -- class EB_CLEAR_STOP_POINTS_CMD
