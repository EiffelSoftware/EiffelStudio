indexing

	description:	
		"Command to clear debugging information.";
	date: "$Date$";
	revision: "$Revision$"

class DEBUG_CLEAR_STOP_POINTS_HOLE

inherit

	HOLE_COMMAND
		redefine
			compatible, process_breakable,
			process_feature, process_class
		end;
	SHARED_APPLICATION_EXECUTION;
	SHARED_EIFFEL_PROJECT;
	WARNER_CALLBACKS

creation
	make

feature -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Clear_breakpoints
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Clear_breakpoints
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Clear_breakpoints
		end;

	symbol: PIXMAP is 
			-- Pixmap for the button.
		do 
			Result := Pixmaps.bm_Clear_breakpoints 
		end;

	clear_it_action: ANY is
			-- Action to signify imediate clearing of breakpoints
		once
			!! Result
		end

	stone_type: INTEGER is
		do
		end

feature -- Access

	compatible (dropped: STONE): BOOLEAN is
			-- Can `Current' accept `dropped' ?
		do
			Result := dropped /= Void and then
					(dropped.stone_type = Breakable_type or else
					dropped.stone_type = Class_type or else
					dropped.stone_type = Routine_type)
		end;

feature -- Update

	process_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone
		do
			tool.process_breakable (bs)
		end;

	process_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			f: E_FEATURE;
			disp_bp: DEBUG_STOPIN_HOLE;
			mp: MOUSE_PTR
		do
			if Eiffel_project.successful then
				f := fs.e_feature;
				if f /= Void and then f.is_debuggable and then Application.has_feature (f) then
					!! mp.set_watch_cursor;
					Application.remove_feature (f);
					!! disp_bp.do_nothing;
					disp_bp.work (Void);	
					mp.restore
				end
			end
		end;

	process_class (cs: CLASSC_STONE) is
			-- Process class stone.
		local
			disp_bp: DEBUG_STOPIN_HOLE;
			mp: MOUSE_PTR
		do
			if Eiffel_project.successful and then cs.e_class /= Void then
				!! mp.set_watch_cursor;
				Application.remove_class (cs.e_class);
				!! disp_bp.do_nothing;
				disp_bp.work (Void);	
				mp.restore
			end
		end

feature -- Execution

	work (argument: ANY) is
			-- Continue execution.
		local
			status: APPLICATION_STATUS;	
			disp_bp: DEBUG_STOPIN_HOLE
		do
			if Application.has_debugging_information then
				if argument = clear_it_action then
					Application.clear_debugging_information;
					!! disp_bp.do_nothing;
					disp_bp.work (Void);	
					Window_manager.routine_win_mgr.resynchronize_debugger (Void)
					Project_tool.resynchronize_debugger
				else
					warner (popup_parent).custom_call (Current,
						Warning_messages.w_Clear_breakpoints, Interface_names.b_Ok, Void, Interface_names.b_Cancel)
				end
			end;
		end;

	execute_warner_ok (arg: ANY) is
			-- Executed when ok is pressed (clear the
			-- debugging information).
		do
			work (clear_it_action)
		end;

	execute_warner_help is
		do
		end;	

end -- class DEBUG_CLEAR_STOP_POINTS_HOLE
