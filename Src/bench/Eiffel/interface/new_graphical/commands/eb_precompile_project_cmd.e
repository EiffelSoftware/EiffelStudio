indexing
	description: "Command to precompile the Eiffel code."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRECOMPILE_PROJECT_CMD

inherit
	EB_MELT_PROJECT_CMD
		redefine
			launch_c_compilation,
			confirm_and_compile,
--			name, menu_name, accelerator,
			perform_compilation,
			is_precompiling
		end
 
creation

	make

feature {NONE} -- Implementation

	confirm_and_compile (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Ask for confirmation, and compile thereafter.
		local
			wd: EV_WARNING_DIALOG
			cmd: EV_ROUTINE_COMMAND
		do
			if arg = precompile_no_c then
				start_c_compilation := False
			elseif arg = precompile_now then
				start_c_compilation := True
			end				
			if 
				(arg = Void) 
			then
				create wd.make_with_text (tool.parent, Interface_names.t_Warning,
					Warning_messages.w_Freeze_warning)
				wd.show_yes_no_cancel_buttons
				create cmd.make (~confirm_and_compile)
				wd.add_yes_command (cmd, precompile_now)
				wd.add_no_command (cmd, precompile_no_c)
				wd.show
--				warner (popup_parent).custom_call
--							(Current, Warning_messages.w_Precompile_warning,
--							Interface_names.b_Precompile_now,
--							Interface_names.b_Precompile_now_but_no_C,
--							Interface_names.b_Cancel)
			else
				compile
			end
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

			Error_window.put_string ("System recompiled")
	
			if start_c_compilation then
				error_window.put_string ("%NLaunching C compilation in background...%N")
				Eiffel_project.call_finish_freezing (True)
			end
		
			if window /= Void then
				window.set_changed (False)
			end
		end

	perform_compilation is
			-- The actual compilation process.
		do
			license_display
			Eiffel_project.precompile (False)
		end

feature {NONE} -- Attributes

	precompile_now: EV_ARGUMENT1 [ANY] is
			-- Argument used for a normal request.
		once
			create Result.make (Void)
		end

	precompile_no_c: EV_ARGUMENT1 [ANY] is
			-- Argument used when files needs to be saved before compiling.
		once
			create Result.make (Void)
		end

--	name: STRING is
--			-- Name of the command.
--		once
--			Result := Interface_names.f_Precompile
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		once
--			Result := Interface_names.m_Precompile
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		once
--			Result := Interface_names.a_Precompile
--		end

	is_precompiling: BOOLEAN is True
			-- We are doing a precompilation here.

end -- class EB_PRECOMPILE_PROJECT_CMD
