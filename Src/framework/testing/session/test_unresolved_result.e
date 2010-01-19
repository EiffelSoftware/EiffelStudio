note
	description: "[
		Implementation of a {TEST_RESULT_I} representing an unresolved outcome where tag and details are
		provided directly through strings.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_UNRESOLVED_RESULT

inherit
	TEST_RESULT

	SHARED_LOCALE

create
	make

feature {NONE} -- Initialization

	make (a_tag, a_details: like tag)
			-- Initialize `Current'.
			--
			-- `a_tag': Tag describing state.
			-- `a_details': Detailed information about `Current'
		do
			create start_date.make_now
			create {IMMUTABLE_STRING_8} tag.make_from_string (a_tag)
			create {IMMUTABLE_STRING_8} details.make_from_string (a_details)
		end

feature -- Access

	start_date: DATE_TIME
			-- <Precursor>

	finish_date: DATE_TIME
			-- <Precursor>
		do
			Result := start_date
		end

	tag: READABLE_STRING_8
			-- <Precursor>
			--
			-- Note: before printing the tag will first be translated through `locale'

	details: READABLE_STRING_8
			-- Detailed information about `Current'
			--
			-- Note: before printing the tag will first be translated through `locale'

feature -- Status report

	is_pass: BOOLEAN = False
			-- <Precursor>

	is_fail: BOOLEAN = False
			-- <Precursor>

feature -- Basic operations

	print_details_indented (a_formatter: TEXT_FORMATTER; a_verbose: BOOLEAN; an_indent: NATURAL_32)
			-- <Precursor>
		do

		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
