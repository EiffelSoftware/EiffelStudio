indexing
	description: "Command to precompile the Eiffel code."
	date: "$Date$"
	revision: "$Revision$"

class PRECOMPILE_PROJECT 

inherit
	UPDATE_PROJECT
		rename
			choose_template as execute_warner_help,
			warner_ok as update_project_warner_ok
		redefine
			launch_c_compilation, 
			confirm_and_compile,
			execute_warner_help,
			name, menu_name, accelerator,
			perform_compilation, is_precompiling
		end

	UPDATE_PROJECT
		rename
			choose_template as execute_warner_help,
			warner_ok as precompile_now
		redefine
			launch_c_compilation,
			confirm_and_compile,
			name, menu_name, accelerator,
			perform_compilation,
			execute_warner_help,
			precompile_now, is_precompiling
		select
			precompile_now
		end
 
creation

	make

feature -- Callbacks

	precompile_now (argument: ANY) is
		do
			if Eiffel_ace.file_name = Void then
				update_project_warner_ok (argument)
			else
				compile (argument)
			end
		end

	execute_warner_help is
			-- Process the call back of the help button,
			-- which is in fact the (no C comp) button
		do
			if Eiffel_ace.file_name = Void then
					-- We choose "Build".
				{UPDATE_PROJECT} Precursor
			else
				start_c_compilation := False
				compile (last_warner)
			end
		end

feature {NONE} -- Implementation

	confirm_and_compile (argument: ANY) is
			-- Ask for confirmation, and compile thereafter.
		do
			if 
				(argument = tool) or (argument = Current) or
				(argument /= Void and then 
				argument = last_confirmer and not end_run_confirmed) 
			then
				warner (popup_parent).custom_call
							(Current, Warning_messages.w_Precompile_warning,
							Interface_names.b_Precompile_now,
							Interface_names.b_Precompile_now_but_no_C,
							Interface_names.b_Cancel)
			elseif (argument /= Void and then argument = last_warner) then
					precompile_now (argument)
			elseif 
				argument /= Void and 
				argument = last_confirmer and end_run_confirmed 
			then
				compile (argument)
			end
		end

	launch_c_compilation (argument: ANY) is
			-- Launch the C compilation in the background.
		local
			window: GRAPHICAL_TEXT_WINDOW
		do
			window ?= Error_window
			if window /= Void then
				window.set_changed (True)
			end

			Error_window.put_string ("System recompiled")
	
			if start_c_compilation then
				error_window.put_string ("%NLaunching C compilation in background...%N")
				Eiffel_project.call_finish_freezing (True)
			end
		
			if window /= Void then
				window.set_changed (False)
			end
		end

	perform_compilation (arg: ANY) is
			-- The actual compilation process.
		do
			license_display
			Eiffel_project.precompile (False)
		end

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		once
			Result := Interface_names.f_Precompile
		end

	menu_name: STRING is
			-- Name used in menu entry
		once
			Result := Interface_names.m_Precompile
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		once
			Result := Interface_names.a_Precompile
		end

	is_precompiling: BOOLEAN is True
			-- We are doing a precompilation here.

end -- PRECOMPILE_PROJECT
