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
			e_class: E_CLASS
		do
			if not Run_info.is_running then
				warner (text_window).gotcha_call (w_System_not_running)
			elseif not Run_info.is_stopped then
				warner (text_window).gotcha_call (w_System_not_stopped)
			elseif Run_info.e_feature = Void or Run_info.class_type = Void then
					-- Should never happen.
				warner (text_window).gotcha_call (w_Unknown_class)
			else
					-- Show the current routine in that class.
				e_class := Run_info.class_type.associated_eclass;
				text_window.receive (Run_info.e_feature.stone (e_class))
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
