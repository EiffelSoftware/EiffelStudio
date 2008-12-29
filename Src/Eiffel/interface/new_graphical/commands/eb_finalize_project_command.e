note
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
			menu_name, pixmap, pixel_buffer, tooltip,
			finalization_error, perform_compilation,
			name,
			make, description, tooltext
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize default values.
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("finalize")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			set_referred_shortcut (l_shortcut)
			accelerator.actions.extend (agent execute)
		end

feature -- Callbacks

	ask_for_assertions
			-- Question the user whether he wants to keep assertions or not.
			-- If the question is answered with discard, it will come to here aswell.
		local
			l_confirm: ES_DISCARDABLE_QUESTION_PROMPT
		do
			create l_confirm.make_standard_with_cancel (Warning_messages.w_assertion_warning, interface_names.l_discard_finalize_assertions, preferences.dialog_data.confirm_finalize_assertions_string)
			l_confirm.set_button_text (l_confirm.dialog_buttons.yes_button, Interface_names.b_discard_assertions)
			l_confirm.set_button_text (l_confirm.dialog_buttons.no_button, Interface_names.b_keep_assertions)
			l_confirm.set_button_action (l_confirm.dialog_buttons.yes_button, agent set_assertion_flag_and_compile (False))
			l_confirm.set_button_action (l_confirm.dialog_buttons.no_button, agent set_assertion_flag_and_compile (True))
			l_confirm.show_on_active_window
		end

	set_assertion_flag_and_compile (keep_assertions: BOOLEAN)
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

	c_code_directory: STRING
			-- Directory where the C code is stored.
		do
			Result := project_location.final_path
		end

	assertions_included: BOOLEAN
			-- Did the user wants to keep the assertions
			-- or not?

	finalization_error: BOOLEAN
			-- Has a validity error been detected during the
			-- finalization? This happens with DLE dealing
			-- with statically bound feature calls

feature {NONE} -- Implementation

	confirm_and_compile
			-- Ask for confirmation if the assertion are to be kept, and
			-- finalize thereafter.
		local
			l_confirm: ES_DISCARDABLE_WARNING_PROMPT
			l_buttons: ES_DIALOG_BUTTONS
		do
			create l_buttons
			create l_confirm.make (warning_messages.w_finalize_warning, l_buttons.yes_no_cancel_buttons, l_buttons.cancel_button, l_buttons.yes_button, l_buttons.cancel_button, interface_names.l_discard_freeze_dialog, preferences.dialog_data.confirm_finalize_string)
			l_confirm.set_button_action (l_confirm.dialog_buttons.yes_button, agent set_c_compilation_and_compile (True))
			l_confirm.set_button_action (l_confirm.dialog_buttons.no_button, agent set_c_compilation_and_compile (False))
			l_confirm.show_on_active_window
		end

	set_c_compilation_and_compile (c_comp: BOOLEAN)
		do
			start_c_compilation := c_comp
			ask_for_assertions
		end

	perform_compilation
			-- The real compilation work.
		do
				-- If the argument is `warner' the user pressed on "Keep assertions"
				-- "False" means no assertions
			Eiffel_project.finalize (assertions_included)
			finalization_error := not Eiffel_project.successful
		end

	launch_c_compilation
			-- Launch the C compilation in the background.
		do
			if start_c_compilation then
				Eiffel_project.call_finish_freezing (False)
			end
		end

feature {NONE} -- Implementation

	description: STRING_GENERAL
			-- Description for the command.
		do
			Result := Interface_names.f_Finalize
		end

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Finalize_new
		end

	pixmap: EV_PIXMAP
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.project_finalize_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command
		do
			Result := pixmaps.icon_pixmaps.project_finalize_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Finalize
		end

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_Finalize
		end

	name: STRING = "Finalize_project";
			-- Name of the command. Used to store the command in the
			-- preferences.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
