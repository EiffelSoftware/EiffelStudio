indexing

	description:	
		"Command to freeze the Eiffel code.";
	date: "$Date$";
	revision: "$Revision$"

class FREEZE_PROJECT 

inherit
 
	UPDATE_PROJECT
		redefine
			launch_c_compilation, 
			confirm_and_compile,
			command_name, symbol,
			compilation_allowed, perform_compilation
		end;
	SHARED_MELT_ONLY
 
creation

	make

feature -- Properties

	symbol: PIXMAP is 
			-- Symbol for the button.
		once 
			Result := bm_Freeze 
		end; 
 
feature {NONE} -- Implementation

	confirm_and_compile (argument: ANY) is
			-- Ask for confirmation, and compile thereafter.
		do
			if 
				(argument = text_window) or (argument = Current) or
				(argument /= Void and then 
				argument = last_confirmer and not end_run_confirmed) 
			then
				warner (text_window).custom_call (Current, w_Freeze_warning,
							"Freeze now", Void, "Cancel");
			elseif (argument /= Void and then argument = last_warner) then
				if Application.is_running then
					end_run_confirmed := true;
					confirmer (text_window).call (Current,
							"Recompiling project will end current run.%N%
							%Start compilation anyway?", "Compile")
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
			-- Launch the C compilation in the background.
		do
			error_window.put_string ("System recompiled%N");
			if start_c_compilation then
				error_window.put_string
					("Launching C compilation in background...%N");
				Eiffel_project.call_finish_freezing (True);
			end
		end;

	perform_compilation (arg: ANY) is
			-- The actual compilation process.
		do
			Eiffel_project.freeze
		end;

feature {NONE} -- Attributes

	compilation_allowed: BOOLEAN is
			-- Is compilation allowed?
		do
			Result := not melt_only
		end

	command_name: STRING is
			-- Name of the command.
		do
			Result := l_Freeze
		end;

end -- FREEZE_PROJECT
