indexing

	description:	
		"Command to freeze the Eiffel code.";
	date: "$Date$";
	revision: "$Revision$"

class FREEZE_PROJECT 

inherit
 
	UPDATE_PROJECT
		rename
			choose_template as execute_warner_help,
			warner_ok as update_project_warner_ok
		redefine
			launch_c_compilation, 
			confirm_and_compile,
			name, menu_name, accelerator,
			perform_compilation,
			execute_warner_help
		end;
	UPDATE_PROJECT
		rename
			choose_template as execute_warner_help,
			warner_ok as freeze_now
		redefine
			launch_c_compilation,
			confirm_and_compile,
			name, menu_name, accelerator,
			perform_compilation,
			freeze_now, execute_warner_help
		select
			freeze_now
		end;
 
creation

	make

feature -- Callbacks

	execute_warner_help is
			-- Process the callback of the help button.
		do
			if warner_was_popped_up then
				warner_was_popped_up := False;
				start_c_compilation := False;
				freeze_now (last_warner)
			else
				load_default_ace
			end
		end;

	freeze_now (argument: ANY) is
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
				(argument = tool) or else
				(argument = Current) or else
				(argument /= Void and then 
				argument = last_confirmer and not end_run_confirmed) 
			then
				warner_was_popped_up := True;		
				warner (popup_parent).custom_call (Current, 
					Warning_messages.w_Freeze_warning,
					Interface_names.b_Freeze_now,
					Interface_names.b_Freeze_now_but_no_c, 
					Interface_names.b_Cancel);
			elseif (argument /= Void and then argument = last_warner) then
					freeze_now (argument)
			elseif 
				argument /= Void and 
				argument = last_confirmer and end_run_confirmed 
			then
				compile (argument)
			end;
		end;

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
			Error_window.display
	
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
			Eiffel_project.freeze
		end;

feature {NONE} -- Attributes

	warner_was_popped_up: BOOLEAN;
			-- Was the warner popped up?

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Freeze
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Freeze
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Freeze
		end;

end -- FREEZE_PROJECT
