indexing
	description	: "Command to finalize the Eiffel code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FINALIZE_PROJECT_COMMAND

inherit
	EB_MELT_PROJECT_COMMAND
		redefine
			c_code_directory, launch_c_compilation,
			confirm_and_compile,
			menu_name, pixmap, tooltip,
			finalization_error, perform_compilation,
			name,
			make, description, tooltext
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_constants.Key_f7),
				True, False, True)
			accelerator.actions.extend (agent execute)
		end

feature -- Callbacks

	ask_for_assertions is
			-- Question the user whether he wants to keep assertions or not.
			-- If the question is answered with discard, it will come to here aswell.
		local
			cd: EB_CONFIRM_FINALIZE_ASSERTIONS_DIALOG
		do
			create cd
			cd.set_ok_action (agent set_assertion_flag_and_compile (False))
			cd.set_no_action (agent set_assertion_flag_and_compile (True))
			cd.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	set_assertion_flag_and_compile (keep_assertions: BOOLEAN) is
		do
			assertions_included := keep_assertions
			if
				Workbench.system_defined and then
				System.keep_assertions /= keep_assertions
			then
					-- Force refinalization when user changed is mind since
					-- last time.
				System.set_finalize
			end
			confirm_execution_halt
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

feature {NONE} -- Implementation

	confirm_and_compile is
			-- Ask for confirmation if the assertion are to be kept, and
			-- finalize thereafter.
		local
			cd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			create cd.make_initialized (
				3, preferences.dialog_data.confirm_finalize_string,
				Warning_messages.w_Finalize_warning, Interface_names.l_Discard_freeze_dialog,
				preferences.preferences
			)
			cd.set_ok_action (agent set_c_compilation_and_compile (True))
			cd.set_no_action (agent set_c_compilation_and_compile (False))
			cd.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	set_c_compilation_and_compile (c_comp: BOOLEAN) is
		do
			start_c_compilation := c_comp
			ask_for_assertions
		end

	perform_compilation is
			-- The real compilation work.
		do
				-- If the argument is `warner' the user pressed on "Keep assertions"
				-- "False" means no assertions
			Eiffel_project.finalize (assertions_included)
			finalization_error := not Eiffel_project.successful
		end

	launch_c_compilation is
			-- Launch the C compilation in the background.
		local
			output_text: STRUCTURED_TEXT
		do
				-- Create message.
			create output_text.make
			output_text.add_string ("Eiffel System recompiled")
			output_text.add_new_line

			if start_c_compilation then
				if not Eiffel_project.is_final_code_optimal then
					create output_text.make
					output_text.add_string ("Warning: the finalized system might not be optimal")
					output_text.add_new_line
					output_text.add_string ("in size and speed. In order to produce an optimal")
					output_text.add_new_line
					output_text.add_string ("executable, finalize from a new project and do")
					output_text.add_new_line
					output_text.add_string ("not use precompilation or assertions.")
					output_text.add_new_line
				end
					-- Display message.
				output_manager.process_text (output_text)
				Eiffel_project.call_finish_freezing (False)
			end

		end

feature {NONE} -- Implementation

	description: STRING is
			-- Description for the command.
		do
			Result := Interface_names.f_Finalize
		end

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Finalize_new
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_finalize
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Finalize
		end

	tooltext: STRING is
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_Finalize
		end

	name: STRING is "Finalize_project";
			-- Name of the command. Used to store the command in the
			-- preferences.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_FINALIZE_PROJECT_COMMAND
