indexing
	description: "[
					eWeasel test case creation wizard information
																			]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NEW_UNIT_TEST_WIZARD_INFORMATION

inherit
	EB_WIZARD_INFORMATION

create
	make

feature  {NONE} -- Initialization

	make (a_testing_tool: ES_TESTING_TOOL_PANEL)
			-- Creation method
		require
			not_void: a_testing_tool /= Void
		do
			testing_tool := a_testing_tool

			create features_to_test.make (10)
		ensure
			set: testing_tool = a_testing_tool
		end

feature -- Query

	new_class_name: STRING
			-- Class name for the new class which will be created

	new_class_file_name: STRING
			-- New class file name which contain class `new_class_name'
		require
			not_void: new_class_name /= Void and then not new_class_name.is_empty
		do
			Result := new_class_name.as_lower + ".e"
		ensure
			not_void: Result /= Void and then not Result.is_empty
		end

	class_under_test: STRING
			-- Class selected to test.

	cluster: CLUSTER_I
			-- Cluster I where new test case class will be created
		do
			if is_valid then
				if internal_cluster_id /= Void then
					Result ?= id_solution.group_of_id (internal_cluster_id)
				else
					check not_possible: False end
				end
			end
		end

	cluster_path: STRING
			-- Cluster path which used by Eiffel system internally.
			-- Separated by {ES_CLUSTER_NAME_AND_PATH_HELPER}.cluster_separator.
			-- This is not file system path.
		local
			l_helper: ES_CLUSTER_NAME_AND_PATH_HELPER
		do
			if is_valid then
				if internal_cluster_sub_path /= Void then
					Result := internal_cluster_sub_path
					check not_void_at_same_time: internal_cluster_id /= Void end
				else
					create l_helper
					Result := l_helper.split_cluster_name_and_path (internal_cluster).cluster_path
				end
			end
		end

	cluster_directory: DIRECTORY_NAME
			-- Cluster directory name
		require
			valid: is_valid
		local
			l_helper: ES_CLUSTER_NAME_AND_PATH_HELPER
		do
			create l_helper
			if internal_cluster_id /= Void then
				Result := l_helper.cluster_path_by_id_and_sub_path (internal_cluster_id, internal_cluster_sub_path)
			else
				Result := l_helper.cluster_path (internal_cluster)
			end
		ensure
			not_void: Result /= Void
		end

	features_to_test: ARRAYED_LIST [E_FEATURE]
			-- Features in `class_under_test' which will be tested.

	is_on_before_test_runs_selected: BOOLEAN
			-- If `on_before_all_test_runs' check box selected?

	is_on_after_test_runs_selected: BOOLEAN
			-- If `on_after_all_test_runs' check box selected?

	is_on_before_test_run_selected: BOOLEAN
			-- If `on_before_test_run' check box selected?						

	is_on_after_test_run_selected: BOOLEAN
			-- If `on_after_test_run' check box selected?

	is_add_frozen_feature_stubs_selected: BOOLEAN
			-- If `add_forzen_feature_stubs' check box selected?

	is_add_to_be_implemented_selected: BOOLEAN
			-- If `add_to_be_implemented' check box selected?

	has_cluster_id (a_cluster_id: STRING): BOOLEAN is
			-- If `a_cluster_id' exists in current system?
		do
			Result := id_solution.group_of_id (a_cluster_id) /= Void
		end

	testing_tool: ES_TESTING_TOOL_PANEL
			-- Testing tool.

	helper: ES_NEW_UNIT_TEST_WIZARD_HELPER
			-- Helper
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	is_valid: BOOLEAN
			-- If Current information valid for new eweasel test case creation?
		local
			l_helper: ES_CLUSTER_NAME_AND_PATH_HELPER
			l_cluster_valid: BOOLEAN
		do
			l_cluster_valid := internal_cluster /= Void and then not internal_cluster.is_empty
			if not l_cluster_valid then
				l_cluster_valid := internal_cluster_id /= Void and then not internal_cluster_id.is_empty
			end
			Result := (new_class_name /= Void and then not new_class_name.is_empty) and l_cluster_valid

			if Result then
				create l_helper
				Result := l_helper.is_cluster_full_path_valid (internal_cluster)
			end
		end

feature -- Command

	set_class_under_test (a_class_name: STRING)
			-- Set `class_under_test' with `a_class_name'
		require
			not_void: a_class_name /= Void and then not a_class_name.is_empty
		do
			class_under_test := a_class_name
		ensure
			set: class_under_test = a_class_name
		end

	set_new_class_name (a_class_name: STRING)
			-- Set `new_class_name' with `a_class_name'
		require
			not_void: a_class_name /= Void and then not a_class_name.is_empty
		do
			new_class_name := a_class_name
		ensure
			set: new_class_name = a_class_name
		end

	set_cluster (a_cluster: like internal_cluster)
			-- Set `internal_cluster' with `a_cluster'
		require
			not_void: a_cluster /= Void
			valid: (create {ES_CLUSTER_NAME_AND_PATH_HELPER}).is_cluster_full_path_valid (a_cluster)
		do
			internal_cluster := a_cluster
		ensure
			set: internal_cluster = a_cluster
		end

	set_cluster_id_and_path (a_cluster_id: like internal_cluster; a_path: STRING)
			-- Set `internal_cluster' with `a_cluster'
		require
			not_void: a_cluster_id /= Void
			valid: has_cluster_id (a_cluster_id)
		do
			internal_cluster_id := a_cluster_id
			internal_cluster_sub_path := a_path
		ensure
			set: internal_cluster_id = a_cluster_id
			set: internal_cluster_sub_path = a_path
		end

	set_is_on_after_all_test_runs_selected (a_bool: like is_on_after_test_runs_selected) is
			-- Set `is_on_after_test_runs_selected' with `a_bool'
		do
			is_on_after_test_runs_selected := a_bool
		ensure
			set: is_on_after_test_runs_selected = a_bool
		end

	set_is_on_before_all_test_runs_selected (a_bool: like is_on_before_test_runs_selected) is
			-- Set `is_on_before_test_runs_selected' with `a_bool'
		do
			is_on_before_test_runs_selected := a_bool
		ensure
			set: is_on_before_test_runs_selected = a_bool
		end

	set_is_on_before_test_run_selected (a_bool: like is_on_before_test_run_selected) is
			-- Set `is_on_before_test_run_selected' with `a_bool'
		do
			is_on_before_test_run_selected := a_bool
		ensure
			set: is_on_before_test_run_selected = a_bool
		end

	set_is_on_after_test_run_selected (a_bool: like is_on_after_test_run_selected) is
			-- Set `is_on_after_test_run_selected' with `a_bool'
		do
			is_on_after_test_run_selected := a_bool
		ensure
			set: is_on_after_test_run_selected = a_bool
		end

	set_is_add_frozen_feature_stubs_selected (a_bool: like is_add_frozen_feature_stubs_selected) is
			-- Set `is_add_frozen_feature_stubs_selected' with `a_bool'
		do
			is_add_frozen_feature_stubs_selected := a_bool
		ensure
			set: is_add_frozen_feature_stubs_selected = a_bool
		end

	set_is_add_to_be_implemented_selected (a_bool: like is_add_to_be_implemented_selected) is
			-- Set `is_add_to_be_implemented_selected' with `a_bool'
		do
			is_add_to_be_implemented_selected := a_bool
		ensure
			set: is_add_to_be_implemented_selected = a_bool
		end

feature {NONE} -- Implementation

	id_solution: EB_SHARED_ID_SOLUTION
			-- Id solution
		once
			create Result
		end

	internal_cluster_id, internal_cluster_sub_path: STRING
			-- cluster and its sub path.

	internal_cluster: STRING
			-- Cluster name
			-- Because cluster name maybe duplicated in system.
			-- Use `internal_cluster_id' first if it's not void.

invariant
	not_void: features_to_test /= Void

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
