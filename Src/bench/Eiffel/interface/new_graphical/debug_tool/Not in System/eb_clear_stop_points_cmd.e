indexing
	description	: "Command to clear debugging information."
	date		: "$Date$"
	revision	: "$Revision$"

class EB_CLEAR_STOP_POINTS_CMD

inherit
	EB_TEXT_TOOL_CMD
		redefine
			tool
		end

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	EB_SHARED_INTERFACE_TOOLS

	NEW_EB_CONSTANTS

creation
	make

feature -- Properties

	tool: EB_DEVELOPMENT_WINDOW

feature -- Update

	drop_breakable (bs: BREAKABLE_STONE) is
			-- Process breakable stone
		local
			index: INTEGER
			f: E_FEATURE
			disp_bp: EB_OUTPUT_MANAGER
			body_index: INTEGER
			wd: EV_WARNING_DIALOG
		do
			if Eiffel_project.successful then
				f := bs.routine
				if f.is_debuggable then
					body_index := bs.body_index
					index := bs.index

					Application.remove_breakpoint (f, index)

						-- update information window
					create disp_bp
					disp_bp.display_stop_points
				end
			else
				create wd.make_with_text (Warning_messages.w_Cannot_debug)
				wd.show_modal
			end
		end

	drop_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		local
			f: E_FEATURE
			disp_bp: EB_DEBUG_STOPIN_HOLE_CMD
		do
			if Eiffel_project.successful then
				f := fs.e_feature
				if f /= Void and then f.is_debuggable and then Application.has_breakpoint_set (f) then
					Application.remove_breakpoints_in_feature (f)

						-- update information window
					create disp_bp
					disp_bp.display_stop_points	
					tool_supervisor.feature_tool_mgr.resynchronize_debugger (Void)
					tool.resynchronize_debugger
				end
			end
		end

	drop_class (cs: CLASSC_STONE) is
			-- Process class stone.
		local
			disp_bp: EB_DEBUG_STOPIN_HOLE_CMD
		do
			if Eiffel_project.successful and then cs.e_class /= Void then
				Application.remove_breakpoints_in_class (cs.e_class)
				create disp_bp
				disp_bp.display_stop_points	
				tool_supervisor.feature_tool_mgr.resynchronize_debugger (Void)
				tool.resynchronize_debugger
			end
		end

feature -- Execution

	erase_stop_points (confirmation_not_needed: BOOLEAN) is
			-- Continue execution.
		local
			disp_bp: EB_DEBUG_STOPIN_HOLE_CMD
			qd: EV_CONFIRMATION_DIALOG
		do
			if Application.has_breakpoints then
				if confirmation_not_needed then
					Application.clear_debugging_information
					create disp_bp
					disp_bp.display_stop_points
					tool_supervisor.feature_tool_mgr.resynchronize_debugger (Void)
					tool.resynchronize_debugger
				else
					create qd.make_with_text_and_actions (Warning_messages.w_Clear_breakpoints,
						<<~erase_stop_points (True), Void>>)
					qd.show_modal
				end
			end
		end

end -- class EB_CLEAR_STOP_POINTS_CMD
