-- Command to finalize the Eiffel

class FINALIZE_PROJECT 

inherit

	UPDATE_PROJECT
		redefine
			c_code_directory, launch_c_compilation,
			finalization_actions, confirm_and_compile,
			command_name, symbol
		end
 
creation

	make
 
feature {NONE}

	c_code_directory: STRING is
		do
			Result := Final_generation_path
		end;

	assert_confirmed: BOOLEAN;

	confirm_and_compile (argument: ANY) is
		do
			if argument = text_window then
				assert_confirmed := False;
				warner.set_window (text_window);
				warner.custom_call (Current,
					"Finalizing implies some C compilation%N%
					%and linking. Do you want to do it now?",
					"Finalize now", Void, "Cancel");
			elseif 
				(argument = warner) or else
				(argument = Current) or else
				(argument = Void)
			then
				if not assert_confirmed then
					assert_confirmed := True;
					warner.set_window (text_window);
					warner.custom_call (Current,
						"By default assertions enabled in the Ace%N%
						%file are kept in final mode.%N%
						%A final executable with assertion checking%N%
						%enabled is not optimal in speed and size.%N",
						"Keep assertions", "Discard assertions", "Cancel"); 
				else
					compile (argument);
				end;
			end;
		end;

	finalization_actions (argument: ANY) is
		do
			-- If the argument is `warner' the user 
			-- pressed on "Keep assertions"
			System.finalized_generation (argument = warner);
		end;

	launch_c_compilation (argument: ANY) is
		do
			error_window.put_string
				("Launching C compilation in background...%N");
			if not System.freezing_occurred then
				link_driver
			end;
			finish_freezing;
			if System.poofter_finalization then
				error_window.put_string 
					("Warning: the finalized system might not be optimal%N%
					%%Tin size and speed. In order to produce an optimal%N%
					%%Texecutable, finalize from a new project and do%N%
					%%Tnot use precompilation.%N%N");
			end;
			if (argument = warner) and then Lace.has_assertions then
				error_window.put_string 
					("Warning: the finalized system incorporates assertions.%N%
						%%TIt might therefore not be optimal in size and speed%N%N");
			end;
			error_window.put_string ("System recompiled%N");
		end;

feature 

	symbol: PIXMAP is 
		once 
			Result := bm_Finalize
		end;
 

feature {NONE}

	command_name: STRING is do Result := l_Finalize end;

end

