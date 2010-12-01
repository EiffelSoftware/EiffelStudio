note
	description: "[
		Objects that extend {SYSTEM_I} to automatically compile test classes.
		
		{TEST_SYSTEM_I} is invoked if a configuration references the testing library directly. Any
		writable class is then added to the system in order to be later checked for inheriting from
		{EQA_TEST_SET}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SYSTEM_I

inherit
	SHARED_WORKBENCH

	PROJECT_CONTEXT

	CONF_ACCESS

create {SYSTEM_I}
	default_create

feature -- Access

	eifgens_cluster: detachable CONF_CLUSTER
			-- Cluster added to universe target pointing to "Cluster" directory in "EIFGENs", Void if cluster
			-- has not been added yet.
		local
			l_clusters: HASH_TABLE [CONF_CLUSTER, STRING]
		do
			l_clusters := universe.target.clusters
			l_clusters.search (eifgens_cluster_name)
			if l_clusters.found then
				Result := l_clusters.found_item
			end
		end

	test_set_descendants: SEARCH_TABLE [EIFFEL_CLASS_C]
			-- Classes inheriting from {EQA_TEST_SET}
		require
			testing_enabled: is_testing_enabled
		local
			l_server: CLASS_C_SERVER
			i: INTEGER
		do
			create Result.make (10)
			l_server := system.classes
			if attached library_class_named (eqa_test_set_name) as l_class and then system.successful then
				from
					i := l_server.lower
				until
					i > l_server.upper
				loop
					if attached {EIFFEL_CLASS_C} l_server[i] as l_classc and then l_classc.simple_conform_to (l_class) then
						Result.force (l_classc)
					end
					i := i + 1
				end
			end
		ensure
			result_attached: Result /= Void
		end

	library (a_target: CONF_TARGET): detachable CONF_LIBRARY
			-- Retrieve testing library configuration in given target. Returns Void if testing library is not
			-- included in target.
		local
			l_uuid_visitor: CONF_FIND_UUID_VISITOR
		do
			create l_uuid_visitor.make
			l_uuid_visitor.set_uuid (testing_library_uuid)
			l_uuid_visitor.set_recursive (False)
			a_target.process (l_uuid_visitor)
			if not l_uuid_visitor.found_libraries.is_empty then
				Result := l_uuid_visitor.found_libraries.first
			end
		ensure
			valid_result: Result /= Void implies Result.library_target.system.uuid.is_equal (testing_library_uuid)
		end

	library_class_named (a_class_name: READABLE_STRING_8): detachable EIFFEL_CLASS_C
			-- Retrieve compiled representation of a testing library class
		require
			a_class_name_attached: a_class_name /= Void
		local
			l_universe: like universe
		do
			l_universe := universe
			if
				attached l_universe.target as l_target and then
				attached library (l_target) as l_library and then
				attached l_universe.class_named (a_class_name, l_library) as l_class and then
				attached {EIFFEL_CLASS_C} l_class.compiled_class as l_cclass
			then
				Result := l_cclass
			end
		end

feature {SYSTEM_I, DEGREE_5} -- Access

	suppliers: SEARCH_TABLE [CLASS_C]
			-- During Degree 5 and 4 this table contains classes which might represent test classes (or serve as their
			-- suppliers). After Degree 4 only real {EQA_TEST_SET} descendants and their suppliers remain.
		require
			testing_enabled: is_testing_enabled
		do
			check attached suppliers_cache as l_cache then
				Result := l_cache
			end
		ensure
			result_attached: Result /= Void
			result_equals_cache: Result = suppliers_cache
		end

feature -- Status report

	is_testing_enabled: BOOLEAN
			-- Is testing mode enabled? i.e. has testing library been added to configuration?
		do
			Result := suppliers_cache /= Void
		ensure
			result_implies_supplier_cache_attached: Result implies suppliers_cache /= Void
		end

feature -- Constants

	testing_library_uuid_code: STRING = "B77B3A44-A1A9-4050-8DF9-053598561C33"
			-- UUID of testing library

	frozen testing_library_uuid: UUID
			-- UUID of testing library
		do
			create Result.make_from_string (testing_library_uuid_code)
		end

	eifgens_cluster_name: STRING = "internal_eifgen_cluster"
			-- Name of hidden cluster in EIFGENs directory (EIFGENs/[target]/Cluster)

	eqa_test_set_name: STRING = "EQA_TEST_SET"
			-- Class name of {EQA_TEST_SET}

	eqa_evaluator_name: STRING = "EQA_EVALUATOR"
			-- Class name of evaluator root class

	eqa_evaluator_creator: STRING = "make"
			-- Root feature name of evaluator root class

	eqa_interpreter_name: STRING = "ITP_INTERPRETER"
			-- Class name of interpreter root class

	eqa_interpreter_creator: STRING = "execute"
			-- Root feature name of interpreter root class

feature {SYSTEM_I} -- Basic operations

	check_for_testing_configuration (a_target: CONF_TARGET)
			-- Check configuration for testing library. If present, prepare system to compile test classes
			-- and everything needed for test execution, otherwise clean up any previously generated
			-- directory or classes.
		local
			l_path: DIRECTORY_NAME
		do
				-- Set `suppliers_cache' accordingly as it will define from now on
				-- whether testing is enabled or not
			if not compilation_modes.is_precompiling and attached library (a_target) then
					-- If `suppliers_cache' was created in a previous compilation, we reuse it
				if not attached suppliers_cache then
					create suppliers_cache.make (0)
				end
			else
				suppliers_cache := Void
			end

			l_path := project_location.eifgens_cluster_path
			adopt_root_features
			adopt_eifgens_cluster (a_target, l_path)
		end

	mark_suppliers (a_mark_table: SEARCH_TABLE [INTEGER])
			-- Mark all classes in `suppliers' in given table. If there are classes in `suppliers' which
			-- are already marked, remove them as they are referenced by the system.
			--
			-- `a_mark_table': Table in which `suppliers' should be marked.
		require
			testing_enabled: is_testing_enabled
		local
			l_suppliers, l_new_suppliers: like suppliers
			l_class: CLASS_C
		do
			from
				l_suppliers := suppliers
				create l_new_suppliers.make (l_suppliers.count)
				l_suppliers.start
			until
				l_suppliers.after
			loop
				l_class := l_suppliers.item_for_iteration
				if not a_mark_table.has (l_class.class_id) then
					l_new_suppliers.force (l_class)
				end
				l_suppliers.forth
			end

			from
				suppliers_cache := l_new_suppliers
				l_new_suppliers.start
			until
				l_new_suppliers.after
			loop
				l_new_suppliers.item_for_iteration.mark_class (a_mark_table)
				l_new_suppliers.forth
			end
		end

	remove_unused_classes
			-- Remove classes from `suppliers' and from system if they do not serve as
			-- suppliers for descendants of {EQA_TEST_SET}.
		require
			testing_enabled: is_testing_enabled
		local
			l_marked_classes: SEARCH_TABLE [INTEGER]
			l_descandants: like test_set_descendants
			l_system: like system
			l_suppliers, l_new_suppliers: like suppliers
			l_class: CLASS_C
		do
			create l_marked_classes.make ({SYSTEM_I}.system_chunk)

				-- Mark all classes in `suppliers' which are needed by test classes
			from
				l_descandants := test_set_descendants
				l_descandants.start
			until
				l_descandants.after
			loop
				l_class := l_descandants.item_for_iteration
				l_class.mark_class (l_marked_classes)
				l_descandants.forth
			end

				-- Remove classes in `suppliers' which have not been marked previously
			from
				l_suppliers := suppliers
				l_system := system
				l_suppliers.start
				create l_new_suppliers.make (l_suppliers.count)
			until
				l_suppliers.after
			loop
				l_class := l_suppliers.item_for_iteration
				if not l_marked_classes.has (l_class.class_id) then
					l_system.remove_class (l_class)
				else
					l_new_suppliers.force (l_class)
				end
				l_suppliers.forth
			end
			l_system.process_removed_classes
			suppliers_cache := l_new_suppliers
		end

feature {DEGREE_5} -- Basic operations

	add_possible_testing_classes
			-- Add any classes not part of the system to degree 5.
		require
			testing_enabled: is_testing_enabled
		local
			l_all_classes: SEARCH_TABLE [CLASS_I]
			l_classi: CLASS_I
			l_workbench: WORKBENCH_I
		do
				-- Testing is enabled
			l_all_classes := universe.all_classes
			l_workbench := workbench
			from
				l_all_classes.start
			until
				l_all_classes.after
			loop
				l_classi := l_all_classes.item_for_iteration
				if
					not l_classi.is_external_class and
					not l_classi.config_class.does_override and
					not l_classi.is_read_only
				then
					if not attached l_classi.compiled_class then
							-- No compiled class means we are explicitly forcing a degree 4 on it
						l_workbench.change_class (l_classi)
					end
				end
				l_all_classes.forth
			end
		end

feature {NONE} -- Implementation

	adopt_root_features
			-- Add internal {CONF_CLUSTER} to current target if given path exists.
		do
			if is_testing_enabled then
				system.add_explicit_root (Void, eqa_evaluator_name, eqa_evaluator_creator)
				system.add_explicit_root (Void, eqa_interpreter_name, eqa_interpreter_creator)
			else
				system.remove_explicit_root (eqa_evaluator_name, eqa_evaluator_creator)
				system.remove_explicit_root (eqa_interpreter_name, eqa_interpreter_creator)
			end
		end

	adopt_eifgens_cluster (a_target: CONF_TARGET; a_path: READABLE_STRING_8)
			-- Add internal {CONF_CLUSTER} to current target if testing is enabled.
			--
			-- `a_target': Target to which cluster is added if path exists.
			-- `a_path': Path for which a cluster is added.
		local
			l_dir: DIRECTORY
			l_vis: CONF_FIND_LOCATION_VISITOR
			l_loc: CONF_DIRECTORY_LOCATION
			l_cluster: CONF_CLUSTER
			l_factory: CONF_COMP_FACTORY
		do
			create l_vis.make
			l_vis.set_directory (a_path)
			l_vis.process_target (a_target)
			if l_vis.found_clusters.is_empty then

					-- We only perform any actions if the path is not already
					-- referenced in the configuration				
				create l_dir.make (a_path)
				if is_testing_enabled then
					if not l_dir.exists then
						execute_safe (agent l_dir.create_dir)
					end
				end

				if l_dir.exists and then (is_testing_enabled or not l_dir.is_empty) then
					create l_factory
					l_loc := l_factory.new_location_from_path (a_path, a_target)
					l_cluster := l_factory.new_cluster (eifgens_cluster_name, l_loc, a_target)
					l_cluster.set_recursive (True)
					l_cluster.set_internal (True)
					a_target.add_cluster (l_cluster)
				end
			end
		end

	suppliers_cache: detachable like suppliers
			-- Cache for `test_set_suppliers', Void if testing library was not part of
			-- configuration during last compilation.

feature {NONE} -- Implementation

	execute_safe (an_agent: PROCEDURE [ANY, TUPLE])
		require
			an_agent_attached: an_agent /= Void
			an_agent_expects_not_operands: an_agent.valid_operands (Void)
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				an_agent.call (Void)
			end
		rescue
			l_retried := True
			retry
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
