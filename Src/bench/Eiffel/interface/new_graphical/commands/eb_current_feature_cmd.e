indexing

	description:	
		"Retarget the feature tool with the routine the execution is stopped in."
	date: "$Date$"
	revision: "$Revision$"


class EB_CURRENT_FEATURE_CMD

inherit

	EB_EDITOR_COMMAND
		redefine
			tool
		end

	SHARED_APPLICATION_EXECUTION

	NEW_EB_CONSTANTS

creation

	make

feature -- Properties

	tool: EB_FEATURE_TOOL
			-- Text of the routine.

--	symbol: PIXMAP is
--			-- Pixmap for the button.
--		once
--			Result := Pixmaps.bm_Current
--		end

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Current
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Current
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := Interface_names.a_Current
--		end

feature {NONE} -- Implementation

	execute is
			-- Retarget the feature tool with the current routine if any.
		local
			status: APPLICATION_STATUS
			st: FEATURE_STONE
			wd: EV_WARNING_DIALOG
		do
			status := Application.status
			if status = Void then
				create wd.make_with_text (Warning_messages.w_System_not_running)
				wd.show_modal
			elseif not status.is_stopped then
				create wd.make_with_text (Warning_messages.w_System_not_stopped)
				wd.show_modal
			elseif status.e_feature = Void or status.dynamic_class = Void then
					-- Should never happen.
				create wd.make_with_text (Warning_messages.w_Unknown_feature)
				wd.show_modal
			else
				create st.make (status.e_feature)
				tool.process_feature (st)
				tool.highlight_breakable (status.break_index)
			end
		end

end -- class EB_CURRENT_FEATURE_CMD
