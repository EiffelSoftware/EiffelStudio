indexing
	description	: "Command to precompile the Eiffel code."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PRECOMPILE_PROJECT_COMMAND

inherit
	EB_MELT_PROJECT_COMMAND
		redefine
			launch_c_compilation,
			confirm_and_compile,
			name, menu_name,
			perform_compilation,
			is_precompiling,
			make, tooltext
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create
	make

feature {NONE} --Initialization

	make is
			-- Initialize `Current'.
		do
			Precursor {EB_MELT_PROJECT_COMMAND}
			accelerator := Void
		end

feature {NONE} -- Implementation

	confirm_and_compile is
			-- Ask for confirmation, and compile thereafter.
		local
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			start_c_compilation := True
			if is_dotnet_project then
				create cd.make_initialized (3, preferences.dialog_data.confirm_finalize_precompile_string,
					Warning_messages.w_Finalize_precompile,
					interface_names.l_discard_finalize_precompile_dialog,
					preferences.preferences)
				cd.set_ok_action (agent confirm_finalization_and_compile (True))
				cd.set_no_action (agent confirm_finalization_and_compile (False))
				cd.show_modal_to_window (window_manager.last_focused_development_window.window)
			else
				confirm_finalization_and_compile (False)
			end
		end

	confirm_finalization_and_compile (fin_comp: BOOLEAN) is
			-- Ask for confirmation to finalize and discard assertions and compile	
		do
			finalize_precompile := fin_comp
			compile
		end

	launch_c_compilation is
			-- Launch the C compilation in the background.
		local
			output_text: STRUCTURED_TEXT
		do
			create output_text.make
			output_text.add_string ("Eiffel system recompiled")
			output_text.add_new_line

			if start_c_compilation then
				output_text.add_string ("Launching C compilation in background...")
				output_text.add_new_line
					-- Display message.
				output_manager.process_text (output_text)
				Eiffel_project.call_finish_freezing (True)

				if finalize_precompile then
					Eiffel_project.call_finish_freezing (False)
				end
			end
		end

	perform_compilation is
			-- The actual compilation process.
		do
			if finalize_precompile then
				Eiffel_project.finalize_precompile (False, False)
			else
				Eiffel_project.precompile (False)
			end
		end

feature {NONE} -- Attributes

	tooltext: STRING is
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_Precompile
		end

	name: STRING is "Precompile"
			-- Name of precompile command.

	menu_name: STRING is
			-- Name used in menu entry
		once
			Result := Interface_names.m_Precompile_new
		end

	is_precompiling: BOOLEAN is True
			-- We are doing a precompilation here.

	finalize_precompile: BOOLEAN
			-- should precompile be finalized also?


feature {NONE} -- Implementation

	is_dotnet_project: BOOLEAN is
			-- is current loaded ace a .net project
		require
			non_void_lace: lace /= Void
		local
			l_ast: ACE_SD
		do
			l_ast := lace.parsed_ast
				-- `l_ast' could be Void if Ace is not valid.
			if l_ast /= Void then
				Result := l_ast.is_dotnet_project
			end
		end

end -- class EB_PRECOMPILE_PROJECT_CMD
