indexing
	description: "[
					Finder to find all test case classes.
					
					No need to compile since this class query information from CLASS_I.
																						]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_TEST_CASE_FINDER

feature -- Command

	add_hook is
			-- Add hook `add_all_test_case_classes_to_compile' to {SYSTEM_I}.rebuild_configuration_actions
		local
			l_shared: SHARED_WORKBENCH
		do
			if agent_cell.item = Void then
				create l_shared
				agent_cell.put (agent add_all_test_case_classes_to_compile)
				l_shared.system.rebuild_configuration_actions.extend (agent_cell.item)
			end
		ensure
			added: agent_cell.item /= Void
		end

	remove_hook is
			-- Remove `add_all_test_case_classes_to_compile' hook
		local
			l_shared: SHARED_WORKBENCH
		do
			if agent_cell.item /= Void then
				create l_shared
				l_shared.system.rebuild_configuration_actions.prune_all  (agent_cell.item)
				agent_cell.replace (Void)
			end
		ensure
			cleared: agent_cell.item = Void
		end

feature -- Query

	conf_class_of (a_class_name: !STRING): CONF_CLASS is
			-- Result void if not found
		local
			l_class_i: CLASS_I
		do
			l_class_i := class_i_of (a_class_name)

			if l_class_i /= Void then
				Result := l_class_i.actual_class.config_class
			end
		end

	class_i_of (a_class_name: !STRING): CLASS_I is
			-- Result void if not found
			-- Find unique Result of `a_class_name'
		local
			l_universe: UNIVERSE_I
			l_shared: SHARED_WORKBENCH
			l_list: LIST [CLASS_I]
			l_all_test_cases: like all_test_case_classes
		do
			create l_shared
			l_universe := l_shared.universe

			l_list := l_universe.classes_with_name (a_class_name.as_upper)
			if l_list.count = 1 then
				Result := l_list.first
			elseif l_list.count > 1  then
				-- We found in `all_test_case_classes' again to find the unique CLASS_I

				from
					l_all_test_cases := all_test_case_classes
					l_list.start
				until
					l_list.after or Result /= Void
				loop
						-- FIXIT: eweasel result's output only have CLASS_NAME, how can I identify which class should be
						-- if there are duplicated classes with same name.
						-- Now, we first find the item in system. If we found duplicated classes, the find the item
						-- again in all known test case classes
						-- If test cases classes have same class names? How to handle?
					if l_all_test_cases.has (l_list.item) then
						Result := l_list.item
					end
					l_list.forth
				end
				check found: Result /= Void end
			end
		end

	is_test_case_class (a_class: CLASS_I): BOOLEAN is
			-- If `a_class' is test case class?
		local
			l_string: !STRING
		do
			if {l_class: CLASS_I} a_class then
				create l_string.make_from_string ("test_case")
				Result := is_class_with_indexing (l_class, l_string)
			end
		end

	all_test_case_classes: !ARRAYED_LIST [CLASS_I] is
			-- All test case classes in Current whole system
		once
			create Result.make (100)
		end

feature {NONE} -- Implementation

	agent_cell: !CELL [PROCEDURE [ES_EWEASEL_TEST_CASE_FINDER, TUPLE]] is
			-- Agent cell for `add_all_test_case_classes_to_compile'
		once
			create Result.put (Void)
		end

	add_all_test_case_classes_to_compile is
			-- Find all test case classes and force compile
		local
			l_shared: SHARED_WORKBENCH
			l_all_classes: DS_HASH_SET [CLASS_I]
			l_cursor: DS_HASH_SET_CURSOR [CLASS_I]
			l_system_i: SYSTEM_I
			l_unref_classes: ARRAYED_LIST [CLASS_I]
		do
			create l_shared
			l_all_classes := l_shared.universe.all_classes
			l_system_i := l_shared.system
			all_test_case_classes.wipe_out
			from
				l_unref_classes := l_system_i.unref_classes_snapshot
				l_cursor := l_all_classes.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				if {lt_class_i: CLASS_I} l_cursor.item then
					if is_test_case_class (lt_class_i) then
						all_test_case_classes.extend (l_cursor.item)

						if not l_cursor.item.group.is_used_in_library and then
							not l_unref_classes.has (l_cursor.item) then

							l_system_i.add_unref_class (l_cursor.item)
						end
					end
				end

				l_cursor.forth
			end
		end

	is_class_with_indexing (a_class: !CLASS_I; a_indexing_to_test: !STRING): BOOLEAN is
			-- If `a_class''s class indexing have the key `a_indexing_to_test' ?
		local
			l_tag: ID_AS
			l_parser: EIFFEL_PARSER
			l_testing_factory: ES_EWEASEL_TEST_AST_FACTORY
			l_file: KL_BINARY_INPUT_FILE
			l_class_c: CLASS_C
			l_top_indexes: INDEXING_CLAUSE_AS
			l_index_item: INDEX_AS
			l_name: STRING
		do
			l_class_c := a_class.compiled_class
			if l_class_c /= Void and then l_class_c.has_ast then
				l_top_indexes := l_class_c.ast.top_indexes
			else
				-- If class not compiled, we parse it
				create l_testing_factory
				create l_parser.make_with_factory (l_testing_factory)
				create l_file.make (a_class.file_name)
				l_file.open_read
				l_parser.parse (l_file)
				l_top_indexes := l_testing_factory.top_indexing
				l_file.close
			end

			if l_top_indexes /= Void then
				from
					l_top_indexes.start
				until
					l_top_indexes.after or Result
				loop
					l_index_item := l_top_indexes.item
					if l_index_item /= Void then
						l_tag:= l_index_item.tag
						l_name := l_tag.name
						if l_name /= Void then
							Result := l_name.is_equal (a_indexing_to_test)
						end
					end
					l_top_indexes.forth
				end
			end
		end

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
