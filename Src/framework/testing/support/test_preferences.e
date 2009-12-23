note
	description: "[
		Testing tool preferences.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES)
			-- Initialize `Current'.
		local
			l_manager: PREFERENCE_MANAGER
		do
			if a_preferences.has_manager (namespace) then
				l_manager := a_preferences.manager (namespace)
			else
				l_manager := a_preferences.new_manager (namespace)
			end
			initialize_preferences (l_manager)
		end

	initialize_preferences (a_manager: PREFERENCE_MANAGER)
			-- Initialize all preferences.
		require
			a_manager_attached: a_manager /= Void
		local
			l_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_factory
			evaluator_count := l_factory.new_integer_preference_value (a_manager, full_name (evaluator_count_name), evaluator_count_default)
			prepare_routine := l_factory.new_boolean_preference_value (a_manager, full_name (prepare_routine_name), prepare_routine_default)
			clean_routine := l_factory.new_boolean_preference_value (a_manager, full_name (clean_routine_name), clean_routine_default)
			autotest_timeout := l_factory.new_integer_preference_value (a_manager, full_name (autotest_timeout_name), autotest_timeout_default)
			autotest_test_count := l_factory.new_integer_preference_value (a_manager, full_name (autotest_test_count_name), autotest_test_count_default)
			autotest_proxy_timeout := l_factory.new_integer_preference_value (a_manager, full_name (autotest_proxy_timeout_name), autotest_proxy_timeout_default)
			autotest_seed := l_factory.new_integer_preference_value (a_manager, full_name (autotest_seed_name), autotest_seed_default)
			autotest_ddmin_minimization := l_factory.new_boolean_preference_value (a_manager, full_name (autotest_ddmin_name), autotest_ddmin_default)
			autotest_slice_minimization := l_factory.new_boolean_preference_value (a_manager, full_name (autotest_slicing_name), autotest_slice_default)
			autotest_html_statistics := l_factory.new_boolean_preference_value (a_manager, full_name (autotest_html_name), autotest_html_default)
		end

feature -- Access

	evaluator_count: INTEGER_PREFERENCE
			-- Number of parallel running evaluators

	prepare_routine: BOOLEAN_PREFERENCE
			-- Should `on_prepare' be redefined by default?

	clean_routine: BOOLEAN_PREFERENCE
			-- Should `on_clean' be redefined by default?

	autotest_timeout: INTEGER_PREFERENCE
			-- Number of minutes AutoTest runs random tests

	autotest_test_count: INTEGER_PREFERENCE
			-- Maximum number of invocations AutoTest performs

	autotest_proxy_timeout: INTEGER_PREFERENCE
			-- Number of seconds waited for routine to return

	autotest_seed: INTEGER_PREFERENCE
			-- Seed for random test generation

	autotest_ddmin_minimization: BOOLEAN_PREFERENCE
			-- Should ddmin be used for minimization?

	autotest_slice_minimization: BOOLEAN_PREFERENCE
			-- Should slicing be used for minimization?

	autotest_html_statistics: BOOLEAN_PREFERENCE
			-- Should html statistics be generated?

feature {NONE} -- Query

	full_name (a_name: STRING): STRING
			-- Full preference name for given suffix
		require
			a_name_attached: a_name /= Void
		do
			create Result.make (namespace.count + a_name.count + 1)
			Result.append (namespace)
			Result.append_character ('.')
			Result.append (a_name)
		end

feature {NONE} -- Constants

	namespace: STRING = "tools.testing_tool"

	evaluator_count_name: STRING = "execution.processes"
	evaluator_count_default: INTEGER = 4

	prepare_routine_name: STRING = "new_tests.prepare_routine"
	prepare_routine_default: BOOLEAN = False

	clean_routine_name: STRING = "new_tests.clean_routine"
	clean_routine_default: BOOLEAN = False

	autotest_timeout_name: STRING = "autotest.duration"
	autotest_timeout_default: INTEGER = 3

	autotest_test_count_name: STRING = "autotest.test_count"
	autotest_test_count_default: INTEGER = 0

	autotest_proxy_timeout_name: STRING = "autotest.proxy_timeout"
	autotest_proxy_timeout_default: INTEGER = 2

	autotest_seed_name: STRING = "autotest.random_seed"
	autotest_seed_default: INTEGER = 0

	autotest_ddmin_name: STRING = "autotest.use_ddmin"
	autotest_ddmin_default: BOOLEAN = False

	autotest_slicing_name: STRING = "autotest.use_slicing"
	autotest_slice_default: BOOLEAN = True

	autotest_html_name: STRING = "autotest.html_statistics"
	autotest_html_default: BOOLEAN = False

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
