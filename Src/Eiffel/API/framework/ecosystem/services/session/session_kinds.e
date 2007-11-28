indexing
	description: "[
		Session kind-types for indentification of a session.
		See {SESSION_I} and {SESSION_MANAGER_S} for more information.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SESSION_KINDS

inherit
	ANY
		export
			{NONE} all
		end

feature -- Access

	frozen environment: UUID
			-- Environment (global) session
		once
			create Result.make_from_string (environment_uuid_string)
		ensure
			result_attached: Result /= Void
		end

	frozen window: UUID
			-- Environment window session
		once
			create Result.make_from_string (window_uuid_string)
		ensure
			result_attached: Result /= Void
		end

	frozen project: UUID
			-- Project (gloabl) session
		once
			create Result.make_from_string (project_uuid_string)
		ensure
			result_attached: Result /= Void
		end

	frozen project_window: UUID
			-- Project and environment window session
		once
			create Result.make_from_string (project_window_uuid_string)
		ensure
			result_attached: Result /= Void
		end

feature {SESSION_I} -- Constants

	environment_uuid_string: STRING = "E1FFE100-85DE-4BDD-B99B-DB1B4895DA6C"
			-- Environment (global) session string UUID

	window_uuid_string: STRING = "E1FFE101-B672-4D8D-BFAC-7E4467634C4A"
			-- Environment window session string UUID

	project_uuid_string: STRING = "E1FFE102-C7BE-472E-93EF-A7CD63EAD1B1"
			-- Project (gloabl) session string UUID

	project_window_uuid_string: STRING = "E1FFE103-CDE1-4AA1-95A7-E337BFD85C95"
			-- Project and environment window session string UUID

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
