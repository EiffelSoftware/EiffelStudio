note
	description: "[
		Class containing session IDs for settings regarding test execution, debugging, creation,
		generation and extraction.
		
		Every id has an associated default values also indicating the type of the setting. The comment
		suggests whether the setting should be stored globaly or on a per project basis.
		
		For global settings use {SESSION_MANAGER_S}.retrieve (False)
		For project settings use {SESSION_MANAGER_S}.retrieve (True)
		
		A {SESSION_MANAGER_S} can be retrieved from {ES_DOCKABLE_TOOL_PANEL}
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SESSION_CONSTANTS

feature -- Access: Execution

	concurrent_executors: STRING = "com.eiffel.autotest.concurrent_executors"
	concurrent_executors_default: NATURAL = 4
			-- Number of executors running concurrently when executing tests in the background (global)	

	keep_failing: STRING = "com.eiffel.autotest.keep_failing"
	keep_failing_default: BOOLEAN = False
	keep_unresolved: STRING = "com.eiffel.autotest.keep_unresolved"
	keep_unresolved_default: BOOLEAN = False
	keep_passing: STRING = "com.eiffel.autotest.keep_passing"
	keep_passing_default: BOOLEAN = False
			-- Setting for keeping directory/files of tests which fail/unresolve/pass

feature -- Access: Creation

	cluster_name: STRING = "com.eiffel.autotest.cluster"
	cluster_name_default: STRING = ""
			-- Name of cluster in which a new test is created (project)
			--
			-- Note: if empty, the test will be created in the internal EIFGENs cluster

	path: STRING = "com.eiffel.autotest.path"
	path_default: STRING = ""
			-- Path in which a new test is created relative to the cluser's path (project)

	class_name: STRING = "com.eiffel.autotest.class_name"
	class_name_default: STRING = "NEW_TEST_SET"
			-- Default name for newly created test classes (project)

	tags: STRING = "com.eiffel.autotest.tags"
	tags_default: STRING  = ""
			-- Default list of user specific tags added to newly created tests (project)

feature -- Access: Creation (Manual)

	routine_name: STRING = "com.eiffel.autotest.routine_name"
	routine_name_default: STRING = "new_test_routine"
			-- Default name for new manual test routine (project)

	has_prepare: STRING = "com.eiffel.autotest.prepare"
	has_prepare_default: BOOLEAN = False
			-- Should a new manual test class redefine `on_prepare'? (project)

	has_clean: STRING = "com.eiffel.autotest.clean"
	has_clean_default: BOOLEAN = False
			-- Should a new manual test class redefine `on_clean'? (project)

feature -- Access: Creation (Generation)

	temporary_types: STRING = "com.eiffel.autotest.temporary_types"
	temporary_types_default: STRING = ""
			-- Types test generation will test in the next run
			--
			-- Note: currently not providing any types makes test generationtest all classes in the system.

	types: STRING = "com.eiffel.autotest.types"
	types_default: STRING = ""
			-- Types test generation should test by default if no other type is provided (project)
			--
			-- Note: currently not providing any types makes test generationtest all classes in the system.

	time_out: STRING = "com.eiffel.autotest.time_out"
	time_out_default: NATURAL = 0
			-- Time test generation performs random testing in minutes (global)
			--
			-- Note: 0 means run infinitely.

	invocation_count: STRING = "com.eiffel.autotest.invocations"
	invocation_count_default: NATURAL = 500
			-- Number of routine invocation test generation performs (global)
			--
			-- Note: 0 means run infinitely

	enable_slicing: STRING = "com.eiffel.autotest.slicing"
	enable_slicing_default: BOOLEAN = True
			-- Should generated tests be minimized using slicing? (global)

	enable_ddmin: STRING = "com.eiffel.autotest.ddmin"
	enable_ddmin_default: BOOLEAN = False
			-- Should generated tests be minimized using ddmin? (global)

	enable_text_statistics: STRING = "com.eiffel.autotest.text_statistics"
	enable_text_statistics_default: BOOLEAN = True
			-- Should text statistics be printed at the end of test generation? (global)

	enable_html_statistics: STRING = "com.eiffel.autotest.html_statistics"
	enable_html_statistics_default: BOOLEAN = False
			-- Should html statistics be printed at the end of test generation? (global)

	proxy_time_out: STRING = "com.eiffel.autotest.proxy_time_out"
	proxy_time_out_default: NATURAL = 2
			-- Number of seconds until a routine invocation is aborted (global)

	debugging: STRING = "com.eiffel.autotest.debugging"
	debugging_default: BOOLEAN = False
			-- Should generation print debugging information? (global)

	seed: STRING = "com.eiffel.autotest.seed"
	seed_default: NATURAL = 0
			-- Seed used by random number generation (global)

feature -- Access: Creation (Extraction)

	stack_frames: STRING = "com.eiffel.autotest.stack_frames"
	stack_frames_default: NATURAL = 5
			-- Number of stack frames extracted by default (global)
feature -- Access: Tool

	launch_wizard: STRING = "com.eiffel.testing_tool.launch_wizard"
	launch_wizard_default: BOOLEAN = True
			-- Should wizard always be shown before launching a test creation?

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
