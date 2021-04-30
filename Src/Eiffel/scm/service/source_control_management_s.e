note
	description: "Summary description for the Source Control Management service. "
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SOURCE_CONTROL_MANAGEMENT_S

inherit
	SERVICE_I

feature -- Status report

	is_available: BOOLEAN
			-- Is SCM service available?
		deferred
		end

	is_svn_available: BOOLEAN
		deferred
		end

	is_git_available: BOOLEAN
		deferred
		end

feature -- Access

	config: SCM_CONFIG
		deferred
		end

	check_scm_availability
		deferred
		end

	workspace: detachable SCM_WORKSPACE
		deferred
		end

feature -- Operations

	commit (a_commit: SCM_COMMIT_SET)
		require
			is_ready: a_commit.is_ready
		deferred
		end

	update (a_changelist: SCM_CHANGELIST): detachable STRING_32
		deferred
		end

	revert (a_changelist: SCM_CHANGELIST): detachable STRING_32
		deferred
		end

	diff (a_changelist: SCM_CHANGELIST): detachable SCM_DIFF
		deferred
		end

feature -- Events

	on_workspace_updated (ws: detachable SCM_WORKSPACE)
		do
			debug ("scm")
				print (generator + ".on_workspace_updated (" + ws.out + ")%N")
			end
			if ws /= Void then
				ws.analyze
			end
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_workspace_updated (ws)
				end
			end
		end

	on_change_detected (ch: SCM_CHANGE)
		do
			debug ("scm")
				print (generator + ".on_change_detected (" + ch.out + ")%N")
			end
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_change_detected (ch)
				end
			end
		end

	on_configuration_updated (cfg: SCM_CONFIG)
		do
			debug ("scm")
				print (generator + ".on_configuration_updated (" + cfg.out + ")%N")
			end
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_configuration_updated (cfg)
				end
			end
		end

feature -- Observer

	register_observer (obs: SCM_OBSERVER)
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

	unregister_observer (obs: SCM_OBSERVER)
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

	scm_connection: EVENT_CONNECTION_I [SCM_OBSERVER, SOURCE_CONTROL_MANAGEMENT_S]
			-- Connection point.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
		end

feature -- Events

	change_detected_event: EVENT_TYPE [TUPLE [acc: detachable SCM_CHANGE]]
			-- Events called when an change is detected.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	workspace_updated_event: EVENT_TYPE [TUPLE [ws: SCM_WORKSPACE]]
			-- Events called when the scm workspace is updated.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature {NONE} -- Implementation

	observers: detachable ARRAYED_LIST [SCM_OBSERVER]

invariant

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
