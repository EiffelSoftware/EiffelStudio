
-- Command to freeze the Eiffel

class FREEZE_PROJECT 

inherit
 
	UPDATE_PROJECT
		redefine
			launch_c_compilation, freezing_actions,
			confirm_and_compile,
			command_name, symbol,
			compilation_allowed
		end
 
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

	freezing_actions is
		do
			System.freeze_system;
		end;

	launch_c_compilation (argument: ANY) is
		do
			error_window.put_string ("System recompiled%N");
			error_window.put_string
				("Launching C compilation in background...%N");
			finish_freezing;
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
