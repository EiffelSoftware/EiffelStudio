indexing
	description: "Command to freeze the Eiffel code."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FREEZE_PROJECT_COMMAND

inherit
	EB_MELT_PROJECT_COMMAND
		redefine
			launch_c_compilation,
			confirm_and_compile,
			menu_name, pixmap, tooltip,
			perform_compilation, name,
			make, description
		end
 
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize default values.
		do
			initialize
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_constants.Key_f7),
				True, False, False)
			accelerator.actions.extend (~execute)
		end

feature {NONE} -- Implementation

	confirm_and_compile is
			-- Ask for confirmation, and compile thereafter.
		local
			cd: EB_STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			create cd.make_initialized (
				3, "confirm_freeze",
				Warning_messages.w_Freeze_warning, Interface_names.l_Discard_freeze_dialog
			)
			cd.set_ok_action (~set_c_compilation_and_compile (True))
			cd.set_no_action (~set_c_compilation_and_compile (False))
			cd.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	set_c_compilation_and_compile (c_comp: BOOLEAN) is
		do
			start_c_compilation := c_comp
			confirm_execution_halt
		end

	launch_c_compilation is
			-- Launch the C compilation.
		local
			output_text: STRUCTURED_TEXT
		do
			create output_text.make
			output_text.add_string ("Eiffel system recompiled")
			output_text.add_new_line
	
			if start_c_compilation then
				output_text.add_string ("Background C compilation launched.")
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
			Eiffel_project.freeze
		end

feature {NONE} -- Implementation

	description: STRING is
			-- Description for the command.
		do
			Result := Interface_names.f_Freeze
		end

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Freeze_new
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_freeze
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Freeze
		end

	name: STRING is "Freeze_project"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_FREEZE_PROJECT_COMMAND
