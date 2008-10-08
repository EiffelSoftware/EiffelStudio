indexing
	description: "[
		Objects that will scan an eiffel project in order to find classes containing tests.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_PROJECT

inherit
	EIFFEL_TEST_PROJECT_I

	EIFFEL_TEST_COLLECTION
		rename
			make as make_collection,
			are_tests_available as is_project_initialized
		end

	CONF_ACCESS

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_TEST_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make_with_project (a_project: like eiffel_project)
			-- Initialize `Current'.
		local
			l_manager: EB_PROJECT_MANAGER
		do
			make_collection

			internal_project := a_project
			l_manager := internal_project.manager
			l_manager.load_agents.force (agent synchronize)
			l_manager.compile_stop_agents.extend (agent synchronize)
			l_manager.compile_start_agents.extend (agent update_root_class)

				-- Create storage
			create test_class_map.make (0)
			create test_routine_map.make_default
			create locators.make
			create cluster_stack.make_default
		ensure
			project_set: eiffel_project = a_project
		end

feature -- Access

	eiffel_project: !E_PROJECT is
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

	last_created_class: ?EIFFEL_CLASS_I

feature {EIFFEL_TEST_CLASS_LOCATOR_I} -- Access

	common_ancestor: !EIFFEL_CLASS_I
			-- Ancestor all test classes must inherit from
		do
			Result ?= internal_ancestor
		end

feature {NONE} -- Access

	internal_project: like eiffel_project
			-- Internal storage of `eiffel_project'

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

	locators: !DS_LINKED_LIST [!EIFFEL_TEST_CLASS_LOCATOR_I]
			-- Locators for retrieving test classes

	internal_ancestor: ?EIFFEL_CLASS_I
			-- Class from which all test classes must inherit from.

	old_class_map: ?like test_class_map
			-- Temporary storage for old instance of `test_class_map'

	test_root_cluster: ?CONF_CLUSTER
			-- Internal cluster containing testing root classes

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

	is_locator_registered (a_locator: !EIFFEL_TEST_CLASS_LOCATOR_I): BOOLEAN
			-- <Precursor>
		do
			Result := locators.has (a_locator)
		end

feature {NONE} -- Status report

	is_test_class_map_modified: BOOLEAN
			-- Has `test_class_map' changed since last call to `update_root_class'?

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
				agent (n: !STRING; c: !EIFFEL_TEST_CLASS; l: !DS_LIST [!EIFFEL_TEST_I])
					local
						l_id: !STRING
					do
						l_id := test_identifier (c, n)
						l.put_last (test_routine_map.item (l_id))
					end (?, l_test_class, l_list))
		end

	class_for_test (a_test: !EIFFEL_TEST_I): ?EIFFEL_CLASS_I
			-- <Precursor>
		do
			Result := class_for_name (a_test.class_name)
		end

	feature_for_test (a_test: !EIFFEL_TEST_I): ?E_FEATURE
			-- <Precursor>
		do
			if {l_class: !EIFFEL_CLASS_C} compiled_class_for_test (a_test) then
				Result := l_class.feature_with_name (a_test.name)
			end
		end

feature {NONE} -- Query

	is_valid_feature (a_feature_as: !FEATURE_AS): BOOLEAN is
			-- Is `a_feature_as' the syntax of a valid test routine?
		do
			Result := (a_feature_as.body.arguments = Void or else a_feature_as.body.arguments.is_empty) and
				not a_feature_as.is_function and not a_feature_as.is_attribute and (test_routine_name (a_feature_as) /= Void)
		end

	is_valid_class_as (a_class: !CLASS_AS): BOOLEAN
			-- Can `a_class' be a syntactical representation of a class containing tests?
		do
			Result := not a_class.is_deferred and then
				(a_class.creators = Void or else a_class.creators.is_empty)
		end

	is_valid_feature_clause (a_clause_as: !FEATURE_CLAUSE_AS): BOOLEAN is
			-- Is `a_clause_as' exported to ANY?
		require
			a_clause_as_not_void: a_clause_as /= Void
		local
			l_list: CLASS_LIST_AS
			l_old_cs: CURSOR
		do
			if a_clause_as.clients /= Void then
				l_list := a_clause_as.clients.clients
				from
					l_old_cs := l_list.cursor
					l_list.start
				until
					Result or l_list.after
				loop
					Result := l_list.item.name.is_case_insensitive_equal ("ANY")
					l_list.forth
				end
				l_list.go_to (l_old_cs)
			else
				Result := True
			end
		end

	is_valid_routine_name (a_name: !STRING): BOOLEAN is
			-- Is `a_name' a valid test routine name?
		do
			Result := not (a_name.is_equal (setup_routine_name) or a_name.is_equal (tear_down_routine_name))
		ensure
			result_implies_not_setup: Result implies not a_name.is_equal (setup_routine_name)
			result_implies_not_tear_down: Result implies not a_name.is_equal (tear_down_routine_name)
		end

	class_name (a_class: !CLASS_I): !STRING is
			-- Name of `a_class' in upper case.
		do
			Result ?= a_class.name.as_upper
		ensure
			result_not_empty: not Result.is_empty
		end

	test_routine_name (a_feature: !FEATURE_AS): ?STRING is
			-- First valid test routine name in `a_feature', Void if there are none
		local
			l_name: !STRING
			l_names: EIFFEL_LIST [FEATURE_NAME]
			l_cs: CURSOR
		do
			l_names := a_feature.feature_names
			from
				l_cs := l_names.cursor
				l_names.start
			until
				l_names.after or Result /= Void
			loop
				l_name ?= l_names.item.internal_name.name.as_lower
				if is_valid_routine_name (l_name) then
					Result := l_name
				else
					l_names.forth
				end
			end
			l_names.go_to (l_cs)
		ensure
			result_attached_implies_valid: (Result /= Void) implies
				is_valid_routine_name ({!STRING} #? Result)
		end

	valid_features (a_class: !CLASS_AS): !DS_HASH_TABLE [!FEATURE_AS, !STRING] is
			-- Hash table with test routines of `a_class' where the key
			-- is the name of the feature
		local
			l_fcl: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_fl: EIFFEL_LIST [FEATURE_AS]
			l_old_fcl, l_old_fl: CURSOR
		do
			create Result.make_default
			if a_class.features /= Void then
				from
					l_fcl := a_class.features
					l_old_fcl := l_fcl.cursor
					l_fcl.start
				until
					l_fcl.after
				loop
					if is_valid_feature_clause ({!FEATURE_CLAUSE_AS} #? l_fcl.item) then
						from
							l_fl := l_fcl.item.features
							l_old_fl := l_fl.cursor
							l_fl.start
						until
							l_fl.after
						loop
							if {l_f: !FEATURE_AS} l_fl.item and then is_valid_feature (l_f) then
								Result.force (l_f, create {!STRING}.make_from_string (test_routine_name (l_f)))
							end
							l_fl.forth
						end
						l_fl.go_to (l_old_fl)
					end
					l_fcl.forth
				end
				l_fcl.go_to (l_old_fcl)
			end
		ensure
			result_has_valid_items: Result.keys.for_all (
				agent (k: !STRING; t: like valid_features): BOOLEAN
					local
						l_item: !FEATURE_AS
					do
						l_item := t.item (k)
						Result := is_valid_routine_name (k) and then
							test_routine_name (l_item).is_equal (k) and then
							is_valid_feature (l_item)
					end (?, Result))
		end

	test_identifier (a_class: !EIFFEL_TEST_CLASS; a_name: !STRING): !STRING is
			-- Create unqiue identifier for test routine
			--
			-- `a_class': Class in which test is defined.
			-- `a_name': Name of test routine
		do
			create Result.make (a_class.identifier.count + a_name.count)
			Result.append (a_class.identifier)
			Result.append (a_name)
		ensure
			result_not_empty: not Result.is_empty
		end

	test_root_cluster_path: !STRING
			-- Path for `test_root_cluster'
		require
			project_initialized: is_project_initialized
		local
			l_dir: DIRECTORY_NAME
		do
			create l_dir.make_from_string (eiffel_project.project_directory.target_path)
			l_dir.extend ("testing")
			Result := l_dir
		end

	class_for_name (a_name: !STRING): ?EIFFEL_CLASS_I
			-- Class in universe for given name
			--
			-- `a_name': Name of class to look for.
			-- `Result': Class with name `a_name', Void if no class found.
		require
			project_initialized: is_project_initialized
		local
			l_system: SYSTEM_I
			l_group: CONF_GROUP
			l_list: LIST [CLASS_I]
		do
			l_system := eiffel_project.system.system
			if not l_system.root_creators.is_empty then
				l_group := l_system.root_creators.first.cluster
				Result ?= eiffel_project.universe.safe_class_named (a_name, l_group)
			end
			if Result = Void then
				l_list := eiffel_project.universe.classes_with_name (a_name)
				from
					l_list.start
				until
					l_list.after or Result /= Void
				loop
					Result ?= l_list.item_for_iteration
					l_list.forth
				end
			end
		end

feature -- Status setting

	synchronize
			-- <Precursor>
		local
			l_old_class_map: like test_class_map
			l_ancestor: EIFFEL_CLASS_C
		do
			if not is_updating_tests then
				is_updating_tests := True
				if is_project_initialized then
					if eiffel_project.successful then
						old_class_map := test_class_map
						create test_class_map.make (old_class_map.count)
						locators.do_all (agent {!EIFFEL_TEST_CLASS_LOCATOR_I}.locate_classes (Current))
						remove_old_classes
						old_class_map := Void
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

	synchronize_with_class (a_class: !EIFFEL_CLASS_I) is
			-- <Precursor>
		local
			l_is_test_class: BOOLEAN
		do
			if not is_updating_tests then
				is_updating_tests := True
				if (create {RAW_FILE}.make (a_class.file_name)).exists and then is_class_in_project (a_class) then
					l_is_test_class := locators.there_exists (agent {!EIFFEL_TEST_CLASS_LOCATOR_I}.is_test_class (a_class, Current))
				end
				test_class_map.search (a_class)
				if l_is_test_class or test_class_map.found then
					old_class_map := Void
					if test_class_map.found then
						create old_class_map.make (1)
						old_class_map.put (test_class_map.found_item, test_class_map.found_key)
						test_class_map.remove_found_item
					end
					if l_is_test_class then
						report_test_class (a_class)
						if not test_class_map.has (a_class) and old_class_map /= Void then
								-- This means even though one of the locators sees `a_class' as a test class, it has not
								-- been added. This happens for example when the class has a syntax error after the
								-- inheritance clause. However in this case, we must remove any remaining test routines
								-- which have previously been in `test_routine_map'.
							remove_old_classes
						end
					else
						remove_old_classes
					end
					old_class_map := Void
				end
				is_updating_tests := False
			end
		end

feature {NONE} -- Status setting

	update_root_class is
			-- If test classes have changed since last time `udpate_root_class' has been called, write
			-- new class referencing all test classes and register it as root clas in system.
		local
			l_system: SYSTEM_I
			l_name: FILE_NAME
			l_file: KL_TEXT_OUTPUT_FILE
		do
			if is_project_initialized and is_test_class_map_modified then
				is_test_class_map_modified := False
				create l_name.make_from_string (eiffel_project.project_directory.eifgens_cluster_path)
				l_name.extend (root_writer.class_name.as_lower)
				l_name.add_extension ("e")
				create l_file.make (l_name)
				l_file.recursive_open_write
				if l_file.is_open_write then
					root_writer.write_source (l_file, {!DS_LINEAR [!EIFFEL_CLASS_I]} #? test_class_map.keys)
					l_file.close
					l_system := eiffel_project.system.system
					if not l_system.is_explicit_root (root_writer.class_name, root_writer.root_feature_name) then
						l_system.add_explicit_root (Void, root_writer.class_name, root_writer.root_feature_name)
					end
				end
			end
		end

feature -- Element change

	register_locator (a_locator: !EIFFEL_TEST_CLASS_LOCATOR_I)
			-- <Precursor>
		do
			locators.put_last (a_locator)
		end

	unregister_locator (a_locator: !EIFFEL_TEST_CLASS_LOCATOR_I)
			-- <Precursor>
		local
			l_cursor: DS_LINKED_LIST_CURSOR [!EIFFEL_TEST_CLASS_LOCATOR_I]
		do
			l_cursor := locators.new_cursor
			l_cursor.start
			l_cursor.search_forth (a_locator)
			check
				not_off: l_cursor.off
			end
			l_cursor.remove
			l_cursor.go_after
		end

feature {NONE} -- Element change

	add_test_class (a_class: !EIFFEL_CLASS_I; a_class_as: !CLASS_AS)
			-- Add eiffel class to eiffel test class map and analyze syntax to find tests defined in class.
			--
			--| If attached, `old_class_map' is searched for any previously created eiffel test class
			--| instance. If found it will be reused instead of creating a new instance.
			--
			-- `a_class': Class for which a eiffel test class should be added to `test_class_map'.
			-- `a_class_as': Syntax representation of class
		require
			not_added: not is_test_class (a_class)
			a_class_as_valid: is_valid_class_as (a_class_as)
		local
			l_test_class: EIFFEL_TEST_CLASS
		do
			if old_class_map /= Void then
				old_class_map.search (a_class)
				if old_class_map.found then
					l_test_class := old_class_map.found_item
					old_class_map.remove_found_item
				end
			end
			if l_test_class = Void then
				l_test_class := new_test_class (a_class)
				is_test_class_map_modified := True
			end
			test_class_map.force (l_test_class, a_class)
			synchronize_test_class (l_test_class, a_class_as)
		ensure
			added: is_test_class (a_class)
		end

	synchronize_test_class (a_test_class: !EIFFEL_TEST_CLASS; a_class_as: !CLASS_AS) is
			-- Add eiffel class to eiffel test class map.
			--
			-- Note: `add_test_class' will add a {EIFFEL_TEST_CLASS} instance to `test_class_map'. In
			--       addition the class text is analysed to update `test_routine_map' with the test
			--       routines defined in the class.
			--
			-- `a_class': Class for which a eiffel test class should be added to `test_class_map'.
			-- `a_class_as': Syntax representation of class
		require
			a_test_class_valid: test_class_map.has_item (a_test_class)
			a_class_as_valid: is_valid_class_as (a_class_as)
		local
			l_names: !DS_HASH_SET [!STRING]
			l_features: like valid_features
			l_cursor: DS_HASH_SET_CURSOR [!STRING]
			l_et: !EIFFEL_TEST_I
			l_ctags, l_ftags: !DS_HASH_SET [!STRING]
			l_tag: !STRING
		do
			l_names := a_test_class.internal_names
			l_features := valid_features (a_class_as)

			create l_ctags.make_default
			l_ctags.set_equality_tester ({KL_EQUALITY_TESTER [!STRING]} #? create {KL_STRING_EQUALITY_TESTER})
			if {l_ticlause: !INDEXING_CLAUSE_AS} a_class_as.top_indexes then
				add_note_tags (l_ticlause, l_ctags)
			end
			if {l_biclause: !INDEXING_CLAUSE_AS} a_class_as.bottom_indexes then
				add_note_tags (l_biclause, l_ctags)
			end
			create l_tag.make (20)
			l_tag.append ("class")
			l_tag.append_character (tag_utilities.split_char)
			add_class_path (l_tag, {!STRING} #? a_test_class.eiffel_class.name, Void)
			l_ctags.force_last (l_tag)


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
				test_routine_map.search (test_identifier (a_test_class, l_cursor.item))
				check
					test_exists: test_routine_map.found
				end
				l_et := test_routine_map.found_item
				l_features.search (l_cursor.item)
				if l_features.found then
					if {l_ficlause: !INDEXING_CLAUSE_AS} l_features.found_item.indexes then
						l_ftags := l_ctags.cloned_object
						add_note_tags (l_ficlause, l_ftags)
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
					remove_test (test_routine_map.found_key)
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
					add_note_tags (l_ficlause2, l_ftags)
				else
					l_ftags := l_ctags
				end
				l_et.set_explicit_tags (l_ftags)
				if l_et.has_changed then
					l_et.clear_changes
				end
				test_routine_map.force (l_et, test_identifier (a_test_class, l_features.key_for_iteration))
				test_added_event.publish ([Current, l_et])
				l_features.forth
			end
		end

	remove_old_classes is
			-- Remove all test routines for any remaining test class in `old_class_map'.
		require
			old_class_map_attached: old_class_map /= Void
		local
			l_cursor: DS_LINEAR_CURSOR [!STRING]
			l_name: !STRING
			l_et: !EIFFEL_TEST_I
		do
			from
				old_class_map.start
			until
				old_class_map.after
			loop
				l_cursor := old_class_map.item_for_iteration.test_routine_names.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					l_name :=  test_identifier (old_class_map.item_for_iteration, l_cursor.item)
					remove_test (l_name)
					l_cursor.forth
				end
				is_test_class_map_modified := True
				old_class_map.forth
			end
		end

	remove_test (a_id: !STRING)
			-- Remove test for given identifier from `test_routine_map' and inform observer
		require
			has_test_for_id: test_routine_map.has (a_id)
		local
			l_test: EIFFEL_TEST_I
		do
			test_routine_map.search (a_id)
			l_test := test_routine_map.found_item
			test_routine_map.remove_found_item
			test_removed_event.publish ([Current, l_test])
		ensure
			not_has_test_for_id: not test_routine_map.has (a_id)
		end

feature {EIFFEL_TEST_CLASS_LOCATOR} -- Implementation

	report_test_class (a_class: !EIFFEL_CLASS_I) is
			-- <Precursor>
		local
			l_ast: ?CLASS_AS
			l_parser: EIFFEL_PARSER
			l_file: KL_BINARY_INPUT_FILE
		do
			if not test_class_map.has (a_class) then
				if a_class.is_compiled then
					l_ast ?= a_class.compiled_class.ast
				else
					create l_file.make (a_class.file_name)
					l_file.open_read
					if l_file.is_open_read then
						check
							error_handler_empty: error_handler.error_list.is_empty and
								error_handler.warning_list.is_empty
						end
						eiffel_parser.parse (l_file)
						l_ast := eiffel_parser.root_node
						error_handler.wipe_out
						l_file.close
					end
				end
				if l_ast /= Void and then is_valid_class_as ({!CLASS_AS} #? l_ast) then
					add_test_class (a_class, {!CLASS_AS} #? l_ast)
				end
			end
		end

feature {NONE} -- Implementation: tag retrieval

	cluster_stack: !DS_ARRAYED_LIST [!CONF_GROUP]
			-- List used as a stack by `add_class_path'

	add_tag (a_tag: !STRING; a_set: !DS_SET [!STRING]) is
			-- Add tag to set by replacing all class names with current cluster/class/feature hierarchy.
			--
			-- `a_tag': Tag to be added to set
			-- `a_set': Set to which tag is added
		require
			a_tag_not_empty: not a_tag.is_empty
			a_tag_valid: tag_utilities.is_valid_tag (a_tag)
			project_initialized: is_project_initialized
		local
			i, start: INTEGER
			l_in_class, l_in_feature: BOOLEAN
			c: CHARACTER
			l_final, l_class_name: !STRING
			l_feature_name: ?STRING
		do
			create l_final.make (a_tag.count*2)
			from
				start := 1
				i := 1
			until
				i > a_tag.count
			loop
				c := a_tag.item (i)
				if c = tag_utilities.split_char or not (c.is_alpha_numeric or c = '_') then
					if l_in_feature then
						l_in_feature := False
						if i > start + 1 then
							l_feature_name := a_tag.substring (start + 1, i - 1)
							start := i
						end
						add_class_path (l_final, l_class_name, l_feature_name)
						l_feature_name := Void
					end
					if c = '{' then
						if i > start then
							l_final.append (a_tag.substring (start, i - 1))
						end
						start := i
						l_in_class := True
					elseif l_in_class then
						l_in_class := False
						if c = '}' and i > start + 1 then
							l_class_name := a_tag.substring (start + 1, i - 1)
							start := i + 1
							if a_tag.count > i + 1 and then a_tag.item (i + 1) = '.' then
								i := i + 1
								l_in_feature := True
							else
								add_class_path (l_final, l_class_name, Void)
							end
						end
					end
				end
				i := i + 1
			end
			if l_in_feature then
				l_feature_name := a_tag.substring (start + 1, i - 1)
				add_class_path (l_final, l_class_name, l_feature_name)
			elseif start < i then
				l_final.append (a_tag.substring (start, i - 1))
			end
			a_set.force (l_final)
		ensure
			a_set_increased: a_set.count = old a_set.count + 1
		end

	add_class_path (a_tag: !STRING; a_class_name: !STRING; a_feature_name: ?STRING) is
			-- Add cluster/class/feature information to tag
			--
			-- `a_tag': Tag to which information should be added
			-- `a_class_name': Name of class for which information is added
			-- `a_feature_name': Name of feature in class (Can be Void if only class information is added)
		require
			a_class_name_not_empty: not a_class_name.is_empty
			a_feature_name_not_empty: a_feature_name /= Void implies a_feature_name /= Void
			project_initialized: is_project_initialized
		local
			l_current: CONF_GROUP
			l_cluster: CONF_CLUSTER
			l_library: CONF_LIBRARY
			l_uni: UNIVERSE_I
			l_list: LIST [!CONF_LIBRARY]
		do
			if {l_class: CLASS_I} class_for_name (a_class_name) then
				l_uni := eiffel_project.universe
				from
					l_current := l_class.group
				until
					l_current = Void
				loop
					cluster_stack.force_last (l_current)
					l_cluster ?= l_current
					l_current := Void
					if l_cluster /= Void then
						if l_cluster.parent /= Void then
							l_current := l_cluster.parent
						elseif l_cluster.is_used_in_library then
							if {l_uuid: !UUID} l_cluster.target.system.uuid then
								l_list := l_uni.library_of_uuid (l_uuid, True)
								if not l_list.is_empty then
									cluster_stack.force_last (l_list.first)
								end
							end
						end
					end
				end
				from until
					cluster_stack.is_empty
				loop
					if cluster_stack.last.is_cluster then
						a_tag.append (tag_utilities.cluster_prefix)
					elseif cluster_stack.last.is_library then
						a_tag.append (tag_utilities.library_prefix)
					end
					a_tag.append (cluster_stack.last.name)
					a_tag.append_character (tag_utilities.split_char)
					cluster_stack.remove_last
				end
				cluster_stack.wipe_out
			end
			a_tag.append (tag_utilities.class_prefix)
			a_tag.append (a_class_name)
			if a_feature_name /= Void then
				a_tag.append_character (tag_utilities.split_char)
				a_tag.append (tag_utilities.feature_prefix)
				a_tag.append (a_feature_name)
			end
		end

	add_note_tags (a_indexing_clause: !INDEXING_CLAUSE_AS; a_set: !DS_SET [!STRING])
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
							tag_utilities.find_tags_in_string (l_tags, agent add_tag (?, a_set))
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

feature {NONE} -- Implementation

	conf_factory: CONF_COMP_FACTORY
			-- Factory for creating system items
		once
			create Result
		end

	root_writer: EIFFEL_TEST_ANCHOR_ROOT_SOURCE_WRITER
			-- Source writer for creating test class list
		once
			create Result
		end

feature -- Constants

	setup_routine_name: !STRING = "setup"
			-- <Precursor>

	tear_down_routine_name: !STRING = "tear_down"
			-- <Precursor>

invariant
	cluster_stack_empty: cluster_stack.is_empty

end
