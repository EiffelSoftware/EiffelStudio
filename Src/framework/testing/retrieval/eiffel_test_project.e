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

	SHARED_TEST_ROUTINES
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
				agent (n: !STRING; c: !EIFFEL_CLASS_I; l: !DS_LIST [!EIFFEL_TEST_I])
					local
						l_id: !STRING
					do
						l_id := test_identifier (c, n)
						l.put_last (test_routine_map.item (l_id))
					end (?, a_class, l_list))
		end

feature {NONE} -- Query

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
					if test_class_map.found then
						create old_class_map.make (1)
						old_class_map.put (test_class_map.found_item, test_class_map.found_key)
						test_class_map.remove_found_item
					end
					if l_is_test_class then
						report_test_class (a_class)
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
				test_routine_map.search (test_identifier (a_test_class.eiffel_class, l_cursor.item))
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
					add_note_tags (l_ficlause2, l_ftags)
				else
					l_ftags := l_ctags
				end
				l_et.set_explicit_tags (l_ftags)
				if l_et.has_changed then
					l_et.clear_changes
				end
				test_routine_map.force (l_et, test_identifier (a_test_class.eiffel_class, l_features.key_for_iteration))
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
					l_name :=  test_identifier (old_class_map.item_for_iteration.eiffel_class, l_cursor.item)
					test_routine_map.search (l_name)
					check
						test_exists: test_routine_map.found
					end
					l_et := test_routine_map.found_item
					test_routine_map.remove_found_item
					test_removed_event.publish ([Current, l_et])
					l_cursor.forth
				end
				is_test_class_map_modified := True
				old_class_map.forth
			end
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
			l_root, l_current: CONF_GROUP
			l_cluster: CONF_CLUSTER
			l_library: CONF_LIBRARY
			l_uni: UNIVERSE_I
			l_clist: LIST [CLASS_I]
			l_list: LIST [!CONF_LIBRARY]
			l_class: CLASS_I
			l_array: DS_ARRAYED_LIST [!CONF_GROUP]
		do
			if not eiffel_project.system.system.root_creators.is_empty then
				l_root := eiffel_project.system.system.root_creators.first.cluster
				l_uni := eiffel_project.universe
				l_class := l_uni.safe_class_named (a_class_name, l_root)
			end
			if l_class = Void then
				l_clist := l_uni.classes_with_name (a_class_name)
				if l_clist /= Void and then not l_clist.is_empty then
					l_class := l_clist.first
				end
			end
			if l_class /= Void then
				from
					l_current := l_class.group
				until
					l_current = Void
				loop
					cluster_stack.put_last (l_current)
					l_cluster ?= l_current
					l_current := Void
					if l_cluster /= Void then
						if l_cluster.parent /= Void then
							l_current := l_cluster.parent
						elseif l_cluster.is_used_in_library then
							if {l_uuid: !UUID} l_cluster.target.system.uuid then
								l_list := l_uni.library_of_uuid (l_uuid, True)
								if not l_list.is_empty then
									cluster_stack.put_last (l_list.first)
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
		ensure
			cluster_stack_empty: cluster_stack.is_empty
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

end
