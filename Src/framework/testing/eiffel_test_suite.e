indexing
	description: "[
		Objects implementing {EIFFEL_TEST_SUITE_S}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_SUITE

inherit
	EIFFEL_TEST_SUITE_S

	TEST_COLLECTION
		rename
			are_tests_available as is_project_initialized
		undefine
			events
		end

	SHARED_TEST_ROUTINES

	EVENT_OBSERVER_CONNECTION [!ACTIVE_COLLECTION_OBSERVER [!EIFFEL_TEST_I]]

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			l_project_factory: SHARED_EIFFEL_PROJECT
			l_manager: EB_PROJECT_MANAGER
		do
			make_collection

				-- Create events
			create executor_launched_event
			create factory_launched_event
			create processor_finished_event

				-- Create storage
			create test_class_map.make (0)
			create test_routine_map.make_default
			create modified_classes.make_default

				-- Subscribe `Current' to project events
			create l_project_factory
			internal_project ?= l_project_factory.eiffel_project
			l_manager := project.manager
			l_manager.load_agents.extend (agent refresh)
			l_manager.compile_stop_agents.extend (agent refresh)

			refresh
		end

feature -- Access

	default_executor: !TYPE [!EIFFEL_TEST_EXECUTOR_I]
			-- <Precursor>
		once

		end

	project: !E_PROJECT is
			-- Project in which we look for tests
		do
			Result := internal_project
		end

	tests: !DS_BILINEAR [!EIFFEL_TEST_I]
			-- <Precursor>
		do
			Result := test_routine_map
		end

	processor_registrar: !EIFFEL_TEST_PROCESSOR_REGISTRAR_I [!EIFFEL_TEST_PROCESSOR_I [ANY]]
			-- <Precursor>

feature {NONE} -- Access

	internal_project: like project
			-- Project stored internally, since it is available at creation but might not be initialized

	test_class_map: !DS_HASH_TABLE [!DS_LIST [!STRING], !STRING]
			-- Hash table mapping test class names (descendants of {TEST_SET}) to a list of routines names
			-- representing test routines of that class specific.
			--
			-- keys: Name of class inheriting from {TEST_SET}
			-- values: List of test routine names contained in that class

	test_routine_map: !DS_HASH_TABLE [!EIFFEL_TEST_I, !STRING]
			-- Hash table mapping a test routine name to its associated eiffel test instance
			--
			-- keys: Test routine names in the form CLASS_NAME.routine_name (to avoid clashes)
			-- values: {EIFFEL_TEST_I} instance corresponding to routine name

	modified_classes: !DS_ARRAYED_LIST [!STRING]
			-- Name of classes which have been modified since last call to
			-- `refresh' (only contains classes used in `test_class_map')

	test_class_ancestor: ?EIFFEL_CLASS_C
			-- Ancestor all classes containing tests must inherit from.
			-- Can be Void if class is not found in `project' or not
			-- fully compiled yet.

feature -- Query

	is_test_class (a_class: !CLASS_I): BOOLEAN
			-- <Precursor>
		do
			Result := test_class_map.has (class_name (a_class))
		end

feature {NONE} -- Query

	is_class_alive (a_class: !EIFFEL_CLASS_C): BOOLEAN is
			-- Is `a_class' registered in system and contains ast?
		do
			Result := a_class.is_valid and then a_class.has_ast
		end

	is_valid_compiled_class (a_class: !EIFFEL_CLASS_C): BOOLEAN is
			-- Can `a_class' contain test routines?
		require
			test_class_ancestor_not_void: test_class_ancestor /= Void
		do
			Result := is_class_alive (a_class) and then
				is_valid_class ({!CLASS_AS} #? a_class.ast) and
				not a_class.is_deferred and
				not a_class.is_generic and
				a_class.conform_to (test_class_ancestor) and
				(a_class.creators = Void or else a_class.creators.is_empty)
		end

	new_test (a_routine_name, a_class_name: !STRING): !EIFFEL_TEST_I
		do
			create {EIFFEL_TEST} Result.make (a_routine_name, a_class_name)
		end

feature -- Status report

	is_project_initialized: BOOLEAN
			-- <Precursor>
		do
			Result := internal_project.initialized and then
				internal_project.workbench.universe_defined and then
				internal_project.system_defined and then
				internal_project.system.universe.target /= Void
		end

	is_updating_tests: BOOLEAN
			-- <Precursor>

	count_passing: NATURAL
			-- <Precursor>

	count_failing: NATURAL
			-- <Precursor>

feature -- Status settings

	run_list (a_type: !TYPE [!EIFFEL_TEST_EXECUTOR_I]; a_list: !DS_LINEAR [!EIFFEL_TEST_I]; a_blocking: BOOLEAN)
			-- <Precursor>
		do
		end

	create_tests (a_type: !TYPE [!EIFFEL_TEST_FACTORY_I [EIFFEL_TEST_CONFIGURATION_I]]; a_conf: !EIFFEL_TEST_CONFIGURATION_I; a_blocking: BOOLEAN)
			-- <Precursor>
		do
		end

feature -- Basic functionality

	synchronize_tests (a_class: !CLASS_I)
			-- <Precursor>
		local
			l_name: !STRING
			l_list: !DS_ARRAYED_LIST [!STRING]
			l_ast: !CLASS_AS
		do
			l_name ?= a_class.name.as_upper
			test_class_map.search (l_name)
			if not test_class_map.found then
				create l_list.make_default
				test_class_map.force (l_list, l_name)
			end
			-- TODO: retrieve ast for `a_class' and store it in `l_ast'!
			addopt_test_routines (l_ast, l_name)
		end

feature -- Events

	executor_launched_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; executor: !EIFFEL_TEST_EXECUTOR_I]]
			-- <Precursor>

	factory_launched_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; factory: !EIFFEL_TEST_FACTORY_I [EIFFEL_TEST_CONFIGURATION_I]]]
			-- <Precursor>

	processor_proceeded_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I [ANY]]]
			-- <Precursor>

	processor_finished_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I [ANY]]]
			-- <Precursor>

	processor_stopped_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I [ANY]]]
			-- <Precursor>

feature {EIFFEL_TEST_EXECUTOR_I} -- Events

	on_test_launched (a_executor: !EIFFEL_TEST_EXECUTOR_I) is
			-- <Precursor>
		require else
			a_executor_registered: processor_registrar.processors.has (a_executor)
			a_executor_launched_by_current: a_executor.test_suite = Current
		do
			test_changed_event.publish ([Current, a_executor.current_test])
		end

	on_test_finished (a_executor: !EIFFEL_TEST_EXECUTOR_I; a_test: !EIFFEL_TEST_I) is
			-- <Precursor>
		require else
			a_executor_registered: processor_registrar.processors.has (a_executor)
			a_executor_launched_by_current: a_executor.test_suite = Current
		do
			test_changed_event.publish ([Current, a_test])
		end

feature {NONE} -- Implementation: test map

	refresh
			-- Rebuild `test_class_map' according to classes containing
			-- tests found in universe of `project'. For each class which
			-- has been added, removed or modified since last call to
			-- `refresh', update `test_routine_map'.
			-- Nofity observers of each change made to `test_routine_map'.
		local
			l_old_class_map: like test_class_map
			l_ancestor: EIFFEL_CLASS_C
			l_cursor: DS_LINEAR_CURSOR [!STRING]
			l_name: !STRING
			l_et: !EIFFEL_TEST_I
		do
			if not is_updating_tests then
				is_updating_tests := True
				if is_project_initialized then
					l_old_class_map := test_class_map
					update_test_class_ancestor
					if test_class_ancestor /= Void then
						create test_class_map.make (l_old_class_map.count)
						fill_test_class_map ({!EIFFEL_CLASS_C} #? test_class_ancestor, l_old_class_map)
					else
						create test_class_map.make (0)
					end

					from
						l_old_class_map.start
					until
						l_old_class_map.after
					loop
						l_cursor := l_old_class_map.item_for_iteration.new_cursor
						from
							l_cursor.start
						until
							l_cursor.after
						loop
							l_name := l_old_class_map.key_for_iteration + "." + l_cursor.item
							test_routine_map.search (l_name)
							check
								test_exists: test_routine_map.found
							end
							l_et := test_routine_map.found_item
							test_routine_map.remove_found_item
							test_removed_event.publish ([Current, l_et])
							l_cursor.forth
						end
						l_old_class_map.forth
					end
				else
					check
							-- Note: this point should no be reached since it is not able to "unload" a project.
						not_implemented: False
					end
				end
				is_updating_tests := False
			end
		ensure
			modified_classes_empty: modified_classes.is_empty
		end

	update_test_class_ancestor is
			-- Look for compiled test class ancestor and store it in
			-- `test_class_ancestor' if found.
		require
			project_initialized: is_project_initialized
		local
			ancestors: LIST [CLASS_I]
			old_cs: CURSOR
			l_universe: UNIVERSE_I
			l_ec: !EIFFEL_CLASS_C
		do
			test_class_ancestor := Void
			l_universe := project.system.universe
			ancestors := l_universe.classes_with_name (common_test_class_ancestor_name)
			from
				old_cs := ancestors.cursor
				ancestors.start
			until
				ancestors.after or test_class_ancestor /= Void
			loop
				l_ec ?= ancestors.item.compiled_class
				if l_ec /= Void and then is_class_alive (l_ec) then
					test_class_ancestor := l_ec
				end
				ancestors.forth
			end
			ancestors.go_to (old_cs)
		end

	fill_test_class_map (an_ancestor: !EIFFEL_CLASS_C; an_old_map: like test_class_map) is
			-- Fill `test_class_map' with classes containing test routines resusing
			-- existing items. For new or modified classes, parse list of test routines
			-- and addopt `test_routine_map' accordingly and notify observers of any changes.
			--
			-- `an_ancestor': Look in effective descendants (excluding `an_ancestor') for test
			-- 		routines. `fill_test_class_map' will call itself recursively for each
			-- 		descendant found.
			-- `an_old_map': old map containing old routine lists, any
			-- 		reused item will be removed from map
		require
			an_ancestor_alive: is_class_alive (an_ancestor)
		local
			l_list: ARRAYED_LIST [CLASS_C]
			l_routine_list: !DS_LIST [!STRING]
			l_parse: BOOLEAN
			l_name: !STRING
		do
				-- Note: because of multiple inheritance and possible (but rare)
				-- corrupted EIFGENs we need to check whether `test_class_map'
				-- already contains item for `an_ancestor'
			l_name ?= an_ancestor.name.as_upper
			if is_valid_compiled_class (an_ancestor) and not test_class_map.has (l_name) then
				an_old_map.search (l_name)
				if an_old_map.found then
					l_routine_list := an_old_map.found_item
					an_old_map.remove_found_item
					l_parse := modified_classes.has (l_name)
				else
					create {DS_ARRAYED_LIST [!STRING]} l_routine_list.make_default
					l_parse := True
				end
				test_class_map.force (l_routine_list, l_name)
				if l_parse then
					addopt_test_routines ({!CLASS_AS} #? an_ancestor.ast, l_name)
				end
			end
			l_list := an_ancestor.direct_descendants
			from
				l_list.start
			until
				l_list.after
			loop
				if {l_ec: !EIFFEL_CLASS_C} l_list.item and then is_class_alive (l_ec) then
					fill_test_class_map (l_ec, an_old_map)
				end
				l_list.forth
			end
		ensure
			ancestor_valid_implies_added: is_valid_compiled_class (an_ancestor) implies
				(test_class_map.has ({!STRING} #? an_ancestor.name_in_upper) and
				 not an_old_map.has ({!STRING} #? an_ancestor.name_in_upper))
		end

	addopt_test_routines (a_class: !CLASS_AS; a_name: !STRING) is
				-- Find test routines in class and addopt `test_routine_map' and `test_class_map'
				-- accordingly. For new routines a EIFFEL_TEST_I instance will be created and
				-- added to maps. For existing routines the EIFFEL_TEST_I instance should
				-- reevaluate the test routine to see if there were any changes. Routines not
				-- existing any longer will be removed from maps.
				--
				-- `a_class_as': syntax tree of class in which to look for test routines
				-- `a_name': name of `a_class' (provided here for consistency of map keys)
			require
				a_class_registered: test_class_map.has (a_name)
			local
				l_list: !DS_LIST [!STRING]
				l_features: like valid_features
				l_cursor: DS_LIST_CURSOR [!STRING]
				l_et: !EIFFEL_TEST_I
				l_ctags, l_ftags: !DS_HASH_SET [!STRING]
			do
				l_list := test_class_map.item (a_name)
				l_features := valid_features (a_class)

				create l_ctags.make_default
				l_ctags.set_equality_tester ({KL_EQUALITY_TESTER [!STRING]} #? create {KL_STRING_EQUALITY_TESTER})
				if {l_ticlause: !INDEXING_CLAUSE_AS} a_class.top_indexes then
					add_tags (l_ticlause, l_ctags)
				end
				if {l_biclause: !INDEXING_CLAUSE_AS} a_class.bottom_indexes then
					add_tags (l_biclause, l_ctags)
				end

					-- Following loop either removes or refreshes existing tests!
					--
					-- First iterate through existing features to see which are
					-- still part of `a_class'. Refresh test instance and remove
					-- from `l_features' if so, otherwise remove from `l_list'
					-- and `test_routine_map'.
				from
					l_cursor := l_list.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					test_routine_map.search (a_name + "." + l_cursor.item)
					check
						test_exists: test_routine_map.found
					end
					l_et := test_routine_map.found_item
					l_features.search (l_cursor.item)
					if l_features.found then
						if {l_ficlause: !INDEXING_CLAUSE_AS} l_features.found_item.indexes then
							l_ftags := l_ctags.cloned_object
							add_tags (l_ficlause, l_ftags)
						else
							l_ftags := l_ctags
						end
						l_et.set_explicit_tags (l_ftags)
						if l_et.have_tags_changed then
							test_changed_event.publish ([Current, l_et])
						end
						l_features.remove_found_item
						l_cursor.forth
					else
						test_routine_map.remove_found_item
						test_removed_event.publish ([Current, l_et])
						l_cursor.remove
					end
				end

					-- Following loop adds any test still listed in `l_features'
				from
					l_features.start
				until
					l_features.after
				loop
					l_list.force_last (l_features.key_for_iteration)
					l_et := new_test (l_features.key_for_iteration, a_name)
					if {l_ficlause2: !INDEXING_CLAUSE_AS} l_features.item_for_iteration.indexes then
						l_ftags := l_ctags.cloned_object
						add_tags (l_ficlause2, l_ftags)
					else
						l_ftags := l_ctags
					end
					l_et.set_explicit_tags (l_ftags)
					test_routine_map.force (l_et, a_name + "." + l_features.key_for_iteration)
					test_added_event.publish ([Current, l_et])
					l_features.forth
				end
			end

feature {NONE} -- Implementation: tag retrieval

	add_tags (a_indexing_clause: !INDEXING_CLAUSE_AS; a_set: !DS_SET [!STRING])
			-- Add tags defined in indexing clause to a set.
			--
			-- `a_indexing_clause': Indexing clause of a class or feature that might contains tags.
			-- `a_set': Set to which tags in indexing clause will be added.
		local
			l_cs: CURSOR
			l_item: INDEX_AS
			l_value_list: EIFFEL_LIST [ATOMIC_AS]
			l_tags: !STRING
		do
			if not a_indexing_clause.is_empty then
				from
					l_cs := a_indexing_clause.cursor
					a_indexing_clause.start
				until
					a_indexing_clause.after
				loop
					l_item := a_indexing_clause.item
					if l_item.tag.name.is_case_insensitive_equal (indexing_clause_tag_name) then
						from
							l_value_list := l_item.index_list
							l_value_list.start
						until
							l_value_list.after
						loop
							l_tags ?= l_value_list.item.string_value.twin
							tag_utilities.find_tags_in_string (l_tags, agent a_set.force)
							l_value_list.forth
						end
					end
					a_indexing_clause.forth
				end
				a_indexing_clause.go_to (l_cs)
			end
		end

	tag_utilities: !TAG_UTILITIES
			-- Routines for extracting tags
		once
			create Result
		end

end
