indexing

	description:

		"Finds (relevant) manual unit test classes given a certain test scope"

	copyright: "Copyright (c) 2004-2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_MANUAL_TEST_CASE_LOCATOR

inherit
	REFACTORING_HELPER

create

	make

feature {NONE} -- Initialization

	make (a_system: like system) is
			-- Create a new client/supplier relationship tester.
		require
			a_system_not_void: a_system /= Void
		do
			system := a_system
			test_case_ancestor := a_system.universe.classes_with_name ("AUT_TEST_CASE").first.compiled_representation
		ensure
			system_set: system = a_system
		end

feature -- Settings

	locate (a_test_scope: DS_LINEAR [CLASS_C]; a_deep: BOOLEAN) is
			-- Locate relevant test case classes for `a_test_scope'.
			-- Make result available via `relevant_test_case_classes'. A
			-- relevant test case is a test case that depends on a class
			-- in the test scope. `a_deep' means that dependece is
			-- checked recursively.
		require
			a_test_scope_not_void: a_test_scope /= Void
			no_void_test_scope: not a_test_scope.has (Void)
		local
--			l_scope_cursor: DS_LINEAR_CURSOR [ET_CLASS]
--			l_providers: DS_HASH_SET [ET_CLASS]
--			l_cursor: DS_HASH_TABLE_CURSOR [ET_CLASS, ET_CLASS_NAME]
--			l_class: ET_CLASS
		do
			to_implement ("TO implement")
--			create relevant_test_case_classes.make (universe.classes.count)
--			l_scope_cursor := a_test_scope.new_cursor
--			l_cursor := universe.classes.new_cursor
--			from
--				l_cursor.start
--			until
--				l_cursor.after
--			loop
--				l_class := l_cursor.item
--				if l_class.ancestors_built and then not l_class.has_ancestors_error then
--					if test_case_ancestor /= Void and then l_class.has_ancestor (test_case_ancestor) then
--						if a_test_scope.has (l_class) then
--							relevant_test_case_classes.put_last (l_class)
--						else
--							if a_deep then
--								-- Keep descendants of `test_case_ancestor' which are
--								-- recursive dependants of one of the classes
--								-- under test.
--								l_providers := recursive_providers (l_class)
--							else
--								-- Keep descendants of `test_case_ancestor' which are
--								-- direct clients of one of the classes under test.
--								process_degree_3 (l_class)
--								l_providers := l_class.suppliers
--							end
--							if l_providers /= Void and then not l_providers.is_empty then
--								from
--									l_scope_cursor.start
--								until
--									l_scope_cursor.after
--								loop
--									if l_providers.has (l_scope_cursor.item) then
--										relevant_test_case_classes.put_last (l_class)
--										l_scope_cursor.go_after -- Jump out of the loop.
--									else
--										l_scope_cursor.forth
--									end
--								end
--							end
--						end
--					end
--				end
--				l_cursor.forth
--			end
--		ensure
--			relevant_test_case_classes_not_void: relevant_test_case_classes /= Void
--			no_void_relevant_test_case_class: not relevant_test_case_classes.has (Void)
		end

feature -- Status report

	is_test_case_class (a_class: CLASS_C): BOOLEAN is
			-- Is `a_class' a manual unit test classs?
		require
			a_class_not_void: a_class /= Void
		do
			Result := test_case_ancestor /= Void and then ancestors (a_class).has (test_case_ancestor)
		ensure
			definition: Result = (test_case_ancestor /= Void) and then ancestors (a_class).has (test_case_ancestor)
		end

	is_test_procedure (a_procedure: FEATURE_I): BOOLEAN is
			-- Is `a_procedure' a test procedure?
			-- (Test procedure by definition start with `test_procedure_prefix'.)
		require
			a_procedure_not_void: a_procedure /= Void
		do
			to_implement ("To implement")
			Result := (a_procedure.feature_name.count >= test_procedure_prefix.count and then
						a_procedure.feature_name.substring (1, test_procedure_prefix.count).is_case_insensitive_equal
							(test_procedure_prefix))
		ensure
			definition: Result = (a_procedure.feature_name.count >= test_procedure_prefix.count and then
									a_procedure.feature_name.substring (1, test_procedure_prefix.count).is_case_insensitive_equal
										(test_procedure_prefix))
		end

feature -- Access

	relevant_test_case_classes: DS_HASH_SET [CLASS_C]
			-- Last result of `locate'. Test case classes from
			-- `test_case_classes' that are relevant for the classes in
			-- `a_test_scope' (from the last call to `locate'). Depending
			-- on the algorithm used the relevant test case classes are
			-- either directly or indirectly depending on the classes in
			-- the test scope.

	system: SYSTEM_I
			-- Eiffel universe

feature {NONE} -- Implementation

	test_case_ancestor: CLASS_C
			-- Ancestor class to all manual test case classes

	test_procedure_prefix: STRING is "test_"
			-- Prefix of test routines

--	recursive_providers (a_class: ET_CLASS): DS_HASH_SET [ET_CLASS] is
--			-- Providers (recursively) of `a_class'
--		require
--			a_class_not_void: a_class /= Void
--		local
--			l_providers: DS_HASH_SET [ET_CLASS]
--			l_cursor: DS_HASH_SET_CURSOR [ET_CLASS]
--		do
--			l_providers := a_class.providers
--			if l_providers /= Void then
--				create Result.make (2 * l_providers.count)
--				l_cursor := l_providers.new_cursor
--				from l_cursor.start until l_cursor.after loop
--					Result.put_last (l_cursor.item)
--					l_cursor.forth
--				end
--				from Result.start until Result.after loop
--					l_providers := Result.item_for_iteration.providers
--					if l_providers /= Void then
--						l_cursor := l_providers.new_cursor
--						from l_cursor.start until l_cursor.after loop
--							Result.force_last (l_cursor.item)
--							l_cursor.forth
--						end
--					end
--					Result.forth
--				end
--			end
--		end

--	process_degree_3 (a_class: ET_CLASS) is
--			-- Make sure that Degree 3 has been processed on `a_class'.
--		require
--			a_class_not_void: a_class /= Void
--		local
----			supplier_builder: ET_SUPPLIER_BUILDER
----			l_suppliers: DS_HASH_SET [ET_CLASS]
--		do
----			create supplier_builder.make (universe)
----			create supplier_builder.make
----			a_class.reset_implementation_checked
----			create l_suppliers.make_default
----			a_class.set_suppliers (l_suppliers)
----			supplier_builder.set (a_class, a_class.suppliers)
----			universe.set_supplier_handler (supplier_builder)
----			a_class.process (universe.implementation_checker)
----			universe.set_supplier_handler (Void)
----		ensure
----			suppliers_built: a_class.suppliers /= Void
--		end

	ancestors (a_class: CLASS_C): DS_HASH_SET [CLASS_C] is
			-- Ancestors of `a_class'.
		require
			a_class_attached: a_class /= Void
		local
			l_recursive_ancestors: DS_HASH_SET [CLASS_C]
		do
			create l_recursive_ancestors.make (20)
			compute_recursive_ancestors (a_class, l_recursive_ancestors)
		ensure
			result_attached: Result /= Void
		end

	compute_recursive_ancestors (a_class: CLASS_C; a_ancestors: DS_HASH_SET [CLASS_C]) is
			-- Compute all the recursive ancestors for `a_class' and store result in `a_ancestors'.
		require
			a_class_not_void: a_class /= Void
		local
			l_classes: LIST [CLASS_C]
		do
			a_ancestors.put (a_class)
			from
				l_classes := a_class.parents_classes
				l_classes.start
			until
				l_classes.after
			loop
				compute_recursive_ancestors (l_classes.item, a_ancestors)
				l_classes.forth
			end
		end

invariant

	system_not_void: system /= Void

end
