note
	description: "[
		Records containing a list of test names which have been created during a creation session.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CREATION_RECORD

inherit
	TEST_COMMON_SESSION_RECORD [DATE_TIME]
		rename
			has_item as has_date,
			has_item_for_test as has_date_for_test,
			item_for_name as date_for_name,
			item_for_test as date_for_test
		end

create {TEST_CREATION_I}
	make

feature {TEST_CREATION_I} -- Element change

	add_test (a_name: READABLE_STRING_8)
			-- Add name of newly created test and add it to end of `test_map'.
			--
			-- `a_name': Name of created test.
		require
			a_name_attached: a_name /= Void
			not_added_yet: not has_date (a_name)
		local
			l_repo: like repository
		do
			test_map.force_last (create {DATE_TIME}.make_now, a_name)
			if is_attached then
				repository.report_record_update (Current)
			end
		ensure
			has_date: has_date (a_name)
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
