
-- Command to freeze the Eiffel

class FREEZE_PROJECT 

inherit
 
	UPDATE_PROJECT
		rename
			freezing_actions as freeze_system
		undefine
			freeze_system
		redefine
			launch_c_compilation, freeze_system,
			confirm_and_compile,
			command_name, symbol,
			compilation_allowed
		end
	C_COMPILE_ACTIONS
 
creation

	make
 
feature {NONE}

	confirm_and_compile (argument: ANY) is
		do
			if 
				(argument = text_window) or (argument = Current) or
				(argument /= Void and then 
				argument = last_confirmer and not end_run_confirmed) 
			then
				warner (text_window).custom_call (Current, w_Freeze_warning,
							"Freeze now", Void, "Cancel");
			elseif (argument /= Void and then argument = last_warner) then
				if Run_info.is_running then
					confirmer (text_window).call (Current,
							"Recompiling project will end current run.%N%
							%Start compilation anyway?", "Compile");
					end_run_confirmed := true
				else
					compile (argument)
				end
			elseif 
				argument /= Void and 
				argument = last_confirmer and end_run_confirmed 
			then
				compile (argument)
			end;
		end;

	launch_c_compilation (argument: ANY) is
		do
			error_window.put_string ("System recompiled%N");
			if start_c_compilation then
				error_window.put_string
					("Launching C compilation in background...%N");
				finish_freezing;
			end
		end;

feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Freeze 
		end; 

feature {NONE}

	compilation_allowed: BOOLEAN is
		do
			Result := not melt_only
		end

	command_name: STRING is do Result := l_Freeze end;

end
