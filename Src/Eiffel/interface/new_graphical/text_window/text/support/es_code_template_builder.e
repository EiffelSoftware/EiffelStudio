note
	description: "Utility class to retrieve useful information for code template at feature level"
	author: "javierv"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CODE_TEMPLATE_BUILDER

inherit

	SHARED_EIFFEL_PARSER

	SHARED_STATELESS_VISITOR

	AST_ITERATOR
		redefine
			process_object_test_as,
			process_loop_as,
			process_named_expression_as
		end

feature {NONE} -- Reset

	reset_locals
		do
			read_only_locals := Void
			is_context_local := True
		end

	reset_locals_template
		do
			read_only_locals_template := Void
			is_context_local := False
		end

feature -- Access

	arguments (e_feature: E_FEATURE): STRING_TABLE [TYPE_A]
			-- Given a feature `e_feature' return
			-- a Table of pair, variable name (key)
			-- variable Type if it has arguments.
		local
			l_arguments: E_FEATURE_ARGUMENTS
			i: INTEGER
		do
			create Result.make_caseless (2)
			if e_feature.argument_count > 0 then
				from
					i := 1
					l_arguments := e_feature.arguments
				until
					i > e_feature.argument_count
				loop
					Result.force (l_arguments.at (i), l_arguments.argument_names.at (i))
					i := i + 1
				end
			end
		ensure
			result_set: Result /= Void
		end

	locals (e_feature: E_FEATURE): STRING_TABLE [TYPE_AS]
			-- Given a feature `e_feature' return
			-- a Table of pair, variable name (key)
			-- variable Type if it has locals.
		local
			l_locals: EIFFEL_LIST [LIST_DEC_AS]
			i, j: INTEGER
			l_dec: LIST_DEC_AS
			l_type: TYPE_AS
			l_name: STRING_32
			l_id_list: IDENTIFIER_LIST
			l_count : INTEGER
		do
			create Result.make_caseless (5)
			if e_feature.locals_count > 0 then
				from
					l_locals := e_feature.locals
					l_count := l_locals.count
					i := 1
				until
					i > l_count
				loop
					l_dec := l_locals.at (i)
					l_type := l_dec.type
					l_id_list := l_dec.id_list
					if l_id_list.count > 0 then
						from
							j := 1
						until
							j > l_id_list.count
						loop
							l_name := l_dec.item_name (j)
							j := j + 1
							Result.force (l_type, l_name)
						end
					end
					i := i + 1
				end
			end
		ensure
			result_set: Result /= Void
		end

	read_only_locals: detachable STRING_TABLE [STRING]
			-- Last read only locals names.

	read_only_locals_template: detachable STRING_TABLE [STRING]
			-- Last read only locals names from code template.

feature -- Process

	process_read_only_locals (e_feature: E_FEATURE)
			-- Given a feature `e_feature' return the names of the locals to
			-- `across', `object test locals'.
		do
			reset_locals
			if attached e_feature.ast.body as l_body then
				l_body.process (Current)
			end
			if read_only_locals = Void then
					-- Create an empty
				create read_only_locals.make_caseless (1)
			end
		end

	process_only_locals_template (a_code: STRING_32)
			-- Given a code template `a_code' return the names of the locals to
			-- `across', `object test locals
		do
			reset_locals_template
			if
				attached feature_template_ast (a_code) as l_feature_ast and then
				attached l_feature_ast.body as l_body
			then
				l_body.process (Current)
			end
		end

feature -- AST Iterator

	process_object_test_as (l_as: OBJECT_TEST_AS)
			-- <Precursor>
		local
			l_name: detachable ID_AS
		do
			l_name := l_as.name
			if l_name /= Void then
				set_object_test_local (l_name.name_32)
			end
			Precursor (l_as)
		end

	process_loop_as (l_as: LOOP_AS)
			-- <Precursor>
		do
			if
				attached l_as.iteration as l_iteration and then
				attached l_iteration.identifier as l_id
			then
				set_object_test_local (l_id.name_32)
			end
			Precursor (l_as)
		end

	process_named_expression_as (a_as: NAMED_EXPRESSION_AS)
			-- <Precursor>
		do
			if attached a_as.name as l_name then
				set_object_test_local (l_name.name_32)
			end
			Precursor(a_as)
		end

feature -- Conformance

	string_type_string_conformance (a_string: STRING_32; a_string2: STRING_32; a_class_c: CLASS_C): BOOLEAN
			-- Is the type represented by `a_string' conforms_to type `a_string_2'.-
		do
			if not a_string.is_empty then
				type_parser.parse_from_string_32 ({STRING_32} "type " + a_string, Void)
				if attached type_parser.type_node as l_class_type_as then
					type_parser.parse_from_string_32 ({STRING_32} "type " + a_string2, Void)
					if
						attached type_parser.type_node as l_class_type_as_2 and then
						attached type_a_generator.evaluate_type (l_class_type_as, a_class_c) as l_type_a and then
						attached type_a_generator.evaluate_type (l_class_type_as_2, a_class_c) as l_type_a_2
					then
						Result := l_type_a.conform_to (a_class_c, l_type_a_2)
					end
				end
			end
		end

	type_as_to_type_as_conformance (a_type_as_a: TYPE_AS; a_type_as_b: TYPE_AS; a_class_c: CLASS_C): BOOLEAN
			-- Is the type_as represented by `a_type_as_a' conforms_to type `a_type_as_b'.
		do
				-- Convert TYPE_AS into TYPE_A.
			if
				attached type_a_generator.evaluate_type (a_type_as_a, a_class_c) as l_type_a and then
				attached type_a_generator.evaluate_type (a_type_as_b, a_class_c) as s_type_a
			then
				Result := l_type_a.conform_to (a_class_c, s_type_a)
			end
		end

	string_type_as_conformance (a_string: STRING_32; a_type_as: TYPE_AS; a_class_c: CLASS_C): BOOLEAN
			-- Is the type represented by `a_string' conforms_to type `a_type_as'.
		do
			if not a_string.is_empty then
				type_parser.parse_from_string_32 ({STRING_32} "type " + a_string, Void)
				if
					attached type_parser.type_node as l_class_type_as and then
					attached type_a_generator.evaluate_type (l_class_type_as, a_class_c) as s_type_a and then
					attached type_a_generator.evaluate_type (a_type_as, a_class_c) as l_type_a
				then
					Result := l_type_a.conform_to (a_class_c, s_type_a)
				end
			end
		end

	string_type_a_conformance (a_string: STRING_32; a_type_a: TYPE_A; a_class_c: CLASS_C): BOOLEAN
			-- Is the type represented by `a_string' conforms_to type `a_type_a'.
		do
			if not a_string.is_empty then
				type_parser.parse_from_string_32 ({STRING_32} "type " + a_string, Void)
				if
					attached type_parser.type_node as l_class_type_as and then
					attached type_a_generator.evaluate_type (l_class_type_as, a_class_c) as s_type_a
				then
					Result := a_type_a.conform_to (a_class_c, s_type_a)
				end
			end
		end

feature {NONE} -- Template Implementation.

	is_context_local: BOOLEAN
			-- True if context locals from Eiffel class feature,
			-- False if it's context locals from code template.

	feature_template_ast (a_code: STRING_32): FEATURE_AS
			-- Return a feature AST from the code template `a_code'.
		local
			epw: EIFFEL_PARSER_WRAPPER
		do
			create epw
			epw.parse_with_option_32 (entity_feature_parser, {STRING_32} "feature " + a_code, {CONF_OPTION}.create_from_namespace_or_latest ({CONF_FILE_CONSTANTS}.latest_namespace), True, Void)
			if attached {FEATURE_AS} epw.ast_node as l_feature_node then
				Result := l_feature_node
			end
		end

	set_object_test_local (a_name: READABLE_STRING_GENERAL)
		local
			l_read_only_locals: like read_only_locals
			l_read_only_locals_template: like read_only_locals_template
		do
			if is_context_local then
				l_read_only_locals := read_only_locals
				if l_read_only_locals = Void then
					create l_read_only_locals.make_caseless (1)
					read_only_locals := l_read_only_locals
				end
				l_read_only_locals.force ("", a_name)
			else
				check not is_context_local end
				l_read_only_locals_template := read_only_locals_template
				if l_read_only_locals_template = Void then
					create l_read_only_locals_template.make_caseless (1)
					read_only_locals_template := l_read_only_locals_template
				end
				l_read_only_locals_template.force ("", a_name)
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
