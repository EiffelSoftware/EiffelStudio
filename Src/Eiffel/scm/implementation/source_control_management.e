note
	description: "Summary description for {SOURCE_CONTROL_MANAGEMENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	SOURCE_CONTROL_MANAGEMENT

inherit
	SOURCE_CONTROL_MANAGEMENT_S

	DISPOSABLE_SAFE

	EIFFEL_LAYOUT

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Creation

	make (cfg: SCM_CONFIG)
		do
			config := cfg

			eiffel_project.manager.compile_stop_agents.extend (agent on_project_recompiled)
		end

feature {NONE} -- Default

	config_filename: detachable PATH
		do
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

feature -- Access

	config: SCM_CONFIG

	workspace: detachable SCM_WORKSPACE
		do
			Result := internal_workspace
			if Result = Void then
				if
					attached eiffel_project.workbench.lace as l_lace and then
					attached l_lace.target as tgt
				then
					create Result.make_with_target (tgt)
					internal_workspace := Result
					Result.analyze
				end
			end
		end

feature -- Operations

	commit_and_push (a_commit: SCM_COMMIT_SET)
		local
			l_single_commit: SCM_SINGLE_COMMIT_SET
			retried: BOOLEAN
		do
			if retried then
				a_commit.report_error ("Exception raised ...") -- FIXME: provide more informations.
			else
				a_commit.reset
				if attached {SCM_SINGLE_COMMIT_SET} a_commit as l_single then
					if attached {SCM_SVN_LOCATION} l_single.changelist.root as l_svn_loc then
						l_svn_loc.commit (l_single, config)
					elseif attached {SCM_GIT_LOCATION} l_single.changelist.root as l_git_loc then
						l_git_loc.commit (l_single, config)
					end
				elseif attached {SCM_MULTI_COMMIT_SET} a_commit as l_multi then
					across
						l_multi.changelists as ic
					loop
						create l_single_commit.make_with_changelist (a_commit.message, ic.item)
						commit_and_push (l_single_commit)
						if l_single_commit.is_processed then
							if l_single_commit.has_error then
								a_commit.report_error (l_single_commit.execution_message)
							else
								a_commit.report_success (l_single_commit.execution_message)
							end
						end
					end
				else
					a_commit.report_error (a_commit.generator + ": not supported%N") -- FIXME
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Access: internals

	internal_workspace: detachable like workspace

feature -- Element change

	set_workspace (ws: like workspace)
		do
			internal_workspace := ws
			on_workspace_updated (ws)
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is account service available?

	is_svn_available: BOOLEAN
			-- Is svn available?

	is_git_available: BOOLEAN
			-- Is git available?

	check_scm_availability
		do
			is_available := True
			is_git_available := (create {SCM_GIT}.make (config)).is_available
			is_svn_available := (create {SCM_SVN}.make (config)).is_available
		end

feature -- Events

	on_project_recompiled
		local
			ws: like workspace
		do
			if attached eiffel_project.workbench.lace.target as tgt then
				create ws.make_with_target (tgt)
			end
			set_workspace (ws)
		end

feature -- Events: Connection point

	scm_connection: EVENT_CONNECTION_I [SCM_OBSERVER, SOURCE_CONTROL_MANAGEMENT_S]
			-- <Precursor>
		do
			Result := internal_connection
			if not attached Result then
				create {EVENT_CONNECTION [SCM_OBSERVER, SOURCE_CONTROL_MANAGEMENT_S]} Result.make (
					agent (o: SCM_OBSERVER):
						ARRAY [TUPLE
							[event: EVENT_TYPE [TUPLE];
							action: PROCEDURE]
						]
						do
							Result :=
								<<
									[workspace_updated_event, agent o.on_workspace_updated],
									[change_detected_event, agent o.on_change_detected]
								>>
						end)
				automation.auto_dispose (Result)
				internal_connection := Result
			end
		end

feature -- Events

	workspace_updated_event: EVENT_TYPE [TUPLE [ws: detachable SCM_WORKSPACE]]
			-- <Precursor>
		do
			Result := internal_workspace_updated_event
			if Result = Void then
				create Result
				internal_workspace_updated_event := Result
				auto_dispose (Result)
			end
		end

	change_detected_event: EVENT_TYPE [TUPLE [ch: detachable SCM_CHANGE]]
			-- <Precursor>
		do
			Result := internal_change_detected_event
			if Result = Void then
				create Result
				internal_change_detected_event := Result
				auto_dispose (Result)
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_connection: detachable like scm_connection
			-- Cached version of `es_cloud_connection`.
			-- Note: Do not use directly!	

	internal_workspace_updated_event: detachable like workspace_updated_event
			-- Cached version of `workspace_updated_event`.
			-- Note: Do not use directly!

	internal_change_detected_event: detachable like change_detected_event
			-- Cached version of `change_detected_event`.
			-- Note: Do not use directly!

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
