note
	description: "[
		Problem report query
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	PROBLEM_REPORT_QUERY

inherit
	ANY
		redefine
			out
		end

create
	make

feature -- Initialization

	make
		do
			priority := ""
			page_size := "20"
			severity := ""
			responsible := ""
			category := ""
			submitter := ""
			open := False
		end

feature -- Access

	open: BOOLEAN assign set_open

	set_open (a_open: BOOLEAN)
		do
			open := a_open
		end

	submitter: STRING assign set_submitter

	set_submitter (a_submitter: STRING)
		do
			submitter := a_submitter
		end

	category: STRING assign set_category

	set_category (a_category: STRING)
		do
			category := a_category
		end

	responsible: STRING assign set_responsible

	set_responsible (a_responsible: STRING)
		do
			responsible := a_responsible
		end

	priority: STRING assign set_priority

	set_priority (a_priority: STRING)
		do
			priority := a_priority
		end

	page_size: STRING assign set_page_size

	set_page_size (a_page_size: STRING)
		do
			page_size := a_page_size
		end

	severity: STRING assign set_severity

	set_severity (a_severity: STRING)
		do
			severity := a_severity
		end

	out: STRING
		do
			Result := "PROBLEM_REPORT_QUERY"
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
