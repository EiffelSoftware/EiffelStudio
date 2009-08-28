note
	description: "[
		Constants used in {ETEST_*} classes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_CONSTANTS

feature -- Access: constants

	testing_library_uuid: STRING = "B77B3A44-A1A9-4050-8DF9-053598561C33"
			-- UUID of testing library

	eqa_test_set_name: STRING = "EQA_TEST_SET"
	eqa_evaluator: STRING = "EQA_EVALUATOR"
	eqa_evaluator_root: STRING = "EQA_EVALUATOR_ROOT"
	eqa_test_evaluator: STRING = "EQA_TEST_EVALUATOR"
	eqa_system_test_set_name: STRING = "EQA_SYSTEM_LEVEL_TEST_SET"
			-- Names of classes in testing library

	indexing_clause_tag_name: STRING = "testing"
	prepare_routine_name: STRING = "on_prepare"
	clean_routine_name: STRING = "on_clean"
			-- Routine names in testing library

	eqa_evaluator_routine: STRING = "execute_test"
	eqa_evaluator_creator: STRING = "launch"
			-- Creation routine name in {EQA_EVALUATOR}

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
