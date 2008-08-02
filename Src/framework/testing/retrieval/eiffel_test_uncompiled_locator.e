indexing
	description: "[
		Objects that scan a project for tests by traversing classes in testing clusters and analysing
		their inheritance structure.
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
			process_test_cluster
		end

	SHARED_ERROR_HANDLER

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

feature {NONE} -- Implementation: uncompiled test retrieval

	test_cluster_depth: NATURAL
			-- How many of the current's clusters parents are test clusters?

	traversed_descendants: ?DS_HASH_SET [!EIFFEL_CLASS_I]

	traversed_helpers: ?DS_HASH_SET [!EIFFEL_CLASS_I]

	cached_common_ancestor: like common_ancestor

	locate_classes is
			-- <Precursor>
		local
			l_list: !DS_LINEAR [!EIFFEL_CLASS_I]
		do
			cached_common_ancestor := common_ancestor
			if cached_common_ancestor /= Void then
				create traversed_descendants.make_default
				create traversed_helpers.make_default

				test_cluster_depth := 0
				process_target (project.project.universe.target)

				traversed_descendants := Void
				traversed_helpers := Void
			end
		end

	add_potential_test_class (a_class: !EIFFEL_CLASS_I) is
			--
		local
			l_file: KL_BINARY_INPUT_FILE
			l_class_as: !CLASS_AS
		do
			if is_descendant (a_class) then
				project.report_test_class (a_class)
			end
		end

	is_descendant (a_class: !EIFFEL_CLASS_I): BOOLEAN is
			--
		require
			a_class_in_project: project.is_class_in_project (a_class)
			ancestor_exists: cached_common_ancestor /= Void
		local
			l_parents: like parents_of_class
			l_ancestor: EIFFEL_CLASS_I
		do
			l_ancestor := cached_common_ancestor
			if a_class = l_ancestor then
				Result := True
			elseif project.is_class_in_project (a_class) then
				Result := True
			elseif traversed_descendants.has (a_class) then
				Result := True
			elseif not (traversed_helpers.has (a_class) or a_class = project.project.system.any_class) then
				traversed_helpers.put (a_class)
				if a_class.is_compiled then
					if l_ancestor.is_compiled /= Void then
						Result := a_class.compiled_class.conform_to (l_ancestor.compiled_class)
					end
				else
					l_parents := parents_of_class (a_class)
					from
						l_parents.start
					until
						l_parents.after or Result
					loop
						Result := is_descendant (l_parents.item_for_iteration)
					end
				end
				if Result then
					traversed_helpers.remove (a_class)
					traversed_descendants.put (a_class)
				end
			end
		ensure
			result_equals_descendant: Result = (traversed_descendants.has (a_class) or
				project.is_class_in_project (a_class) or a_class = cached_common_ancestor)
			result_equals_not_helper: Result = (not traversed_helpers.has (a_class) or
				a_class = project.project.system.any_class)
		end

	parents_of_class (a_class: !EIFFEL_CLASS_I): !DS_LINEAR [!EIFFEL_CLASS_I] is
			-- List of direct ancestors of `a_class'
			--
			-- `a_class': Class for which we want to retreive ancestors
			-- `Result': List of direct ancestors of `a_class'.
		require
			a_class_not_compiled: not a_class.is_compiled
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
			l_universe := project.project.universe
			l_group := a_class.cluster
			create l_file.make (a_class.file_name)
			l_file.open_read
			if l_file.is_open_read then
				inheritance_parser.parse (l_file)
				create l_list.make (inheritance_ast_factory.ancestors.count)
				l_cursor := inheritance_ast_factory.ancestors.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					if {l_class: !EIFFEL_CLASS_I} l_universe.class_named (l_cursor.item, l_group) then
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
			if test_cluster_depth > 0 then
				l_ht := a_cluster.classes
				from
					l_ht.start
				until
					l_ht.after
				loop
					if {l_class: !EIFFEL_CLASS_I} l_ht.item_for_iteration then
						if not l_class.is_compiled then
							add_potential_test_class (l_class)
						end
					end
					l_ht.forth
				end
			end
			if {l_list: ARRAYED_LIST [CONF_CLUSTER]} a_cluster.children then
				l_list.do_all (agent {CONF_CLUSTER}.process (Current))
			end
		end

	process_test_cluster (a_test_cluster: CONF_TEST_CLUSTER) is
			-- <Precursor>
		require else
			locating: is_locating
		do
			test_cluster_depth := test_cluster_depth + 1
			process_cluster (a_test_cluster)
			test_cluster_depth := test_cluster_depth - 1
		end


end
