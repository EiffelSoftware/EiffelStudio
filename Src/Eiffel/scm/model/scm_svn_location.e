note
	description: "Summary description for {SCM_SVN_LOCATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_SVN_LOCATION

inherit
	SCM_LOCATION

create
	make

feature -- Access

	nature: STRING = "SVN"

feature -- Execution	

	changes (loc: PATH): detachable SCM_STATUS_LIST
		local
			scm: SCM
		do
			reset_error
			create {SCM_SVN} scm
			Result := scm.statuses (loc, True, Void)
		end

	commit (a_commit_set: SCM_SINGLE_COMMIT_SET)
		local
			scm: SCM
			opts: SCM_OPTIONS
			res: SCM_RESULT
		do
			reset_error
			create {SCM_SVN} scm
			create opts

			if attached a_commit_set.message as m then
				res := scm.commit (a_commit_set.changelist, m, opts)
				if res.succeed then
					a_commit_set.report_success (res.message)
				else
					a_commit_set.report_error (res.message)
					has_error := True
				end
			else
				has_error := True
				check is_ready: False end
				a_commit_set.report_error ("commit is not ready, message is missing")
			end
		end
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
