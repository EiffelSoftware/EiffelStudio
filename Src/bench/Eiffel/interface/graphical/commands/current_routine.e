-- Retarget the feature tool with the routine the execution is stopped in.

class CURRENT_ROUTINE

inherit

	ICONED_COMMAND
		redefine
			text_window
		end;
	SHARED_DEBUG

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: ROUTINE_TEXT) is
		do 
			init (c, a_text_window)
		end;

feature {NONE}

	work (argument: ANY) is
			-- Retarget the feature tool with the current routine if any.
		local
			e_class: E_CLASS
		do
			if not Run_info.is_running then
				warner (text_window).gotcha_call (w_System_not_running)
			elseif not Run_info.is_stopped then
				warner (text_window).gotcha_call (w_System_not_stopped)
			elseif Run_info.e_feature = Void or Run_info.class_type = Void then
					-- Should never happen.
				warner (text_window).gotcha_call (w_Unknown_feature)
			else
				e_class := Run_info.class_type.associated_eclass;
				text_window.receive (Run_info.e_feature.stone (e_class));
				if text_window.in_debug_format then
					text_window.highlight_breakable (Run_info.break_index)
				end
			end
		end;

feature

	text_window: ROUTINE_TEXT;

	symbol: PIXMAP is
		once
			Result := bm_Current
		end;

	command_name: STRING is
		do
			Result := l_Current
		end;

end -- class CURRENT_ROUTINE
