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

feature -- Settings

	is_debug_enabled: BOOLEAN
		deferred
		end

	is_offline_allowed: BOOLEAN
		deferred
		end

	is_basic_auth_allowed: BOOLEAN
		deferred
		end

	is_sign_in_challenge_auth_allowed: BOOLEAN
		deferred
		end

	is_verbose (a_level: INTEGER): BOOLEAN
			-- has Verbose output for level `a_level` ?
			-- (mostly for debugging).
		deferred
		end

feature -- Access: edition

	eiffel_edition: detachable EIFFEL_EDITION
		deferred
		end

	is_standard_edition: BOOLEAN
			-- Is associated with standard edition of EiffelStudio.
		deferred
		end

	is_enterprise_edition: BOOLEAN
		deferred
		end

	is_branded_edition: BOOLEAN
		deferred
		end

	edition_brand_name: detachable IMMUTABLE_STRING_8
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

	view_account_website_url: READABLE_STRING_8
		do
				-- TODO: get a magic login link, if supported.
			Result := associated_website_url
		end

	view_installation_website_url (inst: ES_ACCOUNT_INSTALLATION): READABLE_STRING_8
		do
			Result := associated_website_url + "/installations/" + inst.id
		end

	new_account_website_url: READABLE_STRING_8
		do
			Result := associated_website_url + "/new_account"
		end

	is_guest: BOOLEAN
			-- Is guest?
		deferred
		end

	is_signed_in: BOOLEAN
		do
			Result := active_account /= Void or else is_guest
		end

	active_account: detachable ES_ACCOUNT
			-- Active account if signed in, otherwise Void.
		deferred
		end

	active_license: detachable ES_ACCOUNT_LICENSE
		do
			if attached installation as inst and then attached inst.associated_license as l_license then
				Result := l_license
			end
		end

	active_license_name: detachable READABLE_STRING_8
		do
			if attached active_license as lic then
				Result := lic.plan_name
			end
		end

	account_licenses (acc: ES_ACCOUNT): LIST [ES_ACCOUNT_LICENSE]
		require
			acc /= Void and then not acc.access_token.is_expired
		deferred
		end

	account_installations (acc: ES_ACCOUNT): LIST [ES_ACCOUNT_INSTALLATION]
		require
			acc /= Void and then not acc.access_token.is_expired
		deferred
		end

	active_session: detachable ES_ACCOUNT_SESSION
			-- Active session, if signed in, otherwise Void.
		deferred
		end

	check_for_new_license
		do
			if
				attached active_account as acc
			then
				update_account (acc)
			end
		end

	installation: ES_ACCOUNT_INSTALLATION
			-- Current installation.
		deferred
		end

	remaining_days_for_guest: INTEGER
			-- Remaining days for guest mode.
		deferred
		end

	guest_mode_signed_in_count: INTEGER
			-- Number of signed in in as guest.
		deferred
		end

	session_heartbeat: NATURAL_32
			-- Delay between two session ping (heartbeat), in seconds.
		deferred
		end

feature -- Installation

	account_installation (acc: ES_ACCOUNT; a_installation_id: READABLE_STRING_GENERAL): detachable ES_ACCOUNT_INSTALLATION
		deferred
		end

	update_installation_license (acc: ES_ACCOUNT; inst: ES_ACCOUNT_INSTALLATION; lic: ES_ACCOUNT_LICENSE)
		deferred
		end

feature -- Remember credentials

	kept_credential: detachable TUPLE [username: READABLE_STRING_32; password: detachable READABLE_STRING_32]
		deferred
		end

	kept_credential_from_file (fn: PATH): like kept_credential
		deferred
		end

	keep_credential (u,p: detachable READABLE_STRING_32)
		deferred
		end

feature -- Sign in

	continue_as_guest
			-- Sign as guest with limitation.
		deferred
		end

	sign_in_with_credential_as_client (a_username: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL)
			-- Connect with `a_username:a_password`, on success set the associated `active_account`.
		deferred
		end

	sign_in_with_credential (a_username: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL)
			-- Connect with `a_username:a_password`, on success set the associated `active_account`.
		deferred
		end

	sign_in_with_access_token (a_username: READABLE_STRING_GENERAL; tok: READABLE_STRING_8)
			-- Connect as `a_username` with token `tok`, on success set the associated `active_account`.
		deferred
		end

	new_cloud_sign_in_request (a_info: detachable READABLE_STRING_GENERAL): detachable ES_CLOUD_SIGN_IN_REQUEST
			-- Request a new sign-in challenge  (sign-in using browser)
		deferred
		end

	check_cloud_sign_in_request (rqst: ES_CLOUD_SIGN_IN_REQUEST)
			-- Check status of sign-in challenge request, and get associated data if approved.
		deferred
		end

	sign_out
			-- Sign out current session.
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

	async_check_availability (a_force_operation: BOOLEAN)
		deferred
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

	set_eiffel_edition (ed: EIFFEL_EDITION)
			--Set the `eiffel_edition` to `ed`.
		deferred
		end

	set_verbose_level (a_level: INTEGER)
		deferred
		end

feature -- Settings

	set_connection_timeout (a_secs: INTEGER)
		deferred
		end

	set_timeout (a_secs: INTEGER)
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

	on_session_heartbeat_updated (a_heartbeat: NATURAL)
		do
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_session_heartbeat_updated (a_heartbeat)
				end
			end
		end

	on_cloud_available (a_is_available: BOOLEAN)
		do
			debug ("es_cloud")
				print (generator + ".on_cloud_available (" + a_is_available.out + ")%N")
			end
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_cloud_available (a_is_available)
				end
			end
		end

	on_account_signed_in (acc: ES_ACCOUNT)
		do
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_account_signed_in (acc)
				end
			end
			if account_signed_in_event.is_interface_usable then
				account_signed_in_event.publish (acc)
			end
		end

	on_account_signed_out (a_previous_acc: detachable ES_ACCOUNT)
		do
			if attached installation as inst then
				inst.set_associated_license (Void)
			end
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_account_signed_out (a_previous_acc)
				end
			end
				-- FIXME: if gpl edition, quit EiffelStudio?
			if account_signed_out_event.is_interface_usable then
				account_signed_out_event.publish (a_previous_acc)
			end
		end

	on_account_license_issue (a_issue: ES_ACCOUNT_LICENSE_ISSUE)
		do
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_account_license_issue (a_issue)
				end
			end
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

feature -- Events: Connection point

	es_cloud_connection: EVENT_CONNECTION_I [ES_CLOUD_OBSERVER, ES_CLOUD_S]
			-- Connection point.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
		end

feature -- Events

	account_signed_in_event: EVENT_TYPE [TUPLE [acc: detachable ES_ACCOUNT]]
			-- Events called when an account is signed in.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	account_signed_out_event: EVENT_TYPE [TUPLE [acc: detachable ES_ACCOUNT]]
			-- Events called when an account is signed out.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature {NONE} -- Implementation

	observers: detachable ARRAYED_LIST [ES_CLOUD_OBSERVER]

invariant

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
