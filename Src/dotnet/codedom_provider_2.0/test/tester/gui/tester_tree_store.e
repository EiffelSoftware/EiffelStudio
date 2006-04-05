indexing
	description: "Store and retrieve codedom trees locations"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_TREE_STORE

inherit
	TESTER_TREE_DESERIALIZER

	CODE_SETTINGS_MANAGER
		export
			{NONE} all
		end

	TESTER_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

create
	load

feature {NONE} -- Initialization

	load is
			-- Load locations and initialize instance accordingly.
		local
			l_paths: STRING
			l_compile_unit: SYSTEM_DLL_CODE_COMPILE_UNIT
			l_namespace: SYSTEM_DLL_CODE_NAMESPACE
			l_type: SYSTEM_DLL_CODE_TYPE_DECLARATION
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
			l_statement: SYSTEM_DLL_CODE_STATEMENT
		do
			make ("Software\ISE\Eiffel Codedom Provider\Tester\Trees")

			l_paths := text_setting (Compile_units_key)
			if l_paths /= Void then
				compile_units_paths := l_paths.split (Location_separator)
				compile_units_paths.compare_objects
				create {ARRAYED_LIST [SYSTEM_DLL_CODE_COMPILE_UNIT]} compile_units.make (compile_units_paths.count)
				from
					compile_units_paths.start
				until
					compile_units_paths.after
				loop
					if {SYSTEM_FILE}.exists (compile_units_paths.item) then
						l_compile_unit := compile_unit_from_file (compile_units_paths.item)
					end
					if l_compile_unit /= Void then
						compile_units.extend (l_compile_unit)
						compile_units_paths.forth
					else
						compile_units_paths.remove
					end
				end
				if compile_units.is_empty then
					compile_units := Void
					compile_units_paths := Void
				end
			end

			l_paths := text_setting (Namespaces_key)
			if l_paths /= Void then
				namespaces_paths := l_paths.split (Location_separator)
				create {ARRAYED_LIST [SYSTEM_DLL_CODE_NAMESPACE]} namespaces.make (namespaces_paths.count)
				from
					namespaces_paths.start
				until
					namespaces_paths.after
				loop
					if {SYSTEM_FILE}.exists (namespaces_paths.item) then
						l_namespace := namespace_from_file (namespaces_paths.item)
					end
					if l_namespace /= Void then
						namespaces.extend (l_namespace)
						namespaces_paths.forth
					else
						namespaces_paths.remove
					end
				end
				if namespaces.is_empty then
					namespaces := Void
					namespaces_paths := Void
				end
			end

			l_paths := text_setting (Types_key)
			if l_paths /= Void then
				types_paths := l_paths.split (Location_separator)
				create {ARRAYED_LIST [SYSTEM_DLL_CODE_TYPE_DECLARATION]} types.make (types_paths.count)
				from
					types_paths.start
				until
					types_paths.after
				loop
					if {SYSTEM_FILE}.exists (types_paths.item) then
						l_type := type_from_file (types_paths.item)
					end
					if l_type /= Void then
						types.extend (l_type)
						types_paths.forth
					else
						types_paths.remove
					end
				end
				if types.is_empty then
					types := Void
					types_paths := Void
				end
			end

			l_paths := text_setting (Expressions_key)
			if l_paths /= Void then
				expressions_paths := l_paths.split (Location_separator)
				create {ARRAYED_LIST [SYSTEM_DLL_CODE_EXPRESSION]} expressions.make (expressions_paths.count)
				from
					expressions_paths.start
				until
					expressions_paths.after
				loop
					if {SYSTEM_FILE}.exists (expressions_paths.item) then
						l_expression := expression_from_file (expressions_paths.item)
					end
					if l_expression /= Void then
						expressions.extend (l_expression)
						expressions_paths.forth
					else
						expressions_paths.remove
					end
				end
				if expressions.is_empty then
					expressions := Void
					expressions_paths := Void
				end
			end

			l_paths := text_setting (Statements_key)
			if l_paths /= Void then
				statements_paths := l_paths.split (Location_separator)
				create {ARRAYED_LIST [SYSTEM_DLL_CODE_STATEMENT]} statements.make (statements_paths.count)
				from
					statements_paths.start
				until
					statements_paths.after
				loop
					if {SYSTEM_FILE}.exists (statements_paths.item) then
						l_statement := statement_from_file (statements_paths.item)
					end
					if l_statement /= Void then
						statements.extend (l_statement)
						statements_paths.forth
					else
						statements_paths.remove
					end
				end
				if statements.is_empty then
					statements := Void
					statements_paths := Void
				end
			end
		end

feature -- Access

	compile_units_paths: LIST [STRING]
			-- Compile units serialized codedeom tree locations

	namespaces_paths: LIST [STRING]
			-- Namespaces serialized codedeom tree locations

	types_paths: LIST [STRING]
			-- Types serialized codedeom tree locations

	expressions_paths: LIST [STRING]
			-- Expressions serialized codedeom tree locations

	statements_paths: LIST [STRING]
			-- Statements serialized codedeom tree locations

	compile_units: LIST [SYSTEM_DLL_CODE_COMPILE_UNIT]
			-- De-serialized compile units

	namespaces: LIST [SYSTEM_DLL_CODE_NAMESPACE]
			-- De-serialized namespaces

	types: LIST [SYSTEM_DLL_CODE_TYPE_DECLARATION]
			-- De-serialized types

	expressions: LIST [SYSTEM_DLL_CODE_EXPRESSION]
			-- De-serialized expressions

	statements: LIST [SYSTEM_DLL_CODE_STATEMENT]
			-- De-serialized statements

feature -- Basic Operations

	store is
			-- Persist all locations to disk.
		local
			l_paths: STRING
		do
			if compile_units_paths /= Void then
				from
					compile_units_paths.start
					create l_paths.make (512)
					l_paths.append (compile_units_paths.item)
					compile_units_paths.forth
				until
					compile_units_paths.after
				loop
					l_paths.append_character (Location_separator)
					l_paths.append (compile_units_paths.item)
					compile_units_paths.forth
				end
				set_text_setting (Compile_units_key, l_paths)
			end
			if namespaces_paths /= Void then
				from
					namespaces_paths.start
					create l_paths.make (512)
					l_paths.append (namespaces_paths.item)
					namespaces_paths.forth
				until
					namespaces_paths.after
				loop
					l_paths.append_character (Location_separator)
					l_paths.append (namespaces_paths.item)
					namespaces_paths.forth
				end
				set_text_setting (Namespaces_key, l_paths)
			end
			if types_paths /= Void then
				from
					types_paths.start
					create l_paths.make (512)
					l_paths.append (types_paths.item)
					types_paths.forth
				until
					types_paths.after
				loop
					l_paths.append_character (Location_separator)
					l_paths.append (types_paths.item)
					types_paths.forth
				end
				set_text_setting (Types_key, l_paths)
			end
			if expressions_paths /= Void then
				from
					expressions_paths.start
					create l_paths.make (512)
					l_paths.append (expressions_paths.item)
					expressions_paths.forth
				until
					expressions_paths.after
				loop
					l_paths.append_character (Location_separator)
					l_paths.append (expressions_paths.item)
					expressions_paths.forth
				end
				set_text_setting (Expressions_key, l_paths)
			end
			if statements_paths /= Void then
				from
					statements_paths.start
					create l_paths.make (512)
					l_paths.append (statements_paths.item)
					statements_paths.forth
				until
					statements_paths.after
				loop
					l_paths.append_character (Location_separator)
					l_paths.append (statements_paths.item)
					statements_paths.forth
				end
				set_text_setting (Statements_key, l_paths)
			end
		end

	add (a_path: STRING) is
			-- Add serialized tree at `a_path'.
		require
			non_void_path: a_path /= Void
		local
			l_type: INTEGER
		do
			if {SYSTEM_FILE}.exists (a_path) then
				l_type := codedom_type_from_file (a_path)
				inspect
					l_type
				when Codedom_compile_unit_type then
					add_compile_unit (a_path)
				when Codedom_namespace_type then
					add_namespace (a_path)
				when Codedom_type_type then
					add_type (a_path)
				when Codedom_expression_type then
					add_expression (a_path)
				when Codedom_statement_type then
					add_statement (a_path)
				else
				end
			else
				Event_manager.raise_event (create {TESTER_EVENT}.make ("Cannot add: No file at " + a_path, True))
			end
		ensure
			added_if_compile_unit: {SYSTEM_FILE}.exists (a_path) and then codedom_type_from_file (a_path) = Codedom_compile_unit_type implies compile_units_paths.has (a_path)
			added_if_namespace: {SYSTEM_FILE}.exists (a_path) and then codedom_type_from_file (a_path) = Codedom_namespace_type implies namespaces_paths.has (a_path)
			added_if_type: {SYSTEM_FILE}.exists (a_path) and then codedom_type_from_file (a_path) = Codedom_type_type implies types_paths.has (a_path)
			added_if_expression: {SYSTEM_FILE}.exists (a_path) and then codedom_type_from_file (a_path) = Codedom_expression_type implies expressions_paths.has (a_path)
			added_if_statement: {SYSTEM_FILE}.exists (a_path) and then codedom_type_from_file (a_path) = Codedom_statement_type implies statements_paths.has (a_path)
		end

	remove (a_path: STRING) is
			-- Remove serialized tree at `a_path' if in tree.
			-- Otherwise do nothing.
		require
			non_void_path: a_path /= Void
		local
			l_index: INTEGER
		do
			if compile_units_paths /= Void then
				l_index := compile_units_paths.index_of (a_path, 1)
				if l_index > 0 then
					compile_units.go_i_th (l_index)
					compile_units.remove
					compile_units_paths.go_i_th (l_index)
					compile_units_paths.remove
				end
			end
			if namespaces_paths /= Void then
				l_index := namespaces_paths.index_of (a_path, 1)
				if l_index > 0 then
					namespaces.go_i_th (l_index)
					namespaces.remove
					namespaces_paths.go_i_th (l_index)
					namespaces_paths.remove
				end
			end
			if types_paths /= Void then
				l_index := types_paths.index_of (a_path, 1)
				if l_index > 0 then
					types.go_i_th (l_index)
					types.remove
					types_paths.go_i_th (l_index)
					types_paths.remove
				end
			end
			if expressions_paths /= Void then
				l_index := expressions_paths.index_of (a_path, 1)
				if l_index > 0 then
					expressions.go_i_th (l_index)
					expressions.remove
					expressions_paths.go_i_th (l_index)
					expressions_paths.remove
				end
			end
			if statements_paths /= Void then
				l_index := statements_paths.index_of (a_path, 1)
				if l_index > 0 then
					statements.go_i_th (l_index)
					statements.remove
					statements_paths.go_i_th (l_index)
					statements_paths.remove
				end
			end
		ensure
			removed_if_compile_unit: compile_units_paths /= Void implies ((old compile_units_paths).has (a_path) implies not compile_units_paths.has (a_path))
			removed_if_namespace: namespaces_paths /= Void implies ((old namespaces_paths).has (a_path) implies not namespaces_paths.has (a_path))
			removed_if_type: types_paths /= Void implies ((old types_paths).has (a_path) implies not types_paths.has (a_path))
			removed_if_expression: expressions_paths /= Void implies ((old expressions_paths).has (a_path) implies not expressions_paths.has (a_path))
			removed_if_statement: statements_paths /= Void implies ((old statements_paths).has (a_path) implies not statements_paths.has (a_path))
		end

	add_compile_unit (a_path: STRING) is
			-- Extend `compile_units' with tree serialized at `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: {SYSTEM_FILE}.exists (a_path)
			valid_codedom_tree: compile_unit_from_file (a_path) /= Void
		do
			if compile_units_paths = Void then
				create {ARRAYED_LIST [STRING]} compile_units_paths.make (8)
				compile_units_paths.compare_objects
				create {ARRAYED_LIST [SYSTEM_DLL_CODE_COMPILE_UNIT]} compile_units.make (8)
			end
			if not compile_units_paths.has (a_path) then
				compile_units.extend (compile_unit_from_file (a_path))
				compile_units_paths.extend (a_path)
			else
				Event_manager.raise_event (create {TESTER_EVENT}.make ("Compile unit at " + a_path + " is already in tree.", True))
			end
		ensure
			added: compile_units_paths.has (a_path)
		end

	add_namespace (a_path: STRING) is
			-- Extend `namespaces' with tree serialized at `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: {SYSTEM_FILE}.exists (a_path)
			valid_codedom_tree: namespace_from_file (a_path) /= Void
		do
			if namespaces_paths = Void then
				create {ARRAYED_LIST [STRING]} namespaces_paths.make (8)
				create {ARRAYED_LIST [SYSTEM_DLL_CODE_NAMESPACE]} namespaces.make (8)
			end
			if not namespaces_paths.has (a_path) then
				namespaces.extend (namespace_from_file (a_path))
				namespaces_paths.extend (a_path)
			else
				Event_manager.raise_event (create {TESTER_EVENT}.make ("Namespace at " + a_path + " is already in tree.", True))
			end
		ensure
			added: namespaces_paths.has (a_path)
		end

	add_type (a_path: STRING) is
			-- Extend `types' with tree serialized at `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: {SYSTEM_FILE}.exists (a_path)
			valid_codedom_tree: type_from_file (a_path) /= Void
		do
			if types_paths = Void then
				create {ARRAYED_LIST [STRING]} types_paths.make (8)
				create {ARRAYED_LIST [SYSTEM_DLL_CODE_TYPE_DECLARATION]} types.make (8)
			end
			if not types_paths.has (a_path) then
				types.extend (type_from_file (a_path))
				types_paths.extend (a_path)
			else
				Event_manager.raise_event (create {TESTER_EVENT}.make ("Type at " + a_path + " is already in tree.", True))
			end
		ensure
			added: types_paths.has (a_path)
		end

	add_expression (a_path: STRING) is
			-- Extend `expressions' with tree serialized at `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: {SYSTEM_FILE}.exists (a_path)
			valid_codedom_tree: expression_from_file (a_path) /= Void
		do
			if expressions_paths = Void then
				create {ARRAYED_LIST [STRING]} expressions_paths.make (8)
				create {ARRAYED_LIST [SYSTEM_DLL_CODE_EXPRESSION]} expressions.make (8)
			end
			if not expressions_paths.has (a_path) then
				expressions.extend (expression_from_file (a_path))
				expressions_paths.extend (a_path)
			else
				Event_manager.raise_event (create {TESTER_EVENT}.make ("Expression at " + a_path + " is already in tree.", True))
			end
		ensure
			added: expressions_paths.has (a_path)
		end

	add_statement (a_path: STRING) is
			-- Extend `statements' with tree serialized at `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: {SYSTEM_FILE}.exists (a_path)
			valid_codedom_tree: statement_from_file (a_path) /= Void
		do
			if statements_paths = Void then
				create {ARRAYED_LIST [STRING]} statements_paths.make (8)
				create {ARRAYED_LIST [SYSTEM_DLL_CODE_STATEMENT]} statements.make (8)
			end
			if not statements_paths.has (a_path) then
				statements.extend (statement_from_file (a_path))
				statements_paths.extend (a_path)
			else
				Event_manager.raise_event (create {TESTER_EVENT}.make ("Statement at " + a_path + " is already in tree.", True))
			end
		ensure
			added: statements_paths.has (a_path)
		end

feature {NONE} -- Private access

	Location_separator: CHARACTER is ';'
			-- Location separator in regsitry key value

	Compile_units_key: STRING is "CompileUnits"
			-- Registry key containing locations of compile units

	Namespaces_key: STRING is "Namespaces"
			-- Registry key containing locations of namespaces

	Types_key: STRING is "Types"
			-- Registry key containing locations of types

	Expressions_key: STRING is "Expressions"
			-- Registry key containing locations of expressions

	Statements_key: STRING is "Statements"
			-- Registry key containing locations of statements

invariant
	valid_compile_units: ((compile_units = Void) = (compile_units_paths = Void)) and
							(compile_units /= Void implies compile_units.count = compile_units_paths.count) and
							(compile_units /= Void implies not compile_units.is_empty)
	valid_namespaces: ((namespaces = Void) = (namespaces_paths = Void)) and
							(namespaces /= Void implies namespaces.count = namespaces_paths.count) and
							(namespaces /= Void implies not namespaces.is_empty)
	valid_types: ((types = Void) = (types_paths = Void)) and
							(types /= Void implies types.count = types_paths.count) and
							(types /= Void implies not types.is_empty)
	valid_expressions: ((expressions = Void) = (expressions_paths = Void)) and
							(expressions /= Void implies expressions.count = expressions_paths.count) and
							(expressions /= Void implies not expressions.is_empty)
	valid_statements: ((statements = Void) = (statements_paths = Void)) and
							(statements /= Void implies statements.count = statements_paths.count) and
							(statements /= Void implies not statements.is_empty)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class TESTER_TREE_STORE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
