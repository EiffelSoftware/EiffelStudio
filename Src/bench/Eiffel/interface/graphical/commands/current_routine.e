indexing

	description:	
		"Retarget the feature tool with the routine the execution is stopped in.";
	date: "$Date$";
	revision: "$Revision$"


class CURRENT_ROUTINE

inherit

	PIXMAP_COMMAND
		rename
			init as make
		redefine
			tool
		end;
	SHARED_APPLICATION_EXECUTION

creation

	make

feature -- Properties

	tool: ROUTINE_W;
			-- Text of the routine.

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := Pixmaps.bm_Current
		end;

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Current
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Current
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Current
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Retarget the feature tool with the current routine if any.
		local
			status: APPLICATION_STATUS;
			st: FEATURE_STONE;
		do
			status := Application.status;
			if status = Void then
				warner (popup_parent).gotcha_call (Warning_messages.w_System_not_running)
			elseif not status.is_stopped then
				warner (popup_parent).gotcha_call (Warning_messages.w_System_not_stopped)
			elseif status.e_feature = Void or status.dynamic_class = Void then
					-- Should never happen.
				warner (popup_parent).gotcha_call (Warning_messages.w_Unknown_feature)
			else
				!! st.make (status.e_feature);
				tool.process_feature (st);
				tool.highlight_breakable (status.break_index)
			end
		end;

end -- class CURRENT_ROUTINE
