indexing

	description:	
		"Retarget the feature tool with the routine the execution is stopped in.";
	date: "$Date$";
	revision: "$Revision$"


class CURRENT_ROUTINE

inherit

	ICONED_COMMAND
		rename
			init_from_tool as make
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
			Result := bm_Current
		end;

	name: STRING is
			-- Name of the command.
		do
			Result := l_Current
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Retarget the feature tool with the current routine if any.
		local
			e_class: E_CLASS;
			status: APPLICATION_STATUS;
			st: FEATURE_STONE;
		do
			status := Application.status;
			if status = Void then
				warner (popup_parent).gotcha_call (w_System_not_running)
			elseif not status.is_stopped then
				warner (popup_parent).gotcha_call (w_System_not_stopped)
			elseif status.e_feature = Void or status.dynamic_class = Void then
					-- Should never happen.
				warner (popup_parent).gotcha_call (w_Unknown_feature)
			else
				e_class := status.origin_class;
				!! st.make (status.e_feature, e_class);
				tool.process_feature (st);
				tool.highlight_breakable (status.break_index)
			end
		end;

end -- class CURRENT_ROUTINE
