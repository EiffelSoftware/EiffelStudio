note
	description: "Command to freeze the Eiffel code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("freeze")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			set_referred_shortcut (l_shortcut)
			accelerator.actions.extend (agent execute)
		end

feature {NONE} -- Implementation

	confirm_and_compile
			-- Ask for confirmation, and compile thereafter.
		local
			l_confirm: ES_DISCARDABLE_WARNING_PROMPT
			l_buttons: ES_DIALOG_BUTTONS
		do
			create l_buttons
			create l_confirm.make (warning_messages.w_freeze_warning, l_buttons.yes_no_cancel_buttons, l_buttons.cancel_button, l_buttons.yes_button, l_buttons.cancel_button, interface_names.l_discard_freeze_dialog, create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.confirm_freeze_preference, True))
			l_confirm.set_button_action (l_confirm.dialog_buttons.yes_button, agent set_c_compilation_and_compile (True))
			l_confirm.set_button_action (l_confirm.dialog_buttons.no_button, agent set_c_compilation_and_compile (False))
			l_confirm.show_on_active_window
		end

	set_c_compilation_and_compile (c_comp: BOOLEAN)
		do
			start_c_compilation := c_comp
			confirm_execution_halt
		end

	launch_c_compilation
			-- Launch the C compilation.
		do
			if start_c_compilation and then not lace.compile_all_classes then
				eiffel_project.call_finish_freezing (True)
			end
		end

	perform_compilation
			-- The actual compilation process.
		do
			Eiffel_project.freeze
		end

feature {NONE} -- Implementation

	description: STRING_GENERAL
			-- Description for the command.
		do
			Result := Interface_names.f_Freeze
		end

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Freeze_new
		end

	pixmap: EV_PIXMAP
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.project_freeze_icon
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Freeze
		end

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_Freeze
		end

	name: STRING = "Freeze_project";
			-- Name of the command. Used to store the command in the
			-- preferences.

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_FREEZE_PROJECT_COMMAND
