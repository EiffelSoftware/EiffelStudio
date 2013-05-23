note
	description: "Summary description for {IRON_REPO_CONTROLLER_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_REPO_CONTROLLER_TASK

feature -- Access

	name: READABLE_STRING_8
		deferred
		end

	arguments: detachable ARRAY [IMMUTABLE_STRING_32]

feature -- Change

	set_arguments (args: like arguments)
		local
			l_arguments: like arguments
		do
			if args /= Void and then not args.is_empty then
				create l_arguments.make_from_array (args)
				l_arguments.rebase (1)
				arguments := l_arguments
			else
				arguments := Void
			end
		end

feature -- Status report

	is_available (iron: IRON_REPO): BOOLEAN
		deferred
		end

feature -- Execution

	execute (iron: IRON_REPO)
		require
			is_available: is_available (iron)
		deferred
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
