indexing

	description:	
		"Retarget the feature tool with the routine the execution is stopped in.";
	date: "$Date$";
	revision: "$Revision$"


class CURRENT_ROUTINE

inherit

	ICONED_COMMAND
		redefine
			text_window
		end;
	SHARED_APPLICATION_EXECUTION

creation

	make

feature -- Initialization

	make (a_text_window: ROUTINE_TEXT) is
			-- Initialize the associated window.
		do 
			init (a_text_window)
		end;

feature -- Properties

	text_window: ROUTINE_TEXT;
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
			st: FEATURE_STONE
		do
			status := Application.status;
			if status = Void then
				warner (text_window).gotcha_call (w_System_not_running)
			elseif not status.is_stopped then
				warner (text_window).gotcha_call (w_System_not_stopped)
			elseif status.e_feature = Void or status.dynamic_class = Void then
					-- Should never happen.
				warner (text_window).gotcha_call (w_Unknown_feature)
			else
				e_class := status.origin_class;
				!! st.make (status.e_feature, e_class);
				text_window.tool.process_feature (st);
				if text_window.in_debug_format then
					text_window.highlight_breakable (status.break_index)
				end
			end
		end;

end -- class CURRENT_ROUTINE
