indexing
	description: "Command to finalize the Eiffel code."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FINALIZE_PROJECT_CMD

inherit
	EB_MELT_PROJECT_CMD
		redefine
			c_code_directory, launch_c_compilation,
			confirm_and_compile,
--			name, menu_name, accelerator,
			finalization_error, perform_compilation,
			license_frequency
		end
	SHARED_ERROR_HANDLER
 
creation

	make

feature -- Callbacks

	ask_for_assertions (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Question the user wether he wants to keep assertions or not.
			-- If the question is answered with discard, it will come to here aswell.
		local
			wd: EV_WARNING_DIALOG
			cmd: EV_ROUTINE_COMMAND
		do
			if arg = discard_assertions then
				assertions_included := False
			elseif arg = keep_assertions then
				assertions_included := True
			end
			if 
				(arg = Void)
			then
				create wd.make_with_text (tool.parent, Interface_names.t_Warning,
					Warning_messages.w_Assertion_warning)
				wd.show_yes_no_cancel_buttons
				create cmd.make (~ask_for_assertions)
				wd.add_yes_command (cmd, keep_assertions)
				wd.add_no_command (cmd, discard_assertions)
				wd.show
--			elseif not assert_confirmed then
--				warner (popup_parent).custom_call (Current, 
--					Warning_messages.w_Assertion_warning, Interface_names.b_Keep_assertions, 
--					Interface_names.b_Discard_assertions, Interface_names.b_Cancel) 
			else
				confirm_and_compile (assertions_confirmed, Void)
			end
		end
 
feature {NONE} -- Attributes

	c_code_directory: STRING is
			-- Directory where the C code is stored.
		do
			Result := Final_generation_path
		end

	assertions_included: BOOLEAN
			-- Did the user wants to keep the assertions
			-- or not?

	finalization_error: BOOLEAN
			-- Has a validity error been detected during the
			-- finalization? This happens with DLE dealing
			-- with statically bound feature calls

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Finalize
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Finalize
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature {NONE} -- Implementation

	finalize_now: EV_ARGUMENT1 [ANY] is
			-- Argument used for a normal request.
		once
			create Result.make (Void)
		end

	finalize_no_c: EV_ARGUMENT1 [ANY] is
			-- Argument used when files needs to be saved before compiling.
		once
			create Result.make (Void)
		end

	keep_assertions: EV_ARGUMENT1 [ANY] is
			-- Argument used for a normal request.
		once
			create Result.make (Void)
		end

	discard_assertions: EV_ARGUMENT1 [ANY] is
			-- Argument used when files needs to be saved before compiling.
		once
			create Result.make (Void)
		end

	assertions_confirmed: EV_ARGUMENT1 [ANY] is
			-- Argument used when files needs to be saved before compiling.
		once
			create Result.make (Void)
		end

	confirm_and_compile (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Ask for confirmation if the assertion are to be kept, and
			-- finalize thereafter.
		local
			wd: EV_WARNING_DIALOG
			cmd: EV_ROUTINE_COMMAND
		do
			if arg = finalize_no_c then
				start_c_compilation := False
			elseif arg = finalize_now then
				start_c_compilation := True
			end
			if 
				(arg = Void)
			then
				create wd.make_with_text (tool.parent, Interface_names.t_Warning,
					Warning_messages.w_Finalize_warning)
				wd.show_yes_no_cancel_buttons
				create cmd.make (~confirm_and_compile)
				wd.add_yes_command (cmd, finalize_now)
				wd.add_no_command (cmd, finalize_no_c)
				wd.show
--				warner (popup_parent).custom_call (Current, 
--					Warning_messages.w_Finalize_warning,
--					Interface_names.b_Finalize_now, 
--					Interface_names.b_Finalize_now_but_no_C, Interface_names.b_Cancel)
			elseif 
				(arg = assertions_confirmed)
			then
				Precursor (arg, data)
			else
				ask_for_assertions (Void, data)
			end
		end

	perform_compilation is
			-- The real compilation work.
		local
			temp: STRING
		do
			license_display
			-- If the argument is `warner' the user 
			-- pressed on "Keep assertions"
			-- "False" means no assertions
			Eiffel_project.finalize (False)
			finalization_error := not Eiffel_project.successful
		end

	launch_c_compilation is
			-- Launch the C compilation in the background.
		local
			window: EB_CLICKABLE_RICH_TEXT
		do
			window ?= Error_window
			if window /= Void then
				window.set_changed (True)
			end

			if start_c_compilation then
				error_window.put_string	("Launching C compilation in background...")
				Eiffel_project.call_finish_freezing (False)
			end

			if not Eiffel_project.is_final_code_optimal then
				error_window.put_string ("%NWarning: the finalized system might not be optimal%N%
								%%Tin size and speed. In order to produce an optimal%N%
								%%Texecutable, finalize from a new project and do%N%
								%%Tnot use precompilation.%N")
			end

--			if (last_warner /= Void and argument = last_warner) and then Eiffel_project.lace_has_assertions then
--				error_window.put_string ("%NWarning: the finalized system incorporates assertions.%N%
--								%%TIt might therefore not be optimal in size and speed.%N%N")
--			end

			Error_window.put_string ("%NSystem recompiled%N")

			if window /= Void then
				window.set_changed (False)
			end
		end

	license_frequency: INTEGER is 1
 			-- Frequency of license appearance in demo mode.

end -- class EB_FINALIZE_PROJECT_CMD
