indexing
	description: "[
		Communicates with the login site to permit logging in and out of the support system.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	COMM_SUPPORT_LOGIN

inherit
	COMM_SUPPORT_ACCESS

create
	make

feature {NONE} -- Access

	last_username: STRING_GENERAL
			-- Last logged in user's user name

	last_password: STRING_GENERAL
			-- Last logged in user's password

feature -- Status report

	is_logged_in: BOOLEAN
			-- Indicates if a user has been logged in

feature -- Basic operations

	attempt_logon (a_user, a_pass: STRING_GENERAL; a_remember: BOOLEAN)
			-- Attemps to log a user in
		require
			is_support_accessible: is_support_accessible
		local
			l_curl: like curl
			l_hnd: like curl_hnd
			l_page: CURL_STRING
			l_post_string: CURL_STRING
			l_view_state_value: STRING_GENERAL
			l_event_validation: STRING_GENERAL
			l_matcher: RX_PCRE_MATCHER
			retried: BOOLEAN
		do
			is_logged_in := False
			if not retried then
				l_curl := curl
				l_hnd := curl_hnd

				create l_page.make_empty
				l_curl.setopt_string (l_hnd, {CURL_OPT_CONSTANTS}.curlopt_url, login_url (logon_url, True))
				l_curl.setopt_curl_string (l_hnd, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_page)
				perform

				l_view_state_value := encoding_url (find_view_state (l_page.string).as_string_8)
				l_event_validation := encoding_url (find_event_validation (l_page.string).as_string_8)

				l_page.wipe_out

				create l_post_string.make_from_string (post_string_for_login (l_view_state_value, l_event_validation, a_user, a_pass))
				l_curl.setopt_string (l_hnd, {CURL_OPT_CONSTANTS}.curlopt_url, login_url (logon_url, True))
	 			l_curl.setopt_integer (l_hnd, {CURL_OPT_CONSTANTS}.curlopt_post, 1)
	 			l_curl.setopt_string (l_hnd, {CURL_OPT_CONSTANTS}.curlopt_postfields, l_post_string)
	 			l_curl.setopt_curl_string (l_hnd, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_page)
	 			l_curl.setopt_string (l_hnd, {CURL_OPT_CONSTANTS}.curlopt_cookie, "____Pagemain_div__ToggleState=1")
	 			perform

				create l_matcher.make
				l_matcher.compile ("Object\smoved\sto\s<a\shref=%"" + login_url ("secure/protected/account_info.aspx", True) + "%">here")
				l_matcher.match (l_page.as_string_8)

				is_logged_in := l_matcher.has_matched
				if is_logged_in then
					last_username := a_user
					last_password := a_pass
				end
			end
		ensure
			last_username_set: (is_logged_in and last_username = a_user) or (not is_logged_in and last_username = Void)
			last_password_set: (is_logged_in and last_password = a_pass) or (not is_logged_in and last_password = Void)
		rescue
			check endlast_result_set: last_result /= {CURL_CODES}.curle_ok end
			retried := True
			retry
		end

	force_logout
			-- Forces log out
		require
			is_support_accessible: is_support_accessible
		local
			l_curl: like curl
			l_hnd: like curl_hnd
			l_page: CURL_STRING
			retried: BOOLEAN
		do
			is_logged_in := False
			last_username := Void
			last_password := Void
			if not retried then
				l_curl := curl
				l_hnd := curl_hnd

				create l_page.make_empty
				l_curl.setopt_string (l_hnd, {CURL_OPT_CONSTANTS}.curlopt_url, login_url (logoff_url, True))
				l_curl.setopt_curl_string (l_hnd, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_page)
				perform
			end
		ensure
			not_is_logged_in: not is_logged_in
		rescue
			check endlast_result_set: last_result /= {CURL_CODES}.curle_ok end
			retried := True
			retry
		end

feature -- Query

	login_url (a_relative_url: STRING_GENERAL; a_secure: BOOLEAN): STRING_8
			-- Retrieve full URL for login site
			--
			-- `a_relative_url': Relative url to the login site
			-- `a_secure': Indicates if a suecure connection should be used.
			-- `Result': An absolute URL to the requested page
		require
			not_a_relative_url_is_empty: a_relative_url /= Void implies not a_relative_url.is_empty
		do
			if a_relative_url /= Void then
				Result := support_url (once "login/" + a_relative_url.as_string_8, a_secure)
			else
				Result := support_url (once "login/", a_secure)
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Query

	post_string_for_login (a_view_state: STRING_GENERAL; a_event_validation: STRING_GENERAL; a_user: STRING_GENERAL; a_pass: STRING_GENERAL): STRING_32
			-- Create post string for login page.
		require
			a_view_state_attached: a_view_state /= Void
			a_event_validation_attached: a_event_validation /= Void
			a_user_attached: a_user /= Void
			not_a_user_is_empty: not a_user.is_empty
			a_pass_attached: a_pass /= Void
			not_a_pass_is_empty: not a_pass.is_empty
		do
			create Result.make (256)
			Result.append ("__EVENTTARGET=")
			Result.append_character ('&')
			Result.append ("__EVENTARGUMENT=")
			Result.append_character ('&')
			Result.append ("__VIEWSTATE=" + a_view_state.as_string_32)
			Result.append_character ('&')
			Result.append ("ctl00%%24ctl00%%24default_main_content%%24main_content%%24display_username=")
			Result.append_character ('&')
			Result.append ("ctl00%%24ctl00%%24default_main_content%%24main_content%%24register_username=" + a_user.as_string_32)
			Result.append_character ('&')
			Result.append ("ctl00%%24ctl00%%24default_main_content%%24main_content%%24display_password=")
			Result.append_character ('&')
			Result.append ("ctl00%%24ctl00%%24default_main_content%%24main_content%%24register_password=" + a_pass.as_string_32)
			Result.append_character ('&')
			Result.append ("ctl00%%24ctl00%%24default_main_content%%24main_content%%24login_button=Login")
			Result.append_character ('&')
			Result.append ("__EVENTVALIDATION=" + a_event_validation.as_string_32)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Constants

	logon_url: STRING = "secure/logon.aspx"
	logoff_url: STRING = "logoff.aspx"

invariant
	last_username_attached: is_logged_in implies last_username /= Void
	not_last_username_is_empty: is_logged_in implies not last_username.is_empty
	last_password_attached: is_logged_in implies last_password /= Void
	not_last_password_is_empty: is_logged_in implies not last_password.is_empty

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
