note
	description: "Summary description for {ES_UPDATE_CHECKER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_RELEASE_UPDATE_CHECKER

inherit
	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Initialization

	make (a_channel: READABLE_STRING_8; a_platform: READABLE_STRING_8; a_curr_version_name: READABLE_STRING_8)
		do
			create channel.make_from_string (a_channel)
			create platform.make_from_string (a_platform)
			create version.make_from_string (a_curr_version_name)
		end

feature -- Access

	channel: IMMUTABLE_STRING_8
	platform: IMMUTABLE_STRING_8
	version: IMMUTABLE_STRING_8

	available_release: detachable ES_UPDATE_RELEASE

feature -- Execution

	check_for_update (a_cb: PROCEDURE [detachable ES_UPDATE_RELEASE])
		local
			update_manager_api: ES_UPDATE_MANAGER
		do
			available_release := Void
			if {ES_GRAPHIC}.is_standard_edition then
				create update_manager_api.make (create {ES_UPDATE_CLIENT_CONFIGURATION}.make ({ES_UPDATE_CONSTANTS}.update_service_url))
				available_release := update_manager_api.available_release_update_for_channel (
											channel, platform, version)
			end
			a_cb.call ([available_release])
		end

	async_check_for_update (a_cb: PROCEDURE [detachable ES_UPDATE_RELEASE])
		local
			wt: WORKER_THREAD
			m: MUTEX
		do
			if {ES_GRAPHIC}.is_standard_edition then
				available_release := Void
				completed := False
				create m.make
				create wt.make (agent async_check_for_update_imp (m))
				ev_application.add_idle_action_kamikaze (agent check_for_completion (a_cb, m))
				wt.launch
			else
				available_release := Void
				completed := True
				a_cb.call ([available_release])
			end
		end

	async_check_for_update_imp (a_mutex: MUTEX)
		require
			is_standard_edition: {ES_GRAPHIC}.is_standard_edition
		local
			update_manager_api: ES_UPDATE_MANAGER
			rel: like available_release
			ch: like channel
			pl: like platform
			v: like version
		do
			a_mutex.lock
			ch := channel.twin
			pl := platform.twin
			v := version.twin
			a_mutex.unlock;
			create update_manager_api.make (create {ES_UPDATE_CLIENT_CONFIGURATION}.make ({ES_UPDATE_CONSTANTS}.update_service_url))
			rel := update_manager_api.available_release_update_for_channel (ch, pl, v)
			a_mutex.lock
			available_release := rel
			completed := True
			a_mutex.unlock
		end

feature {NONE} -- Implementation: Async

	completed: BOOLEAN

	timeout: detachable EV_TIMEOUT

	check_for_completion (cb: PROCEDURE [detachable ES_UPDATE_RELEASE]; a_mutex: MUTEX)
		local
			t: EV_TIMEOUT
		do
			create t
			timeout := t
			t.actions.extend (agent (i_cb: PROCEDURE [detachable ES_UPDATE_RELEASE]; i_t: EV_TIMEOUT; i_m: MUTEX)
					local
						b: BOOLEAN
						rel: like available_release
					do
						i_m.lock
						b := completed
						rel := available_release
						i_m.unlock
						if b then
							i_t.destroy
							timeout := Void
							i_cb.call ([rel])
						else
								-- continue timeout
						end
					end(cb, t, a_mutex)
				)
				t.set_interval (500) -- interval in milliseconds)
		end

invariant

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
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
