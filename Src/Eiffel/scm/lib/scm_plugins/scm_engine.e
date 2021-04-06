note
	description: "Summary description for {SCM_ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_ENGINE

inherit
	SCM

feature -- Access: working copy

	statuses (a_path: PATH; is_recursive: BOOLEAN; a_options: detachable SCM_OPTIONS): detachable SCM_STATUS_LIST			-- Statuses of nodes under `a_path'.	
			-- Also process subfolders is `is_recursive' is True.
		do
		end

feature -- Operations: working copy

	update (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Update working copy at `a_changelist', and return information about command execution.
		do
			create Result.make_failure
		end

	add (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Add items from `a_changelist', and return information about command execution.
		do
			create Result.make_failure
		end

	delete (a_changelist: SCM_CHANGELIST; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Delete items from `a_changelist', and return information about command execution.
		do
			create Result.make_failure
		end

	move (a_location, a_new_location: READABLE_STRING_GENERAL; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Move from `a_location' to `a_new_location', and return information about command execution.
		do
			create Result.make_failure
		end

	commit (a_changelist: SCM_CHANGELIST; a_log_message: detachable READABLE_STRING_GENERAL; a_options: detachable SCM_OPTIONS): SCM_RESULT
			-- Commit changes for locations `a_changelist', and return information about command execution.
		do
			create Result.make_failure
		end

feature -- Access

	logs (a_location: READABLE_STRING_GENERAL; is_verbose: BOOLEAN; a_limit: INTEGER; a_options: detachable SCM_OPTIONS): detachable LIST [SCM_COMMIT_LOG]
			-- Logs for `a_location' between `a_start' and `a_end' if provided, with a limit of `a_limit' entries.
		do
		end

	diff (a_location: READABLE_STRING_GENERAL; a_options: detachable SCM_OPTIONS): detachable STRING
			-- Difference for `a_location', between `a_start' and `a_end' if provided.
		do
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
