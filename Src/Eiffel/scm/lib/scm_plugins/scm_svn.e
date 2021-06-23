note
	description: "Summary description for {SCM_SVN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_SVN

inherit
	SCM

create
	make

feature -- Status report

	is_available: BOOLEAN
			-- Is Current available according the `config` value?
		local
			scm: like new_scm_engine
		do
			scm := new_scm_engine
			if attached scm.version as v then
				Result := True
			end
		end

feature -- Factory

	new_scm_engine: SVN_ENGINE
		do
			if attached config.svn_command as l_svn_cmd then
				create Result.make_with_executable_path (l_svn_cmd)
			else
				create Result
			end
		end

feature -- Access: working copy

	statuses (a_path: PATH; is_recursive: BOOLEAN; a_options: detachable SCM_OPTIONS): detachable SCM_STATUS_LIST
			-- Statuses of nodes under `a_path'.	
			-- Also process subfolders is `is_recursive' is True.
		local
			svn: like new_scm_engine
			opts: detachable SVN_OPTIONS
			st: SVN_STATUS_INFO
			p: PATH
		do
			svn := new_scm_engine
			if attached svn.statuses (a_path.name, False, is_recursive, False, opts) as l_statuses then
				create Result.make (l_statuses.count)
				across
					l_statuses as ic
				loop
					st := ic.item
					create p.make_from_string (st.path)
					if st.wc_status_code = st.status_modified then
						Result.force (create {SCM_STATUS_MODIFIED}.make (p))
					elseif st.wc_status_code = st.status_added then
						Result.force (create {SCM_STATUS_ADDED}.make (p))
					elseif st.wc_status_code = st.status_deleted then
						Result.force (create {SCM_STATUS_DELETED}.make (p))
					elseif st.wc_status_code = st.status_conflict then
						Result.force (create {SCM_STATUS_CONFLICTED}.make (p))
					elseif st.wc_status_code = st.status_unknown then
						Result.force (create {SCM_STATUS_UNVERSIONED}.make (p))
					end
				end
			end
		end

feature -- Operations: working copy

	update (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Update working copy at `a_changelist', and return information about command execution.
		local
			svn: like new_scm_engine
			l_changelist: SVN_CHANGELIST
			opts: detachable SVN_OPTIONS
			s: STRING_32
		do
			svn := new_scm_engine

			create l_changelist.make
			across
				a_changelist as ic
			loop
				l_changelist.extend (ic.item.location.name)
			end
			if a_options /= Void then
				create opts
				create s.make_empty
				if a_options.is_simulation then
					s.append_string_general (" --dry-run ")
				end
				across
					a_options.parameters as ic
				loop
					s.append_string_general (" ")
					s.append_string (ic.item)
					s.append_string_general (" ")
				end
				opts.set_parameters (s)
			end
			if attached {SVN_RESULT} svn.update (l_changelist, Void, opts) as res then
				if res.succeed then
					create Result.make_success
					Result.set_message (res.message)
				else
					create Result.make_failure
					Result.set_message (res.message)
				end
				Result.set_command (res.command)
			else
				create Result.make_failure
				Result.set_message ("Error: can not launch svn to process the update")
			end
		end

	add (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Add items from `a_changelist', and return information about command execution.
		local
			svn: like new_scm_engine
			l_changelist: SVN_CHANGELIST
			opts: detachable SVN_OPTIONS
			s: STRING_32
		do
			svn := new_scm_engine

			create l_changelist.make
			across
				a_changelist as ic
			loop
				if
					attached {SCM_STATUS_UNVERSIONED} ic.item
					or attached {SCM_STATUS_UNKNOWN} ic.item
				then
					l_changelist.extend_path (ic.item.location)
				end
			end
			if a_options /= Void then
				create opts
				create s.make_empty
				if a_options.is_simulation then
					s.append_string_general (" --dry-run ")
				end
				across
					a_options.parameters as ic
				loop
					s.append_string_general (" ")
					s.append_string (ic.item)
					s.append_string_general (" ")
				end
				opts.set_parameters (s)
			end
			if attached {SVN_RESULT} svn.add (l_changelist, opts) as res then
				if res.succeed then
					create Result.make_success
					Result.set_message (res.message)
				else
					create Result.make_failure
					Result.set_message (res.message)
				end
				Result.set_command (res.command)
			else
				create Result.make_failure
				Result.set_message ("Error: can not launch svn to process the add operation")
			end
		end

	delete (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Delete items from `a_changelist', and return information about command execution.
		local
			svn: like new_scm_engine
			l_changelist: SVN_CHANGELIST
			opts: detachable SVN_OPTIONS
			s: STRING_32
		do
			svn := new_scm_engine

			create l_changelist.make
			across
				a_changelist as ic
			loop
				if
					attached {SCM_STATUS_UNVERSIONED} ic.item
					or attached {SCM_STATUS_UNKNOWN} ic.item
				then
					l_changelist.extend_path (ic.item.location)
				end
			end
			if a_options /= Void then
				create opts
				create s.make_empty
				if a_options.is_simulation then
					s.append_string_general (" --dry-run ")
				end
				across
					a_options.parameters as ic
				loop
					s.append_string_general (" ")
					s.append_string (ic.item)
					s.append_string_general (" ")
				end
				opts.set_parameters (s)
			end
			if attached {SVN_RESULT} svn.delete (l_changelist, opts) as res then
				if res.succeed then
					create Result.make_success
					Result.set_message (res.message)
				else
					create Result.make_failure
					Result.set_message (res.message)
				end
				Result.set_command (res.command)
			else
				create Result.make_failure
				Result.set_message ("Error: can not launch svn to process the delete operation")
			end
		end

	move (a_location, a_new_location: READABLE_STRING_GENERAL; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Move from `a_location' to `a_new_location', and return information about command execution.
		do
			create Result.make_failure
			Result.set_message ("Error: not yet implemented")
		end

	commit (a_changelist: SCM_CHANGELIST; a_log_message: detachable READABLE_STRING_GENERAL; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Commit changes for locations `a_changelist', and return information about command execution.
		local
			svn: like new_scm_engine
			l_changelist: SVN_CHANGELIST
			opts: detachable SVN_OPTIONS
			s: STRING_32
		do
			svn := new_scm_engine

			create l_changelist.make
			across
				a_changelist as ic
			loop
				l_changelist.extend (ic.item.location.name)
			end
			if a_options /= Void then
				create opts
				create s.make_empty
				if a_options.is_simulation then
					s.append_string_general (" --dry-run ")
				end
				across
					a_options.parameters as ic
				loop
					s.append_string_general (" ")
					s.append_string (ic.item)
					s.append_string_general (" ")
				end
				opts.set_parameters (s)
			end
			if attached {SVN_RESULT} svn.commit (l_changelist, a_log_message, opts) as res then
				if res.succeed then
					create Result.make_success
					Result.set_message (res.message)
				else
					create Result.make_failure
					Result.set_message (res.message)
				end
				Result.set_command (res.command)
			else
				create Result.make_failure
				Result.set_message ("Error: can not launch svn to process the commit")
			end
		end

feature -- Access

	logs (a_location: READABLE_STRING_GENERAL; is_verbose: BOOLEAN; a_limit: INTEGER; a_options: detachable SCM_OPTIONS): detachable LIST [SCM_COMMIT_LOG]
			-- Logs for `a_location' between `a_start' and `a_end' if provided, with a limit of `a_limit' entries.
		do
		end

	revert (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Difference for `a_location', between `a_start' and `a_end' if provided.
		local
			svn: like new_scm_engine
			opts: detachable SVN_OPTIONS
			l_changelist: SVN_CHANGELIST
			s: STRING_32
		do
			svn := new_scm_engine

			create l_changelist.make
			across
				a_changelist as ic
			loop
				l_changelist.extend (ic.item.location.name)
			end
			if a_options /= Void then
				create opts
				create s.make_empty
				if a_options.is_simulation then
					s.append_string_general (" --dry-run ")
				end
				across
					a_options.parameters as ic
				loop
					s.append_string_general (" ")
					s.append_string (ic.item)
					s.append_string_general (" ")
				end
				opts.set_parameters (s)
			end
			if attached {SVN_RESULT} svn.revert (l_changelist, opts) as res then
				if res.succeed then
					create Result.make_success
					Result.set_message (res.message)
				else
					create Result.make_failure
					Result.set_message (res.message)
				end
				Result.set_command (res.command)
			else
				create Result.make_failure
				Result.set_message ("Error: can not launch svn to process the commit")
			end
		end

	diff (a_location: READABLE_STRING_GENERAL; a_options: detachable SCM_OPTIONS): detachable STRING_32
			-- Difference for `a_location', between `a_start' and `a_end' if provided.
		local
			svn: like new_scm_engine
			opts: detachable SVN_OPTIONS
			utf: UTF_CONVERTER
		do
			svn := new_scm_engine
			if attached svn.diff (a_location, Void, Void, opts) as l_diff then
				Result := utf.utf_8_string_8_to_string_32 (l_diff)
			end
		end

	content (a_location: READABLE_STRING_GENERAL; a_ref: detachable SCM_COMMIT_REFERENCE; a_options: detachable SCM_OPTIONS): detachable STRING
			-- Content of `a_location', for commit related to `a_ref' if provided.
		do
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
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
end
