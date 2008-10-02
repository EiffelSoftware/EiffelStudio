indexing
	description: "[
		Objects that implement {EIFFEL_TEST_CLASS_LOCATOR_I} by traversing the parent clause and
		analysing the inheritance structure of a potential test class.
		
		Note: {EIFFEL_TEST_UNCOMPILED_LOCATOR} is the counterpart to {EIFFEL_TEST_COMPILED_LOCATOR},
		      which means they are optimized so each of them locates disjoint subsets of test classes.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_UNCOMPILED_LOCATOR

inherit
	EIFFEL_TEST_CLASS_LOCATOR

	CONF_ITERATOR
		rename
			class_name as conf_class_name
		redefine
			process_cluster,
			process_library
		end

	SHARED_ERROR_HANDLER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create traversed_descendants.make_default
			create traversed_helpers.make_default
		end

feature {NONE} -- Access

	inheritance_parser: !EIFFEL_PARSER
			-- Parser for retrieving inheritance information only
		once
			create Result.make_with_factory (inheritance_ast_factory)
		end

	inheritance_ast_factory: !EIFFEL_TEST_INHERITANCE_AST_FACTORY
			-- Factory for retrieving inheritance information from uncompiled classes
		once
			create Result.make
		end

	cached_common_ancestor: like common_ancestor
			-- Cache for `common_ancestor'

	traversed_descendants: !DS_HASH_SET [!EIFFEL_CLASS_I]
			-- Cached classes which are descendants of {TEST_SET}

	traversed_helpers: !DS_HASH_SET [!EIFFEL_CLASS_I]
			-- Cached ancestors which are not descendants of {TEST_SET}

feature {NONE} -- Query

	is_test_class (a_class: !EIFFEL_CLASS_I): BOOLEAN
			-- <Precursor>
		do
			Result := is_descendant (a_class, False)
		end

	has_tests_cluster_parent (a_cluster: CONF_CLUSTER): BOOLEAN
			-- Is cluster (indirect) child of a tests cluster?
		local
			l_cluster: CONF_CLUSTER
		do
			from
				l_cluster := a_cluster
			until
				l_cluster = Void or Result
			loop
				Result := {l_tcluster: CONF_TEST_CLUSTER} l_cluster
				l_cluster := l_cluster.parent
			end
		end

feature {NONE} -- Basic functionality

	locate_classes is
			-- <Precursor>
		local
			l_list: !DS_LINEAR [!EIFFEL_CLASS_I]
		do
			cached_common_ancestor := common_ancestor
			traversed_descendants.wipe_out
			traversed_helpers.wipe_out
			if cached_common_ancestor /= Void then
				process_target (project.eiffel_project.universe.target)
			end
		end

feature {NONE} -- Implementation: uncompiled test retrieval

	report_potential_test_class (a_class: !EIFFEL_CLASS_I) is
			-- Report class as potential test class if it inherits from {TEST_SET}
			--
			-- `a_class': Class to be reported.
		local
			l_file: KL_BINARY_INPUT_FILE
			l_class_as: !CLASS_AS
		do
			if is_descendant (a_class, False) then
				project.report_test_class (a_class)
			end
		end

	is_descendant (a_class: !EIFFEL_CLASS_I; a_cache: BOOLEAN): BOOLEAN is
			-- Is class descendant of {TEST_SET}?
			--
			-- `a_class': Class for which it should be determined whether it is a descendant of {TEST_SET}.
			-- `a_cache': If True, `a_class' will be cached in either `traversed_descendants' or
			--            `traversed_helpers'. This should be False for actual test classes, since they are
			--            generally not parents of other test classes.
		require
			a_class_in_project: project.is_class_in_project (a_class)
			ancestor_exists: cached_common_ancestor /= Void
		local
			l_parents: like parents_of_class
		do
			if a_class = cached_common_ancestor then
					-- `a_class' is
				Result := True
			elseif traversed_descendants.has (a_class) then
				Result := True
			elseif not (traversed_helpers.has (a_class) or a_class = project.eiffel_project.system.any_class) then
				if a_cache then
					traversed_helpers.put (a_class)
				end
					--| Note: we only check compiled parents of potential test classes, hence `a_cache' must be
					--|       true in the following statement.
				if a_class.is_compiled and a_cache and cached_common_ancestor.is_compiled then
					Result := a_class.compiled_class.conform_to (cached_common_ancestor.compiled_class)
				else
					l_parents := parents_of_class (a_class)
					from
						l_parents.start
					until
						l_parents.after or Result
					loop
						Result := is_descendant (l_parents.item_for_iteration, True)
						l_parents.forth
					end
				end
				if Result and a_cache then
					traversed_helpers.remove (a_class)
					traversed_descendants.put (a_class)
				end
			end
		ensure
			cached_correctly: a_cache implies
			    (Result = (traversed_descendants.has (a_class) or a_class = cached_common_ancestor))
			cached_correctly: a_cache implies
				(Result = (not traversed_helpers.has (a_class) or a_class = project.eiffel_project.system.any_class))
		end

	parents_of_class (a_class: !EIFFEL_CLASS_I): !DS_LINEAR [!EIFFEL_CLASS_I] is
			-- List of direct ancestors of `a_class'
			--
			-- `a_class': Class for which we want to retreive ancestors
			-- `Result': List of direct ancestors of `a_class'.
		require
			a_class_in_project: project.is_class_in_project (a_class)
			factory_reset: inheritance_ast_factory.is_reset
		local
			l_file: KL_BINARY_INPUT_FILE
			l_universe: UNIVERSE_I
			l_group: CONF_GROUP
			l_name: STRING
			l_cursor: DS_LINEAR_CURSOR [!STRING]
			l_list: !DS_ARRAYED_LIST [!EIFFEL_CLASS_I]
		do
			l_universe := project.eiffel_project.universe
			l_group := a_class.cluster
			create l_file.make (a_class.file_name)
			l_file.open_read
			if l_file.is_open_read then
				check
					error_handler_empty: error_handler.error_list.is_empty and
								error_handler.warning_list.is_empty
				end
				inheritance_parser.parse (l_file)
				create l_list.make (inheritance_ast_factory.ancestors.count)
				l_cursor := inheritance_ast_factory.ancestors.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					if {l_class: !EIFFEL_CLASS_I} l_universe.safe_class_named (l_cursor.item, l_group) then
						l_list.put_last (l_class)
					end
					l_cursor.forth
				end
				l_file.close
				inheritance_ast_factory.reset
				inheritance_parser.reset
				error_handler.wipe_out
			else
				create l_list.make (0)
			end
			Result := l_list
		ensure
			factory_reset: inheritance_ast_factory.is_reset
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- <Precursor>
		require else
			locating: is_locating
		local
			l_ht: HASH_TABLE [CONF_CLASS, STRING]
		do
			if has_tests_cluster_parent (a_cluster) then
				l_ht := a_cluster.classes
				from
					l_ht.start
				until
					l_ht.after
				loop
					if {l_class: !EIFFEL_CLASS_I} l_ht.item_for_iteration then
						if not l_class.is_compiled then
							report_potential_test_class (l_class)
						end
					end
					l_ht.forth
				end
			end
		end

	process_library (a_library: CONF_LIBRARY) is
			-- <Precursor>
			--
			-- Note: if library is not read only, we will look for tests.
		do
			Precursor (a_library)
			if not a_library.is_readonly and a_library.library_target /= Void then
				process_target (a_library.library_target)
			end
		end

end
