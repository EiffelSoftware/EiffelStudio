-- Retarget the class tool with the class the execution is stopped in.

class CURRENT_CLASS

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
			-- Retarget the class tool with the current class if any.
		local
			class_c: CLASS_C
		do
			if not Run_info.is_running then
				warner.set_window (text_window);
				warner.gotcha_call ("Application is not running")
			elseif not Run_info.is_stopped then
				warner.set_window (text_window);
				warner.gotcha_call ("Application is not stopped")
			elseif Run_info.feature_i = Void or Run_info.class_type = Void then
					-- Should never happen.
				warner.set_window (text_window);
				warner.gotcha_call ("Unknown class")
			else
					-- Show the current routine in that class.
				class_c := Run_info.class_type.associated_class;
				text_window.receive (Run_info.feature_i.stone (class_c))
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

end -- class CURRENT_CLASS
