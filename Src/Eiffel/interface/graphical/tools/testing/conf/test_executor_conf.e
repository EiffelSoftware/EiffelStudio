note
	description: "[
		Simple implementation of {TEST_EXECUTOR_CONF_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXECUTOR_CONF

inherit
	TEST_EXECUTOR_CONF_I

create
	make, make_with_tests

feature {NONE} -- Initialization

	make (a_dbg_conf: BOOLEAN)
			-- Initialize `Current'.
			--
			-- `a_dbg_conf': Will `Current' be used to launch a debugger executor?
		local
			l_preferences: EB_SHARED_PREFERENCES
			l_value: NATURAL
		do
			internal_tests := Void
			create sorter_prefix.make_empty
			create l_preferences
			if a_dbg_conf then
				evaluator_count := 1
			else
				l_value := l_preferences.preferences.testing_tool_data.evaluator_count.value.to_natural_32
				if l_value = 0 then
					l_value := 1
				elseif l_value > max_evaluator_count then
					l_value := max_evaluator_count
				end
				evaluator_count := l_value
			end
		ensure
			not_specific: not is_specific
			sorter_prefix_empty: sorter_prefix.is_empty
			dbg_conf_implies_valid_count: a_dbg_conf implies evaluator_count = 1
		end

	make_with_tests (a_list: like tests; a_dbg_conf: BOOLEAN)
			-- Initialize `Current' with specific tests.
			--
			-- `a_list': List of tests to be executed.
			-- `a_dbg_conf': Will `Current' be used to launch a debugger executor?
		do
			make (a_dbg_conf)
			create internal_tests.make_from_linear (a_list)
		ensure
			specific: is_specific
			tests_contains_a_list: a_list.for_all (agent internal_tests.has)
			dbg_conf_implies_valid_count: a_dbg_conf implies evaluator_count = 1
		end

feature -- Access

	tests: attached DS_LINEAR [attached TEST_I]
			-- <Precursor>
		local
			l_tests: like internal_tests
		do
			l_tests := internal_tests
			check l_tests /= Void end
			Result := l_tests
		end

	sorter_prefix: attached STRING
			-- <Precursor>

	evaluator_count: NATURAL
			-- <Precursor>

feature {NONE} -- Access

	internal_tests: detachable DS_ARRAYED_LIST [attached TEST_I]
			-- Internal storage for `tests'

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	is_specific: BOOLEAN
			-- <Precursor>
		do
			Result := internal_tests /= Void
		end

feature -- Status setting

	set_sorter_prefix (a_prefix: like sorter_prefix)
			--  Set `sorter_prefix' to `a_prefix'.
		require
			a_prefix_valid: (create {TAG_UTILITIES}).is_valid_tag (a_prefix)
		do
			create sorter_prefix.make_from_string (a_prefix)
		end

feature {NONE} -- Constants

	max_evaluator_count: NATURAL = 64
			-- Max value for `evaluator_count'

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
