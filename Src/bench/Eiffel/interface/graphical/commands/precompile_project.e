indexing

	description:	
		"Command to precompile the Eiffel code.";
	date: "$Date$";
	revision: "$Revision$"

class PRECOMPILE_PROJECT 

inherit
 
	UPDATE_PROJECT
		rename
			warner_ok as update_project_warner_ok
		redefine
			launch_c_compilation, 
			confirm_and_compile,
			name, menu_name, accelerator,
			compilation_allowed, perform_compilation
		end;
	UPDATE_PROJECT
		rename
			warner_ok as precompile_now
		redefine
			launch_c_compilation,
			confirm_and_compile,
			name, menu_name, accelerator,
			compilation_allowed, perform_compilation,
			precompile_now
		select
			precompile_now
		end;
	SHARED_MELT_ONLY
 
creation

	make

feature -- Callbacks

	precompile_now (argument: ANY) is
		do
			if Eiffel_ace.file_name = Void then
				update_project_warner_ok (argument)
			elseif Application.is_running then
				end_run_confirmed := true;
				confirmer (popup_parent).call (Current,
						"Recompiling project will end current run.%N%
						%Start compilation anyway?", "Compile")
			else
				compile (argument)
			end
		end;

feature {NONE} -- Implementation

	confirm_and_compile (argument: ANY) is
			-- Ask for confirmation, and compile thereafter.
		do
			if 
				(argument = tool) or (argument = Current) or
				(argument /= Void and then 
				argument = last_confirmer and not end_run_confirmed) 
			then
				warner (popup_parent).custom_call (Current, Warning_messages.w_Precompile_warning,
							Interface_names.b_Precompile_now, Void, Interface_names.b_Cancel);
			elseif (argument /= Void and then argument = last_warner) then
					precompile_now (argument)
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
			process_end_compilation;
			if start_c_compilation then
				error_window.put_string ("Launching C compilation in background...");
				error_window.new_line;
				Eiffel_project.call_finish_freezing (True);
			end
		end;

	perform_compilation (arg: ANY) is
			-- The actual compilation process.
		do
			Eiffel_project.precompile (False)
		end;

feature {NONE} -- Attributes

	compilation_allowed: BOOLEAN is
			-- Is compilation allowed?
		do
			Result := not melt_only
		end

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Precompile
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Precompile
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Precompile
		end;

end -- PRECOMPILE_PROJECT
