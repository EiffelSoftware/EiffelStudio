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
			class_c: CLASS_C
		do
			if not Run_info.is_running then
				warner.set_window (text_window);
				warner.gotcha_call ("System is not running")
			elseif not Run_info.is_stopped then
				warner.set_window (text_window);
				warner.gotcha_call ("System is not stopped")
			elseif Run_info.feature_i = Void or Run_info.class_type = Void then
					-- Should never happen.
				warner.set_window (text_window);
				warner.gotcha_call ("Unknown feature")
			else
				class_c := Run_info.class_type.associated_class;
				text_window.receive (Run_info.feature_i.stone (class_c));
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
