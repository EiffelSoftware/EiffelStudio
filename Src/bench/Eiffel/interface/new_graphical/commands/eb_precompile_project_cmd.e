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
			make
		end

	EB_SHARED_WINDOW_MANAGER
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
			qd: EV_QUESTION_DIALOG
		do
			create qd.make_with_text (Warning_messages.w_Precompile_warning)
			qd.button ("Yes").select_actions.extend (~set_c_compilation_and_compile (True))
			qd.button ("No").select_actions.extend (~set_c_compilation_and_compile (False))
			qd.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	set_c_compilation_and_compile (c_comp: BOOLEAN) is
		do
			start_c_compilation := c_comp
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
				Eiffel_project.call_finish_freezing (True)
			end

				-- Display message.
			output_manager.process_text (output_text)
		end

	perform_compilation is
			-- The actual compilation process.
		do
			license_display
			Eiffel_project.precompile (False)
		end

feature {NONE} -- Attributes

	name: STRING is "Precompile"
			-- Name of precompile command.

	menu_name: STRING is
			-- Name used in menu entry
		once
			Result := Interface_names.m_Precompile_new
		end

	is_precompiling: BOOLEAN is True
			-- We are doing a precompilation here.

end -- class EB_PRECOMPILE_PROJECT_CMD
