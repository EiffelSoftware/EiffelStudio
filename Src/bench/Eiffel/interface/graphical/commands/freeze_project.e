
-- Command to freeze the Eiffel

class FREEZE_PROJECT 

inherit
 
	UPDATE_PROJECT
		redefine
			launch_c_compilation, freezing_actions,
			confirm_and_compile,
			command_name, symbol
		end
 
creation

	make
 
feature {NONE}

	confirm_and_compile (argument: ANY) is
		do
			if 
				(argument = text_window) or else  
				(argument = Current)
			then
				warner.set_window (text_window);
				warner.custom_call (Current, w_Freeze_warning,
							"Freeze now", Void, "Cancel");
			elseif argument = warner then
				compile (argument);
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

	command_name: STRING is do Result := l_Freeze end;

end
