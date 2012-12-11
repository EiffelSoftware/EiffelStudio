note
	description: "[
		Objects implementing {TEST_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST

inherit
	TEST_I
		redefine
			print_test
		end

	EXCEPTION_CODE_MEANING

	DISPOSABLE_SAFE

create {ETEST_CLASS_SYNCHRONIZER}
	make

feature {NONE} -- Initialization

	make (a_name: like routine_name; a_test_class: like test_class)
			-- Initialize `Current'
			--
			-- `a_name': Name of test routine.
			-- `a_test_class': Test class instance to which `Current' belongs.
		require
			a_name_attached: a_name /= Void
			a_test_class_attached: a_test_class /= Void
		do
			routine_name := a_name
			test_class := a_test_class
			name := new_name
		ensure
			routine_name_set: routine_name.same_string (a_name)
			a_test_class_set: test_class = a_test_class
		end

feature -- Access

	name: IMMUTABLE_STRING_32
			-- <Precursor>

	eiffel_class: EIFFEL_CLASS_I
			-- Class in which test is defined
		do
			Result := test_class.eiffel_class
		end

	routine_name: STRING
			-- <Precursor>

	class_name: STRING
			-- <Precursor>
		do
			Result := eiffel_class.name
		end

	routine: detachable FEATURE_I
			-- {FEATURE_I} instance representing `Current' if compiled.
		do
			Result := etest_suite.project_access.feature_of_name (eiffel_class, routine_name)
		end

feature {NONE} -- Access

	test_class: ETEST_CLASS
			-- Test class instance to which `Current' belongs

	etest_suite: ETEST_SUITE
			-- Test suite which retrieved `Current'
		do
			Result := test_class.test_suite
		end

feature -- Basic operations

	print_test (a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			if attached routine as l_routine then
				a_formatter.add_feature (l_routine.e_feature, routine_name)
			else
				a_formatter.add_classi (eiffel_class, routine_name)
			end
			a_formatter.process_basic_text (" (")
			a_formatter.add_class (eiffel_class)
			a_formatter.process_basic_text (")")
		end

feature {TEST_EXECUTION_I} -- Factory

	new_executor (an_execution: TEST_EXECUTION_I): ETEST_COMPILATION_EXECUTOR
			-- <Precursor>
		do
			create Result.make (etest_suite, an_execution)
		end

feature {NONE} -- Implementation

	new_name: like name
			-- Create `name' attribute from attributes in `Current'.
		do
			create Result.make_from_string (class_name + "." + routine_name)
		end

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
