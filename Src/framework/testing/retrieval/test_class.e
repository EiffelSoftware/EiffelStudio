note
	description: "[
		Objects representing classes containing tests associated with the corresponding Eiffel class.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CLASS

inherit
	ANY

create {TEST_PROJECT_I}
	make

feature {NONE} -- Initialization

	make (a_class: like eiffel_class)
			-- Initialize `Current'.
		local
			l_classname, l_filename: attached STRING
		do
			eiffel_class := a_class
			create l_classname.make_from_string (eiffel_class.name)
			create l_filename.make_from_string (eiffel_class.file_name)
			create identifier.make (l_classname.count + l_filename.count)
			identifier.append (l_classname)
			identifier.append (l_filename)
			create internal_names.make_default
			internal_names.set_equality_tester (create {KL_STRING_EQUALITY_TESTER_A [attached STRING]})
		end

feature -- Access

	eiffel_class: attached EIFFEL_CLASS_I
			-- Class in system carrying tests

	identifier: attached STRING
			-- Unique identifier for `eiffel_class'

	frozen test_routine_names: attached DS_LINEAR [attached STRING]
			-- Names of test routines defined in `eiffel_class'.
		do
			Result := internal_names
		ensure
			results_not_empty: not Result.there_exists (agent {attached STRING}.is_empty)
			correct_equality_tester: attached {KL_STRING_EQUALITY_TESTER_A [attached STRING]} Result.equality_tester as l_tester
		end

feature {TEST_PROJECT_I} -- Access

	internal_names: attached DS_HASH_SET [attached STRING]
			-- Internal storage for `test_routine_names'

;note
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
