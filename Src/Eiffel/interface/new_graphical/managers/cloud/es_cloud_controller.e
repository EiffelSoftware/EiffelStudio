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
			on_account_logged_in,
			on_account_logged_out,
			on_account_updated,
			on_cloud_available,
			on_session_state_changed
		end

	SHARED_ES_CLOUD_SERVICE

	EB_SHARED_WINDOW_MANAGER

feature {NONE} -- Background ping

	timeout: detachable EV_TIMEOUT

	start_background_pinging (acc: ES_ACCOUNT)
		local
			t: EV_TIMEOUT
		do
			process_ping (acc)

			t := timeout
			if t /= Void then
				t.destroy
			end
			create t
			t.actions.extend (agent process_ping (acc))
			t.set_interval (ping_delay)
			timeout := t
		end

	stop_background_pinging
		do
			if attached timeout as t then
				t.destroy
				timeout := t
			end
		end

	ping_delay: INTEGER = 900_000 -- 15 * 60 * 1000 ms = 15 minutes
--	ping_delay: INTEGER = 300_000 -- 5 * 60 * 1000 ms = 5 minutes
--	ping_delay: INTEGER = 30_000 -- 30 * 1000 ms = 30 sec		

	process_ping (acc: ES_ACCOUNT)
		do
			if
				attached es_cloud_s.service as cld and then
				attached cld.active_session as sess and then
				not sess.is_paused
			then
				cld.async_ping_installation (acc, sess)
			end
		end

feature -- Events

	on_cloud_available (a_is_available: BOOLEAN)
		do
			update_account_menu
		end

	on_account_logged_in (acc: ES_ACCOUNT)
		do
			on_account_changed (acc)
			start_background_pinging (acc)
		end

	on_account_logged_out
		do
			stop_background_pinging
			on_account_changed (Void)
		end

	on_account_updated (acc: detachable ES_ACCOUNT)
		do
			on_account_changed (acc)
		end

	on_session_state_changed (sess: ES_ACCOUNT_SESSION)
		local
			dlg: ES_CLOUD_PAUSE_DIALOG
			w: detachable EB_DEVELOPMENT_WINDOW
		do
			if attached es_cloud_s.service as l_cloud_service then
				if sess.is_paused then
					create dlg.make (l_cloud_service, "PAUSED!!!!!")
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
					w.menus.cloud_account_menu.update
					w.tools.cloud_account_tool.update
				end
			end
		end

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
