note
	description: "[
		Problem report controller
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	PROBLEM_REPORT_CONTROLLER

inherit
	XWA_CONTROLLER

	G_SHARED_SUPPORT_GLOBAL_STATE
		undefine
			default_create
		end

create
	make

feature -- Initialization

	make
		do
			default_create
			create internal_priority_list.make (3)
			create internal_category_list.make (4)
			create internal_confidential_list.make (2)
			internal_confidential_list.extend ("Yes")
			internal_confidential_list.extend ("No")
			create internal_class_list.make (5)
			create internal_severity_list.make (3)
			create responsibles.make (3)
		end

feature -- Basic Functionality

	internal_priority_list: ARRAYED_LIST [STRING]
	internal_category_list: ARRAYED_LIST [STRING]
	internal_confidential_list: ARRAYED_LIST [STRING]
	internal_class_list: ARRAYED_LIST [STRING]
	internal_severity_list: ARRAYED_LIST [STRING]
	responsibles: ARRAYED_LIST [STRING]

	save (a_problem_report: ANY)
		do
			if attached {PROBLEM_REPORT_BEAN} a_problem_report as problem_report then
				print ("Success: " + problem_report.out)
			else
				print (a_problem_report)
			end
		end

	priority_list: LIST [STRING]
		do
			Result := global_state.persistence.priorities
		end

	category_list: LIST [STRING]
		do
			Result := global_state.persistence.categories
		end

	confidential_list: LIST [STRING]
		do
			Result := internal_confidential_list
		end

	e_class_list: LIST [STRING]
		do
			Result := global_state.persistence.classes
		end

	severity_list: LIST [STRING]
		do
			Result := global_state.persistence.severities
		end

	environment_info: STRING
		do
			if attached current_request.headers_in ["User-Agent"] as l_user_agent then
				Result := l_user_agent
			else
				Result := ""
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
