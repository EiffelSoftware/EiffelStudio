indexing
	description: "[
		Objects implementing {EIFFEL_TEST_MANAGER_I}
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_MANAGER

inherit
	EIFFEL_TEST_MANAGER_I

	TEST_COLLECTION
		rename
			are_tests_available as is_project_initialized
		end

	SHARED_TEST_ROUTINES
		export
			{NONE} all
		end

	KL_SHARED_STRING_EQUALITY_TESTER
		export
			{NONE} all
		end

create
	make_with_project

feature {NONE} -- Initialization

	make_with_project (a_project: like project)
			-- Initialize `Current'.
		local
			l_manager: EB_PROJECT_MANAGER
		do
			internal_project := a_project
			l_manager := internal_project.manager
			l_manager.load_agents.force (agent refresh)
			l_manager.compile_stop_agents.extend (agent refresh)
		ensure
			project_set: project = a_project
		end

feature -- Access

	project: !E_PROJECT is
			-- Project in which we look for tests
		do
			Result := internal_project
		end

	tests: !DS_LINEAR [!EIFFEL_TEST_I]
			-- <Precursor>
		do
			Result := test_routine_map
		end

	last_created_cluster: ?CONF_TEST_CLUSTER
			-- <Precursor>

	last_created_class: ?CLASS_I
			-- <Precursor>

feature {NONE} -- Access

	internal_project: like project
			-- Internal storage of `project'

	test_class_map: !DS_HASH_TABLE [!EIFFEL_TEST_CLASS, !EIFFEL_CLASS_I]
			-- Hash table mapping test classes (descendants of {TEST_SET}) to a list of routines names
			-- representing test routines of the class.
			--
			-- keys: descendants of {TEST_SET}
			-- values: List of test routine names contained in that class

	test_routine_map: !DS_HASH_TABLE [!EIFFEL_TEST_I, !STRING]
			-- Hash table mapping a test routine name to its associated eiffel test instance
			--
			-- keys: Test routine names in the form CLASS_NAME.routine_name (to avoid clashes)
			-- values: {EIFFEL_TEST_I} instance corresponding to routine name

	test_class_ancestor: ?EIFFEL_CLASS_C
			-- Ancestor all classes containing tests must inherit from.
			-- Can be Void if class is not found in `project' or not
			-- fully compiled yet.

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

feature -- Query

	is_test_class (a_class: !EIFFEL_CLASS_I): BOOLEAN is
			-- <Precursor>
		do
			Result := test_class_map.has (a_class)
		end

	tests_for_class (a_class: !EIFFEL_CLASS_I): !DS_LINEAR [!EIFFEL_TEST_I]
			-- <Precursor>
		local
			l_list: !DS_ARRAYED_LIST [!EIFFEL_TEST_I]
			l_test_class: !EIFFEL_TEST_CLASS
		do
			l_test_class := test_class_map.item (a_class)
			create l_list.make (l_test_class.test_routine_names.count)
			l_test_class.test_routine_names.do_all (
				agent (n: !STRING; c: !EIFFEL_CLASS_I; l: !DS_LIST [!EIFFEL_TEST_I])
					local
						l_id: !STRING
					do
						l_id := test_identifier (c, n)
						l.put_last (test_routine_map.item (l_id))
					end (?, a_class, l_list))
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

	test_identifier (a_class: !EIFFEL_CLASS_I; a_name: !STRING): !STRING is
			-- Create unqiue identifier for test routine
			--
			-- `a_class': Class in which test is defined.
			-- `a_name': Name of test routine
		do
			create Result.make (a_class.cluster.cluster_name.count + a_class.name.count + a_name.count + 2)
			Result.append (a_class.cluster.cluster_name)
			Result.append_character ('.')
			Result.append (a_class.name)
			Result.append_character ('.')
			Result.append (a_name)
		ensure
			result_not_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

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
						l_cursor := l_old_class_map.item_for_iteration.test_routine_names.new_cursor
						from
							l_cursor.start
						until
							l_cursor.after
						loop
							l_name :=  test_identifier (l_old_class_map.item_for_iteration.eiffel_class, l_cursor.item)
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
					if not test_class_map.is_empty then
						test_routine_map.wipe_out
						test_class_map.wipe_out
						tests_reset_event.publish ([Current])
					end
				end
				is_updating_tests := False
			end
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
			l_test_class: !EIFFEL_TEST_CLASS
			l_parse: BOOLEAN
			l_class: !EIFFEL_CLASS_I
		do
				-- Note: because of multiple inheritance and possible (but rare)
				-- corrupted EIFGENs we need to check whether `test_class_map'
				-- already contains item for `an_ancestor'
			l_class ?= an_ancestor.original_class
			if is_valid_compiled_class (an_ancestor) and not test_class_map.has (l_class) then
				an_old_map.search (l_class)
				if an_old_map.found then
					l_test_class := an_old_map.found_item
					an_old_map.remove_found_item

						-- TODO: check last modification timestamp!
					l_parse := True
				else
					l_test_class := new_test_class (l_class)
					l_parse := True
				end
				test_class_map.force (l_test_class, l_class)
				if l_parse then
					parse_test_class (l_test_class, {!CLASS_AS} #? an_ancestor.ast)
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
				(test_class_map.has ({!EIFFEL_CLASS_I} #? an_ancestor.original_class) and
				 not an_old_map.has ({!EIFFEL_CLASS_I} #? an_ancestor.original_class))
		end

	parse_test_class (a_test_class: !EIFFEL_TEST_CLASS; a_class: !CLASS_AS) is
				-- Find test routines in class and addopt `test_routine_map' and `test_class_map'
				-- accordingly. For new routines a EIFFEL_TEST_I instance will be created and
				-- added to maps. For existing routines the EIFFEL_TEST_I instance should
				-- reevaluate the test routine to see if there were any changes. Routines not
				-- existing any longer will be removed from maps.
				--
				-- `a_class_as': syntax tree of class in which to look for test routines
				-- `a_name': name of `a_class' (provided here for consistency of map keys)
			require
				a_class_registered: test_class_map.has (a_test_class.eiffel_class)
			local
				l_names: !DS_HASH_SET [!STRING]
				l_features: like valid_features
				l_cursor: DS_HASH_SET_CURSOR [!STRING]
				l_et: !EIFFEL_TEST_I
				l_ctags, l_ftags: !DS_HASH_SET [!STRING]
			do
				l_names := test_class_map.item (a_test_class.eiffel_class).internal_names
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
					l_cursor := l_names.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					test_routine_map.search (test_identifier (a_test_class.eiffel_class, l_cursor.item))
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
						if l_et.has_changed then
							test_changed_event.publish ([Current, l_et])
							l_et.clear_changes
						end
						l_features.remove_found_item
						l_cursor.forth
					else
						test_routine_map.remove_found_item
						test_removed_event.publish ([Current, l_et])
						l_names.remove (l_cursor.item)
					end
				end

					-- Following loop adds any test still listed in `l_features'
				from
					l_features.start
				until
					l_features.after
				loop
					l_names.force (l_features.key_for_iteration)
					l_et := new_test (l_features.key_for_iteration, a_test_class)
					if {l_ficlause2: !INDEXING_CLAUSE_AS} l_features.item_for_iteration.indexes then
						l_ftags := l_ctags.cloned_object
						add_tags (l_ficlause2, l_ftags)
					else
						l_ftags := l_ctags
					end
					l_et.set_explicit_tags (l_ftags)
					test_routine_map.force (l_et, test_identifier (a_test_class.eiffel_class, l_features.key_for_iteration))
					l_et.clear_changes
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

feature {NONE} -- Factory

	new_test_class (a_class: !EIFFEL_CLASS_I): !EIFFEL_TEST_CLASS
			-- Create new test class
			--
			-- `a_class': Class for which new test class shall be created
			-- `Result'" new {EIFFEL_TEST_CLASS} instance
		do
			create Result.make (a_class)
		end

	new_test (a_routine_name: !STRING; a_class: !EIFFEL_TEST_CLASS): !EIFFEL_TEST_I
			-- Create new test
			--
			-- `a_routine_name': Name of routine which represents test.
			-- `a_class': Class in which routine is defined.
			-- `Result': new {EIFFEL_TEST_I} instance
		do
			create {EIFFEL_TEST} Result.make (a_routine_name, class_name (a_class.eiffel_class))
		end

end
