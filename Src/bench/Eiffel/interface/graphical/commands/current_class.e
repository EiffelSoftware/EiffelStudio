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
		do
			if Run_info.is_running and Run_info.is_stopped then
				text_window.receive (Run_info.class_type.associated_class.stone)
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
