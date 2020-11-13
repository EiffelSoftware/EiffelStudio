note
	description: "Summary description for {ES_CLOUD_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_CONTROLLER

inherit
	ES_CLOUD_OBSERVER
		redefine
			on_account_signed_in,
			on_account_signed_out,
			on_account_license_issue,
			on_account_updated,
			on_cloud_available,
			on_session_state_changed,
			on_session_heartbeat_updated
		end

	SHARED_ES_CLOUD_SERVICE

	EB_SHARED_WINDOW_MANAGER

create
	make

feature {NONE} -- Initialization

	make
		do
				-- Default
			ping_heartbeat := 900 -- 15 * 60 s = 15 minutes
--			ping_heartbeat := 300 --  5 * 60 s =  5 minutes
--			ping_heartbeat := 60  --  1 * 60 s =  1 minutes
--			ping_heartbeat := 30  --      30 s = 30 seconds
		end

feature {NONE} -- Background ping

	ping_heartbeat: NATURAL_32
			-- ping delay in seconds.

	ping_timeout: detachable EV_TIMEOUT

	is_pinging_in_background: BOOLEAN
		do
			Result := attached ping_timeout as t and then
					not t.is_destroyed and then
					t.interval > 0 and then
					not t.actions.is_empty
		end

	start_background_pinging (acc: ES_ACCOUNT)
		local
			t: EV_TIMEOUT
		do
			debug ("es_cloud")
				print (generator + ".start_background_pinging (" + acc.username + ")%N")
			end
			if
				attached es_cloud_s.service as l_service and then
				l_service.session_heartbeat > 0
			then
				ping_heartbeat := l_service.session_heartbeat
			end
			process_ping (acc)

			t := ping_timeout
			if t /= Void then
				t.destroy
			end
			create t
			t.actions.extend (agent process_ping (acc))
			t.set_interval (ping_heartbeat.to_integer_32 * 1_000) -- converted to milliseconds.
			ping_timeout := t
		end

	stop_background_pinging
		do
			if attached ping_timeout as t then
				t.destroy
				t.set_interval (0)
				t.actions.wipe_out
				ping_timeout := Void
			end
		end

	process_ping (acc: ES_ACCOUNT)
		local
			nb: INTEGER_64
		do
			if attached es_cloud_s.service as cld then
				debug ("es_cloud")
					print ("%N" +  (create {DATE_TIME}.make_now).out + "%N")
					print (generator + ".process_ping (" + acc.username + ") HEARTBEAT=" + ping_heartbeat.out + "%N")
				end
				if attached acc.access_token as l_access_token then
					nb := l_access_token.expiration_delay_in_seconds
					if
						nb <= (3 * 24 * 60 * 60) -- remains less than 3 days, a long weekend
						or nb <= 5 * ping_heartbeat.to_integer_64  -- remains less than 5 heartbeat
					then
						cld.refresh_token (l_access_token, acc)
					end
				end
				if
					attached cld.active_session as sess and then
					not sess.is_paused
				then
					cld.async_ping_installation (acc, sess)
				end
			end
		end

feature -- Events

	last_is_available: BOOLEAN

	on_cloud_available (a_is_available: BOOLEAN)
		do
			if last_is_available /= a_is_available then
				last_is_available := a_is_available
				update_account_menu
			end
		end

	on_account_signed_in (acc: ES_ACCOUNT)
		do
			debug ("es_cloud")
				print (generator + ".on_account_signed_in (" + acc.username + ")%N")
			end
			on_account_changed (acc)
			start_background_pinging (acc)
		end

	on_account_license_issue (a_issue: ES_ACCOUNT_LICENSE_ISSUE)
		local
			dlg: ES_CLOUD_LICENSE_ISSUE_DIALOG
			w: detachable EB_DEVELOPMENT_WINDOW
		do
			debug ("es_cloud")
				print (generator + ".on_account_license_issue (" + a_issue.account.username + ")%N")
			end
			stop_background_pinging

			dlg := last_license_issue_dialog
			if dlg /= Void and dlg.is_destroyed then
				dlg := Void
				last_license_issue_dialog := Void
			end

			if dlg = void and then attached es_cloud_s.service as l_cloud_service then
				create dlg.make (l_cloud_service)
				last_license_issue_dialog := dlg
			end
			if dlg /= Void then
				dlg.set_issue (a_issue)
				w := window_manager.last_focused_development_window
				if
					w = Void and then
					attached window_manager.development_windows as win_lst and then
					not win_lst.is_empty
				then
					w := win_lst.first
				end
				if w /= Void then
					dlg.show_modal_to_window (w.window)
--					dlg.show_relative_to_window (w.window)
				else
					dlg.show
				end
			end
		end

	last_license_issue_dialog: detachable ES_CLOUD_LICENSE_ISSUE_DIALOG

	on_account_signed_out (a_previous_acc: detachable ES_ACCOUNT)
		do
			stop_background_pinging
			on_account_changed (Void)
		end

	on_account_updated (acc: detachable ES_ACCOUNT)
		do
			debug ("es_cloud")
				print (generator + ".on_account_updated (" + acc.username + ")%N")
			end

			on_account_changed (acc)
		end

	on_session_state_changed (sess: ES_ACCOUNT_SESSION)
		local
			dlg: ES_CLOUD_PAUSE_DIALOG
			w: detachable EB_DEVELOPMENT_WINDOW
		do
			if attached es_cloud_s.service as l_cloud_service then
				if sess.is_paused then
					create dlg.make (l_cloud_service)
					w := window_manager.last_focused_development_window
					if
						w = Void and then
						attached window_manager.development_windows as win_lst and then
						not win_lst.is_empty
					then
						w := win_lst.first
					end
					if w /= Void then
						dlg.show_modal_to_window (w.window)
--						dlg.show_relative_to_window (w.window)
					else
						dlg.show
					end
				end
			end
		end

	on_session_heartbeat_updated (a_new_hearbeat: NATURAL_32)
			-- New hearbeat in seconds.
		do
			ping_heartbeat := a_new_hearbeat
			if attached ping_timeout as t then
				t.set_interval (a_new_hearbeat.to_integer_32 * 1_000) -- converted to milliseconds
			end
		end

feature -- Callbacks		

	on_account_changed (acc: detachable ES_ACCOUNT)
		do
			update_account_menu
		end

feature -- Operations

	update_account_menu
		local
			w: EB_DEVELOPMENT_WINDOW
		do
			if attached window_manager.development_windows as win_lst then
				across
					win_lst as ic
				loop
					w := ic.item
					w.tools.cloud_account_tool.update
					if attached w.show_cloud_account_cmd as cmd then
						cmd.refresh
					end
				end
			end
		end

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
