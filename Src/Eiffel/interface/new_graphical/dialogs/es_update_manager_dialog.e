note
	description: "[
		Dialog opened only when there is new release version of EiffelStudio beta or stable.
		Provides a way to get the new EiffelStudio release.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_UPDATE_MANAGER_DIALOG
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

	make (a_release: ES_UPDATE_RELEASE)
		local
			s: STRING_32
		do
			release := a_release
			create next_actions

			if release.channel.is_case_insensitive_equal_general ({ES_UPDATE_CONSTANTS}.beta_channel) then
				s := interface_names.l_update_manager_estudio_beta_help (a_release.number)
			else
				s := interface_names.l_update_manager_estudio_stable_help (a_release.number)
			end

			make_question_prompt (s, yes_no_cancel_buttons, cancel_button,
						yes_button, cancel_button)

			set_title (interface_names.t_welcome)
		ensure
			release_set: release = a_release
		end

feature {NONE} -- Implementation

	release: ES_UPDATE_RELEASE
			-- Object representing an update release.

feature {NONE} -- User interface initialization

	build_prompt_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			-- Note: Redefine to add widgets before the discardable check.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		do
			Precursor (a_container)

			set_button_text (cancel_button, interface_names.b_remind_me_later)
			set_button_text (yes_button, interface_names.b_try_it_now)
			set_button_text (no_button, interface_names.b_ignore)

			set_button_action (cancel_button, agent on_next (False))
			set_button_action (yes_button, agent on_download)
			set_button_action (no_button, agent on_next (True))
		end

feature -- Events

	on_download
		local
			is_launched: BOOLEAN
		do
			is_launched := (create {ES_URI_LAUNCHER}).launch (release.link)
			on_next (True)
		end

	on_next (a_do_not_show_again: BOOLEAN)
		do
			if a_do_not_show_again then
				preferences.dialog_data.show_update_manager_dialog_preference.set_value (False)
				preferences.preferences.save_preferences -- Save right away!
			end
			next_actions.call (Void)
		end

	next_actions: ACTION_SEQUENCE
			-- Next actions.

invariant
note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
