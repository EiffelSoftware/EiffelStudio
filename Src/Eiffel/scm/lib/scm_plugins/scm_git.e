note
	description: "Summary description for {SCM_GIT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_GIT

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

	new_scm_engine: GIT_ENGINE
		do
			if attached config.git_command as l_git_cmd then
				create Result.make_with_executable_path (l_git_cmd)
			else
				create Result
			end
		end

feature -- Access: working copy

	statuses (a_root_location, a_path: PATH; is_recursive: BOOLEAN; a_options: detachable SCM_OPTIONS): detachable SCM_STATUS_LIST
			-- Statuses of nodes under `a_path'.	
			-- Also process subfolders is `is_recursive' is True.
		local
			git: like new_scm_engine
		do
			git := new_scm_engine
			Result := git.statuses (a_root_location, a_path, is_recursive, a_options)
		end

	remotes (a_root_location: PATH; a_options: detachable SCM_OPTIONS): detachable STRING_TABLE [GIT_REMOTE]
			-- Remotes repository for `a_root_location'.	
		local
			git: like new_scm_engine
		do
			git := new_scm_engine
			Result := git.remotes (a_root_location, a_options)
		end

	branches (a_root_location: PATH; a_show_all: BOOLEAN; a_options: detachable SCM_OPTIONS): detachable STRING_TABLE [GIT_BRANCH]
			-- Branches for `a_root_location'.
			-- if `a_show_all` is True, include remote branches.
		local
			git: like new_scm_engine
		do
			git := new_scm_engine
			Result := git.branches (a_root_location, a_show_all, a_options)
		end

feature -- Operations: working copy

	revert (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Revert `a_location'.
		local
			git: like new_scm_engine
		do
			git := new_scm_engine
			Result := git.revert (a_changelist, a_options)
		end

	commit (a_changelist: SCM_CHANGELIST; a_log_message: READABLE_STRING_GENERAL; a_options: SCM_OPTIONS): SCM_RESULT
			-- Commit changes for locations `a_changelist', and return information about command execution.
		local
			git: like new_scm_engine
		do
			git := new_scm_engine
			Result := git.commit (a_changelist, a_log_message, a_options)
		end

	update (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Update working copy at `a_changelist', and return information about command execution.
		do
			create Result.make_failure (Void)
			Result.set_message ("Error: GIT [update] not yet supported")
		end

feature {NONE} -- Operations: not fully implemented by all descendants		

	add (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Add items from `a_changelist', and return information about command execution.
		do
			create Result.make_failure (Void)
			Result.set_message ("Error: [add] not yet implemented for GIT")
		end

	delete (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Delete items from `a_changelist', and return information about command execution.
		do
			create Result.make_failure (Void)
			Result.set_message ("Error: [delete] not yet implemented for GIT")
		end

	move (a_location, a_new_location: READABLE_STRING_GENERAL; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Move from `a_location' to `a_new_location', and return information about command execution.
		do
			create Result.make_failure (Void)
			Result.set_message ("Error: [move] not yet implemented for GIT")
		end

feature -- Access

	logs (a_location: READABLE_STRING_GENERAL; is_verbose: BOOLEAN; a_limit: INTEGER; a_options: detachable SCM_OPTIONS): detachable LIST [SCM_COMMIT_LOG]
			-- Logs for `a_location' between `a_start' and `a_end' if provided, with a limit of `a_limit' entries.
		do
			-- FIXME: to implement
		end

	diff (a_location: READABLE_STRING_GENERAL; a_options: detachable SCM_OPTIONS): detachable SCM_RESULT
			-- Difference for `a_location', between `a_start' and `a_end' if provided.
		local
			git: like new_scm_engine
		do
			git := new_scm_engine
			Result := git.diff (create {PATH}.make_from_string (a_location), a_options)
		end

	content (a_location: READABLE_STRING_GENERAL; a_ref: detachable SCM_COMMIT_REFERENCE; a_options: detachable SCM_OPTIONS): detachable STRING
			-- Content of `a_location', for commit related to `a_ref' if provided.
		do
			-- FIXME: to implement
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
