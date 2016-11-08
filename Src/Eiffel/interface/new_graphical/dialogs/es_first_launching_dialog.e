note
	description: "[
			Dialog opened only once, when the new version of EiffelStudio is opened for the first time.
			Currently it provides a way to import previous settings.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_FIRST_LAUNCHING_DIALOG

inherit
	ES_QUESTION_PROMPT
		rename
			make as make_question_prompt
		redefine
			build_prompt_interface
		end

	ES_DIALOG_BUTTONS

	EIFFEL_LAYOUT

create
	make

feature {NONE} -- Initialization

	make (a_version_name: READABLE_STRING_GENERAL)
		local
			s: STRING_32
		do
			create next_actions
			s := interface_names.l_first_time_import_settings_help (a_version_name)
			make_question_prompt (s, yes_no_cancel_buttons, cancel_button,
						yes_button, cancel_button)

			set_title ("Welcome ...")
		end

feature {NONE} -- User interface initialization

	build_prompt_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			-- Note: Redefine to add widgets before the discardable check.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		do
			Precursor (a_container)

			set_button_action (cancel_button, agent on_next (False))
			set_button_action (yes_button, agent on_import)
			set_button_action (no_button, agent on_next (True))
		end

feature -- Events

	on_import
		local
			dlg: ES_SETTINGS_IMPORT_DIALOG
		do
			create dlg.make (development_window)
			dlg.show_modal_to_window (development_window.window)

			on_next (True)
		end

	on_next (a_do_not_show_again: BOOLEAN)
		do
			if a_do_not_show_again then
				preferences.dialog_data.show_first_launching_dialog_preference.set_value (False)
			end
			next_actions.call (Void)
		end

	next_actions: ACTION_SEQUENCE
			-- Next actions.

invariant
note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
end
