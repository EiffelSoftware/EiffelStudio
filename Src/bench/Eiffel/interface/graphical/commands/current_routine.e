-- Retarget the feature tool with the routine the execution is stopped in.

class CURRENT_ROUTINE

inherit

	ICONED_COMMAND;
	SHARED_DEBUG

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do 
			init (c, a_text_window)
		end;

feature {NONE}

	work (argument: ANY) is
			-- Retarget the feature tool with the current routine if any.
		local
			class_c: CLASS_C
		do
			if Run_info.is_running and Run_info.is_stopped then
				if Run_info.feature_i /= Void then
					class_c := Run_info.class_type.associated_class;
					text_window.receive (Run_info.feature_i.stone (class_c))
				end
			end
		end;

feature

	symbol: PIXMAP is
		once
			Result := bm_Current
		end;

	command_name: STRING is
		do
			Result := l_Current
		end;

end -- class CURRENT_ROUTINE
