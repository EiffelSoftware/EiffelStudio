note
	description: "Summary description for {ES_CLOUD_NAMES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_NAMES

inherit
	SHARED_LOCALE

feature -- Authentication

	prompt_sign_to_cloud_services: STRING_32 do Result := locale.translation_in_context ("Sign in to use EiffelStudio cloud services.", "eiffel.account") end

	prompt_sign_to_edition_cloud_services (a_edition: READABLE_STRING_GENERAL): STRING_32 do Result := locale.formatted_string (locale.translation_in_context ("Sign in to use EiffelStudio $1 services.", "eiffel.account"), [a_edition]) end

	prompt_agree_terms_of_use_and_rules: STRING_32
		do
			Result := locale.translation ("By using EiffelStudio, you agree to the terms of use and the rules on user-provided information.")
		end

	prompt_learn_more_about_data_collection (a_url: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation_in_context ("User information provided during the registration process is used solely for the purpose of creating a user account at $1 and enforcing the usage rules (number of concurrent sessions) according to the terms of the EiffelStudio license. Eiffel Software does not share such information with any third party.", "eiffel.account"), [a_url])
		end

	prompt_note_support_account_usage: STRING_32 do Result := locale.translation_in_context ("Note: You can use //support.eiffel.com/ account", "eiffel.account") end

	link_create_new_account: STRING_32 do Result := locale.translation_in_context ("Create a new account", "eiffel.account") end

	button_remember_credentials: STRING_32 do Result := locale.translation_in_context ("Remember my credentials", "eiffel.account") end
	tooltip_do_not_use_on_public_machine: STRING_32 do Result := locale.translation_in_context ("Do not use this option on a public machine! Password is stored in plain text.", "eiffel.account") end

	label_open_eiffelstudio_account_web_site: STRING_32 do Result := locale.translation_in_context ("Open EiffelStudio account website in web browser.", "eiffel.account") end

	label_can_continue_as_guest_for_n_days (nb_days: INTEGER): READABLE_STRING_32
		do
			Result := locale.formatted_string (locale.plural_translation_in_context
			(once "This is the last day you can still continue as guest", once "You can still continue as guest for $1 more days", once "eiffel.account", nb_days), nb_days)
		end

	label_cannot_continue_as_guest: STRING_32 do Result := locale.translation ("You can not continue as guest anymore!") end

	label_no_account_text: STRING_32 do Result := locale.translation ("No account?") end
	label_create_new_account: STRING_32 do Result := locale.translation ("Create one!") end

	label_sign_in_with_existing_account: STRING_32 do Result := locale.translation ("You already have an account? Sign in >>") end

	label_user_name: STRING_32 do Result := locale.translation ("User Name") end
	label_first_name: STRING_32 do Result := locale.translation ("First Name") end
	label_last_name: STRING_32 do Result := locale.translation ("Last Name") end
	label_password: STRING_32 do Result := locale.translation ("Password") end
	label_email: STRING_32 do Result := locale.translation ("Email") end

feature -- Account tool	

	desc_cloud_account_tool: STRING_32 do Result := locale.translation ("Show Account Tool") end

	prompt_welcome_guest: STRING_32 do Result := locale.translation_in_context ("Welcome guest.", "cloud.info") end

	prompt_not_connected_with_account: STRING_32 do Result := locale.translation_in_context ("You are not connected with an account.", "cloud.info") end

	prompt_connected_your_account: STRING_32 do Result := locale.translation_in_context ("Connect your account to use EiffelStudio.", "cloud.info") end

	label_service_not_available: STRING_32 do Result := locale.translation_in_context ("Cloud service unavailable!", "cloud.error") end

	button_try_to_reconnect: STRING_32 do Result := locale.translation_in_context ("Try to reconnect", "cloud.action") end

	label_field_installation: STRING_32 do Result := locale.translation_in_context ("Installation: ", "cloud.info") end

	button_show_more: STRING_32 do Result := locale.translation_in_context ("Show more", "cloud.info") end
	button_show_less: STRING_32 do Result := locale.translation_in_context ("Show less", "cloud.info") end

	tooltip_button_show_more: STRING_32 do Result := locale.translation_in_context ("Toggle this button to show more|less information.", "cloud.info") end

feature -- Dialog

	button_visit_web_account: STRING_32 do Result := locale.translation_in_context ("My web account...", "cloud.info") end
	tooltip_button_visit_web_account: STRING_32 do Result := locale.translation_in_context ("Visit my online account (in web browser).", "cloud.info") end

	title_license_expired: STRING_32 do Result := locale.translation_in_context ("Your license has EXPIRED.", "cloud.info") end
	title_license_issue: STRING_32 do Result := locale.translation_in_context ("Issue with your license.", "cloud.info") end

	title_session_paused: STRING_32 do Result := locale.translation_in_context ("This session is PAUSED.", "cloud.info") end

	label_opening_url (a_url: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation_in_context ("Opening $1", "cloud.info"), [a_url])
		end

	label_error_opening_url (a_url: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation_in_context ("Error: could not open $1", "cloud.error"), [a_url])
		end

	button_check_again: STRING_32 do Result := locale.translation_in_context ("Check again", "cloud") end
	tooltip_button_check_again: STRING_32 do Result := locale.translation_in_context ("Check again if a license is available for your environment (platform, version).", "cloud") end

feature -- Menu

	menu_account: STRING_32 do Result := locale.translation_in_context ("Account...", "cloud.menu") end

	button_account: STRING_32 do Result := locale.translation_in_context ("Account", "cloud.menu") end

	menu_my_account (a_username: READABLE_STRING_GENERAL): STRING_32 do Result := locale.formatted_string (locale.translation_in_context ("My Account ($1)", "cloud.menu"), [a_username])	end

	menu_guest_account: STRING_32 do Result := locale.translation_in_context ("Guest Account", "cloud.menu") end

	menu_sign_in: STRING_32 do Result := locale.translation_in_context ("Sign In", "cloud.menu") end

	menu_check: STRING_32 do Result := locale.translation_in_context ("check", "cloud.menu") end

feature -- General

	label_learn_more: STRING_32 do Result := locale.translation_in_context ("Learn more...", "cloud") end
	label_terms_of_use: STRING_32 do Result := locale.translation_in_context ("Terms of use", "cloud") end
	label_double_click_to_collapse: STRING_32 do Result := locale.translation_in_context ("Double click to collapse", "cloud") end
	button_guest: STRING_32 do Result := locale.translation_in_context ("Guest", "cloud") end
	tooltip_button_guest: STRING_32 do Result := locale.translation_in_context ("Continue using EiffelStudio as a guest", "cloud") end
	button_retry: STRING_32 do Result := locale.translation_in_context ("Retry", "cloud") end

	button_quit: STRING_32 do Result := locale.translation_in_context ("Quit", "cloud") end
	tooltip_button_quit: STRING_32 do Result := locale.translation_in_context ("Quit EiffelStudio", "cloud") end
	button_continue: STRING_32 do Result := locale.translation_in_context ("Continue", "cloud") end
	button_submit: STRING_32 do Result := locale.translation_in_context ("Submit", "cloud") end

	button_sign_in: STRING_32 do Result := locale.translation ("Sign in") end
	button_sign_out: STRING_32 do Result := locale.translation ("Sign out") end
	button_reload: STRING_32 do Result := locale.translation ("Reload") end
	button_register: STRING_32 do Result := locale.translation ("Register") end
	button_update: STRING_32 do Result := locale.translation_in_context ("Update", "cloud.info") end
	tooltip_button_update: STRING_32 do Result := locale.translation_in_context ("Update account information (synchronize)", "cloud.info") end

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
