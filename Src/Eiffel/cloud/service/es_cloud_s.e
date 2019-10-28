note
	description: "Summary description for {ACCOUNT_MANAGER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_S

inherit
	SERVICE_I

feature -- Status report

	is_available: BOOLEAN
			-- Is account service available?
		deferred
		end

	has_error: BOOLEAN
			-- Last operation reported an error?
		deferred
		end

	last_error_message: detachable READABLE_STRING_32
			-- If `has_error`, error message.
		deferred
		end

feature -- Debug purpose

	is_debug_enabled: BOOLEAN
		deferred
		end

feature -- Access

	server_url: READABLE_STRING_8
			-- ES cloud server url.
		deferred
		end

	associated_website_url: READABLE_STRING_8
			-- Web site associated to the cloud webapi.
		deferred
		end

	is_guest: BOOLEAN
			-- Is guest?
		deferred
		end

	is_logged_in: BOOLEAN
		do
			Result := active_account /= Void or else is_guest
		end

	active_account: detachable ES_ACCOUNT
			-- Active account if logged in, otherwise Void.
		deferred
		end

	active_session: detachable ES_ACCOUNT_SESSION
			-- Active session, if logged in, otherwise Void.
		deferred
		end

	installation: ES_ACCOUNT_INSTALLATION
			-- Current installation.
		deferred
		end

	remaining_days_for_guest: INTEGER
			-- Remaining days for guest mode.
		deferred
		end

	guest_mode_loging_count: INTEGER
			-- Number of loging as guest.
		deferred
		end

feature -- Sign in

	login_as_guest
			-- Sign as guest with limitation.
		deferred
		end

	login_with_credential (a_username: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL)
			-- Login with `a_username:a_password`, on success set the associated `active_account`.
		deferred
		end

	login_with_access_token (a_username: READABLE_STRING_GENERAL; tok: READABLE_STRING_8)
			-- Login as `a_username` with token `tok`, on success set the associated `active_account`.
		deferred
		end

	logout
			-- Logout current session.
		deferred
		end

	quit
		-- Quit session (could be quit EiffelStudio).
		deferred
		end

feature -- Update

	resume_active_session
		do
			if attached active_session as sess then
				resume_session (sess.account, sess)
			end
		end

	async_ping_installation (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		deferred
		end

	ping_installation (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		deferred
		end

	end_session (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		deferred
		end

	pause_session (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		deferred
		end

	resume_session (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		deferred
		end

	update_session (sess: ES_ACCOUNT_SESSION)
		deferred
		end

	update_account (acc: ES_ACCOUNT)
		deferred
		end

	refresh_token (a_token: ES_ACCOUNT_ACCESS_TOKEN; acc: ES_ACCOUNT)
		require
			a_token_has_refresh_key: a_token.has_refresh_key
		deferred
		end

feature -- Account Registration	

	register_account (a_username: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL; a_email: READABLE_STRING_8; a_additional_values: detachable TABLE_ITERABLE [READABLE_STRING_GENERAL, READABLE_STRING_GENERAL])
			-- Register a new account for `a_user_name`, and `a_password`,
			-- on success set `active_account` to new account.
			-- On error, TODO.
		deferred
		end

feature -- Registration

	set_server_url (a_server_url: READABLE_STRING_8)
			-- Change the cloud server url to `a_server_url`.
		deferred
		end

feature -- Connection checking

	check_cloud_availability
		deferred
		end

feature -- Events

	on_session_state_changed (sess: ES_ACCOUNT_SESSION)
		do
			update_session (sess)
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_session_state_changed (sess)
				end
			end
		end

	on_cloud_available (a_is_connected: BOOLEAN)
		do
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_cloud_available (a_is_connected)
				end
			end
		end

	on_account_logged_in (acc: ES_ACCOUNT)
		do
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_account_logged_in (acc)
				end
			end
		end

	on_account_logged_out
		do
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_account_logged_out
				end
			end
				-- FIXME: if gpl edition, quit EiffelStudio?
		end

	on_account_updated (acc: detachable ES_ACCOUNT)
		do
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_account_updated (acc)
				end
			end
		end

feature -- Observer

	register_observer (obs: ES_CLOUD_OBSERVER)
		local
			lst: like observers
		do
			lst := observers
			if lst = Void then
				create lst.make (1)
				observers := lst
			end
			lst.extend (obs)
		end

	unregister_observer (obs: ES_CLOUD_OBSERVER)
		local
			lst: like observers
		do
			lst := observers
			if lst /= Void then
				lst.prune_all (obs)
				if lst.is_empty then
					observers := Void
				end
			end
		end

feature {NONE} -- Implementation

	observers: detachable ARRAYED_LIST [ES_CLOUD_OBSERVER]

invariant

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
