indexing
	description: "Command to clear debugging information."
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_CLEAR_STOP_POINTS_HOLE

inherit

	HOLE_COMMAND
		redefine
			compatible, process_breakable,
			process_feature, process_class
		end
	SHARED_APPLICATION_EXECUTION
	SHARED_EIFFEL_PROJECT
	WARNER_CALLBACKS

creation
	make

feature -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Clear_breakpoints
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Clear_breakpoints
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	symbol: PIXMAP is 
			-- Pixmap for the button.
		do 
			Result := Pixmaps.bm_Clear_breakpoints 
		end

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
		end

feature -- Update

	process_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone
		local
			index: INTEGER
			f: E_FEATURE
			mp: MOUSE_PTR
			disp_bp: DEBUG_STOPIN_HOLE
			body_index: INTEGER
		do
			if Eiffel_project.successful then
				f := bs.routine
				if f.is_debuggable then
					body_index := bs.body_index
					index := bs.index

					create mp.set_watch_cursor
					Application.remove_breakpoint (f, index)
					Window_manager.routine_win_mgr.show_stoppoint (body_index, index)
					Project_tool.show_stoppoint (body_index, index)
					mp.restore

						-- update information window
					create disp_bp.do_nothing
					disp_bp.work (Void)
				end
			else
				warner (Project_tool.popup_parent).gotcha_call (Warning_messages.w_Cannot_debug)
			end
		end

	process_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			f: E_FEATURE
			disp_bp: DEBUG_STOPIN_HOLE
			mp: MOUSE_PTR
		do
			if Eiffel_project.successful then
				f := fs.e_feature
				if f /= Void and then f.is_debuggable and then Application.has_breakpoint_set(f) then
					create mp.set_watch_cursor
					Application.remove_breakpoints_in_feature(f)

						-- update information window
					create disp_bp.do_nothing
					disp_bp.work (Void)	

					Window_manager.routine_win_mgr.resynchronize_debugger (Void)
					Project_tool.resynchronize_debugger
					mp.restore
				end
			end
		end

	process_class (cs: CLASSC_STONE) is
			-- Process class stone.
		local
			disp_bp: DEBUG_STOPIN_HOLE
			mp: MOUSE_PTR
		do
			if Eiffel_project.successful and then cs.e_class /= Void then
				create mp.set_watch_cursor
				Application.remove_breakpoints_in_class(cs.e_class)

					-- update information window
				create disp_bp.do_nothing
				disp_bp.work (Void)	

				Window_manager.routine_win_mgr.resynchronize_debugger (Void)
				Project_tool.resynchronize_debugger
				mp.restore
			end
		end

feature -- Execution

	work (argument: ANY) is
			-- Continue execution.
		local
			disp_bp: DEBUG_STOPIN_HOLE
		do
			if Application.has_breakpoints then
				if argument = clear_it_action then
					Application.clear_debugging_information
					create disp_bp.do_nothing
					disp_bp.work (Void)
					Window_manager.routine_win_mgr.resynchronize_debugger (Void)
					Project_tool.resynchronize_debugger
				else
					warner (popup_parent).custom_call (Current, Warning_messages.w_Clear_breakpoints, Interface_names.b_Ok, Void, Interface_names.b_Cancel)
				end
			end
		end

	execute_warner_ok (arg: ANY) is
			-- Executed when ok is pressed (clear the
			-- debugging information).
		do
			work (clear_it_action)
		end

	execute_warner_help is
		do
		end

end -- class DEBUG_CLEAR_STOP_POINTS_HOLE
