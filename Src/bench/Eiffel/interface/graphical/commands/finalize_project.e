indexing

	description:	
		"Command to finalize the Eiffel code.";
	date: "$Date$";
	revision: "$Revision$"

class FINALIZE_PROJECT 

inherit

	UPDATE_PROJECT
		redefine
			c_code_directory, launch_c_compilation,
			confirm_and_compile, command_name, symbol, 
			compilation_allowed, finalization_error, perform_compilation
		end;
	SHARED_ERROR_HANDLER;
	SHARED_MELT_ONLY
 
creation

	make
 
feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Finalize
		end;

feature {NONE} -- Attributes

	compilation_allowed: BOOLEAN is
			-- Is a compilation allowed?
		do
			Result := not melt_only
		end

	c_code_directory: STRING is
			-- Directory where the C code is stored.
		do
			Result := Final_generation_path
		end;

	assert_confirmed: BOOLEAN;
			-- Did the user confirm the question whether to keep the assertions
			-- or not?

	finalization_error: BOOLEAN;
			-- Has a validity error been detected during the
			-- finalization? This happens with DLE dealing
			-- with statically bound feature calls

	command_name: STRING is
			-- Name of the command.
		do
			Result := l_Finalize
		end;

feature {NONE} -- Implementation

	confirm_and_compile (argument: ANY) is
			-- Ask for confirmation if the assertion are to be kept, and
			-- finalize thereafter.
		do
			if 
				argument = text_window or
				(argument /= Void and 
				argument = last_confirmer and not end_run_confirmed)
			then
				assert_confirmed := False;
				warner (text_window).custom_call (Current, w_Finalize_warning,
					"Finalize now", Void, "Cancel");
			elseif 
				(argument = last_warner) or else
				(argument = Current) or else
				(argument = last_confirmer) or else
				(argument = Void)
			then
				if not assert_confirmed then
					assert_confirmed := True;
					warner (text_window).custom_call (Current, 
						w_Assertion_warning, "Keep assertions", 
						"Discard assertions", "Cancel"); 
				elseif 
					not Application.is_running or else
					(argument /= Void and 
					argument = last_confirmer and end_run_confirmed)
				then
						-- Do not call the once function `System' directly
						-- since it's value may be replaced during the first
						-- compilation (as soon as we figured out whether the
						-- system describes a Dynamic Class Set or not).
					compile (argument);
				else
					end_run_confirmed := true;
					confirmer (text_window).call (Current,
							"Recompiling project will end current run.%N%
							%Start compilation anyway?", "Compile")
				end;
			end;
		end;

	perform_compilation (argument: ANY) is
			-- The real compilation work.
		local
			temp: STRING;
			rescued: BOOLEAN
		do
			if not rescued then
				-- If the argument is `warner' the user 
				-- pressed on "Keep assertions"
				Eiffel_project.finalize (last_warner /= Void and 
									argument = last_warner);
				if Eiffel_project.save_error then
					!! temp.make (0);
					temp.append ("Could not write to ");
					temp.append (Project_file_name);
					temp.append ("%NPlease check permissions and disk space%
						%%NThen press ");
					temp.append (command_name);
					temp.append (" again%N");
					error_window.put_string (temp)
				end;
				finalization_error := false
			else
				rescued := False
			end
		rescue
			rescued := true;
			finalization_error := true;
			retry
		end;

	launch_c_compilation (argument: ANY) is
			-- Launch the C compilation in the background.
		do
			if start_c_compilation then
				error_window.put_string
					("Launching C compilation in background...%N");
				Eiffel_project.call_finish_freezing (False);
			end;
			if not Eiffel_project.is_final_code_optimal then
				error_window.put_string 
					("Warning: the finalized system might not be optimal%N%
					%%Tin size and speed. In order to produce an optimal%N%
					%%Texecutable, finalize from a new project and do%N%
					%%Tnot use precompilation.%N%N");
			end;
			if 
				(last_warner /= Void and argument = last_warner)
				and then Eiffel_project.lace_has_assertions
			then
				error_window.put_string 
					("Warning: the finalized system incorporates assertions.%N%
						%%TIt might therefore not be optimal in size and speed%N%N");
			end;
			error_window.put_string ("System recompiled%N");
		end;
 
end -- class FINALIZE_PROJECT
