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

	changelists: STRING_TABLE [SCM_CHANGELIST_COLLECTION]
		deferred
		end

	create_new_changelist (a_name: READABLE_STRING_GENERAL)
		deferred
		ensure
			changelists.count > 0
		end

feature -- Status

	file_status (a_path: PATH): detachable SCM_STATUS
			-- SCM status of `a_path`
			-- Result can be Modified, Deleted, Added, Unversioned, ...
		deferred
		end

	scm_root_location (a_path: PATH): detachable SCM_LOCATION
			-- SCM location containing `a_path`, if any.
		deferred
		end

feature -- Operations

	update_statuses
			-- Update statuses for all known SCM locations, i.e for the workspace
		deferred
		end

	statuses (a_root: SCM_LOCATION; a_location: PATH): detachable SCM_STATUS_LIST
		do
			Result := a_root.changes (a_location, config)
		end

	commit (a_commit: SCM_COMMIT_SET)
		require
			is_ready: a_commit.is_ready
		deferred
		end

	post_commit_operations (a_commit: SCM_COMMIT_SET): detachable LIST [SCM_POST_COMMIT_OPERATION]
		require
			is_processed: a_commit.is_processed
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

	diff_at_location (a_path: PATH): detachable SCM_DIFF
		local
			l_changelist: SCM_CHANGELIST
		do
			if attached scm_root_location (a_path) as loc then
				create l_changelist.make_with_location (loc)
				l_changelist.extend_path (a_path)
				Result := diff (l_changelist)
			end
		end

feature -- Cache

	cached_statuses (a_location: PATH): detachable SCM_STATUS_LIST
			-- Status list for `a_location` from cache, if any.
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

	on_statuses_updated (a_root: SCM_LOCATION; a_location: PATH; a_statuses: detachable SCM_STATUS_LIST)
		do
			debug ("scm")
				print (generator + ".on_statuses_updated (...)%N")
			end
			if statuses_updated_event.is_interface_usable then
				statuses_updated_event.publish ([a_root, a_location, a_statuses])
			end
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_statuses_updated (a_root, a_location, a_statuses)
				end
			end
		end

	on_changelist_updated (ch: SCM_CHANGELIST_COLLECTION)
		do
			debug ("scm")
				print (generator + ".on_changelist_updated (" + ch.name + ")%N")
			end
			if attached observers as lst then
				across
					lst as ic
				loop
					ic.item.on_changelist_updated (ch)
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

	statuses_updated_event: EVENT_TYPE [TUPLE [root: SCM_LOCATION; location: PATH; statuses: SCM_STATUS_LIST]]
			-- Events called when scm location statuses are updated.
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
