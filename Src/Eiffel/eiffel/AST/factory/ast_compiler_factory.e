note
	description: "Factory for compiler which generates descendants of certain AST classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_COMPILER_FACTORY

inherit
	AST_FACTORY
		redefine
			new_array_as,
			set_expanded_class_type,
			new_debug_as,
			new_expr_address_as,
			new_feature_as,
			new_feature_name_alias_as,
			new_formal_dec_as,
			new_integer_as,
			new_integer_hexa_as,
			new_integer_octal_as,
			new_integer_binary_as,
			new_external_lang_as,
			new_vtgc1_error,
			new_vvok1_error, new_vvok2_error,
			validate_integer_real_type,
			validate_non_conforming_inheritance_type
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	SHARED_STATEFUL_VISITOR
		export
			{NONE} all
		end

		-- FIXME: we are only using it to generate the errors in `new_expr_address_as' and `new_class_as'
		-- for reporting unsupported constructs. Ideally we need a different way of generating errors,
		-- for example, by making the parser aware of such limitations.
	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

feature -- Access

	new_array_as (exp: detachable EIFFEL_LIST [EXPR_AS]; l_as, r_as: detachable SYMBOL_AS): detachable COMPILER_ARRAY_AS
			-- New COMPILER_ARRAY_AS
		do
			if exp /= Void then
				create Result.initialize (exp, l_as, r_as)
			end
		end

	set_expanded_class_type (a_type: detachable TYPE_AS; is_expanded: BOOLEAN; s_as: detachable KEYWORD_AS)
		do
			Precursor {AST_FACTORY} (a_type, is_expanded, s_as)
			if is_expanded then
				system.set_has_expanded
				if attached {CLASS_C} parser.current_class as l_class_c then
					l_class_c.set_has_expanded
				end
			end
		end

	new_debug_as (k: detachable KEY_LIST_AS; c: detachable EIFFEL_LIST [INSTRUCTION_AS]; d_as, e: detachable KEYWORD_AS): detachable DEBUG_AS
		local
			l_str: STRING
		do
			if e /= Void then
				create Result.initialize (k, c, d_as, e)
				if k /= Void and then k.keys /= Void then
					from
							-- Debug keys are not case sensitive
						k.keys.start
					until
						k.keys.after
					loop
						k.keys.item.value_to_lower
						l_str := k.keys.item.value
						system.add_new_debug_clause (l_str)
						k.keys.forth
					end
				end
			end
		end

	new_expr_address_as (e: detachable EXPR_AS; a_as, l_as, r_as: detachable SYMBOL_AS): detachable EXPR_ADDRESS_AS
		do
			if not system.address_expression_allowed then
				error_handler.insert_error (create {SYNTAX_ERROR}.init (eiffel_parser))
			elseif e /= Void then
				create Result.initialize (e, a_as, l_as, r_as)
			end
		end

	new_external_lang_as (l: detachable STRING_AS): detachable COMPILER_EXTERNAL_LANG_AS
			-- New EXTERNAL_LANGUAGE AST node
		do
			if l /= Void then
				create Result.initialize (l)
			end
		end

	new_feature_as (f: detachable EIFFEL_LIST [FEATURE_NAME]; b: detachable BODY_AS; i: detachable INDEXING_CLAUSE_AS; next_pos: INTEGER): detachable FEATURE_AS
			-- New FEATURE AST node
		local
			feature_name: FEATURE_NAME
			is_query: BOOLEAN
			argument_count: INTEGER
			arguments: EIFFEL_LIST [TYPE_DEC_AS]
			vfav: VFAV_SYNTAX
			l_built_in_processor: like built_in_processor
			l_built_in_class_as: CLASS_AS
			l_built_in_feature_node: FEATURE_AS
			l_routine_as: ROUTINE_AS
			l_built_in_as: BUILT_IN_AS
		do
			if
				(f /= Void and then not f.is_empty) and b /= Void
			then
					-- Check if there are any operator names that violate VFAV rules
				is_query := b.type /= Void
				from
					f.start
				until
					f.after
				loop
					feature_name := f.item
					if attached {FEATURE_NAME_ALIAS_AS} feature_name as l_feat_name_alias_as then
							-- TODO This code occurs in almost the same fashion in `{RENAMING_A}.adapt_alias_feature_name_properties'
						vfav := Void
						arguments := b.arguments
						if arguments /= Void then
								-- It's possible to calculate the value of `argument_count' once
								-- before loop, but from the other hand it is required only for
								-- features with aliases, so it makes sense to put it here.
							from
								argument_count := 0
								arguments.start
							until
								arguments.after
							loop
								argument_count := argument_count + arguments.item.id_list.count
								arguments.forth
							end
						end
						if l_feat_name_alias_as.has_bracket_alias then
							if not is_query or else argument_count < 1 then
									-- Invalid bracket alias.
								create {VFAV2_SYNTAX} vfav.make (l_feat_name_alias_as, l_feat_name_alias_as.bracket_alias_as)
							elseif l_feat_name_alias_as.has_convert_mark then
									-- Invalid convert mark.
								create {VFAV5_SYNTAX} vfav.make (l_feat_name_alias_as, l_feat_name_alias_as.bracket_alias_as)
							end
						elseif l_feat_name_alias_as.has_parentheses_alias then
							if argument_count < 1 then
									-- Invalid parenthesis alias.
								create {VFAV3_SYNTAX} vfav.make (l_feat_name_alias_as, l_feat_name_alias_as.parenthesis_alias_as)
							elseif l_feat_name_alias_as.has_convert_mark then
									-- Invalid convert mark.
								create {VFAV5_SYNTAX} vfav.make (l_feat_name_alias_as, l_feat_name_alias_as.parenthesis_alias_as)
							end
						elseif is_query then
							across
								l_feat_name_alias_as.aliases as ic
							until
								vfav /= Void
							loop
								if
									(argument_count = 0 and then ic.item.is_valid_unary) or else
									(argument_count = 1 and then ic.item.is_valid_binary)
								then
										-- FIXME: maybe move this check outside the loop [2019-09-25].
									if argument_count = 0 and then l_feat_name_alias_as.has_convert_mark then
											-- Invalid convert mark
										create {VFAV5_SYNTAX} vfav.make (l_feat_name_alias_as, ic.item.alias_name)
									end
								else
										-- Invalid operator alias
									create {VFAV1_SYNTAX} vfav.make (l_feat_name_alias_as, ic.item.alias_name)
								end
							end
							if vfav /= Void then
									-- Error detected
							elseif argument_count = 1 then
								l_feat_name_alias_as.set_is_binary
							elseif l_feat_name_alias_as.has_convert_mark then
								create {VFAV5_SYNTAX} vfav.make (l_feat_name_alias_as, Void)
							else
								l_feat_name_alias_as.set_is_unary
							end
						else
								-- This is an alias, but not a bracket or parenthesis alias, and this is not a query ...
							create {VFAV1_SYNTAX} vfav.make (l_feat_name_alias_as, Void)
						end
						if vfav /= Void then
							error_handler.insert_error (vfav)
						end
					end
					f.forth
				end
				create Result.initialize (f, b, i, system.feature_as_counter.next_id, next_pos)

				if b.is_built_in and then system.workbench.is_compiling then
						-- The system.workbench.is_compiling needs to be checked here because refactoring uses this factory.
						-- When working with uncompiled classes system.current_class will be Void. See fix_me below

						-- We have a built in so we set the replacement feature inside if available.
					l_built_in_processor := built_in_processor
					l_built_in_processor.parse_current_class (parser.current_class, system.il_generation)
					l_built_in_class_as := l_built_in_processor.class_as
					if l_built_in_class_as /= Void then
							-- We have an associating built in class.
							-- If we find a feature with the name matching the built in then we set this
							-- replacement feature as an attribute of the dummy built in.
						l_built_in_feature_node := l_built_in_class_as.feature_with_name (f.first.feature_name.name_id)
						if l_built_in_feature_node /= Void then
							l_routine_as ?= b.content
							l_built_in_as ?= l_routine_as.routine_body
							l_built_in_as.set_body (l_built_in_feature_node)
								-- Add any newly introduced suppliers if any.
							if l_built_in_class_as.suppliers /= Void then
									-- Make sure any uncompiled classes referenced by the built in get compiled.
									--| FIXME IEK Optimize if possible as this only needs to be performed once per built in class.
								eiffel_parser.suppliers.merge (l_built_in_class_as.suppliers)
							end
						end
					end
					l_built_in_processor.reset
				end

				if b.is_unique and then attached {CLASS_C} parser.current_class as l_class_c then
					l_class_c.set_has_unique
				end
			end
		end

	new_feature_name_alias_as (feature_name: detachable ID_AS; aliases: detachable LIST [FEATURE_ALIAS_NAME]; convert_keyword: detachable KEYWORD_AS): detachable FEATURE_NAME_ALIAS_AS
			-- <Precursor>
		local
			first_operator, second_operator:  STRING_AS
			has_error: BOOLEAN
		do
			if attached feature_name and then attached aliases then
				across
					aliases as a
				loop
					first_operator := a.item.alias_name
					across
						aliases as b
					loop
						second_operator := b.item.alias_name
						if
								-- Avoid processing already processed operators.
							a.target_index < b.target_index and then
								-- Check whether aliases have the same name.
							first_operator.value.same_string (second_operator.value)
						then
							error_handler.insert_error (create {VFAV4_SYNTAX}.make (feature_name, first_operator, second_operator))
							has_error := True
						end
					end
				end
				if not has_error then
					Result := Precursor (feature_name, aliases, convert_keyword)
				end
			end
		end

	new_formal_dec_as (f: detachable FORMAL_AS; c: detachable CONSTRAINT_LIST_AS; cf: detachable EIFFEL_LIST [FEATURE_NAME]; c_as: detachable SYMBOL_AS; ck_as, ek_as: detachable KEYWORD_AS): detachable FORMAL_CONSTRAINT_AS
			-- New FORMAL_DECLARATION AST node
		do
			if f /= Void then
				create Result.initialize (f, c, cf, c_as, ck_as, ek_as)
			end
		end

	new_integer_as (t: detachable TYPE_AS; s: BOOLEAN; v: detachable STRING; buf: detachable READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_CONSTANT
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
				Result.set_position (l, c, p, n, cc, cp, cn)
			end
		end

	new_integer_hexa_as (t: detachable TYPE_AS; s: CHARACTER; v: detachable STRING; buf: READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_CONSTANT
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
				Result.set_position (l, c, p, n, cc, cp, cn)
			end
		end

	new_integer_octal_as (t: detachable TYPE_AS; s: CHARACTER; v: detachable STRING; buf: READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_CONSTANT
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_octal_string (t, s, v)
				Result.set_position (l, c, p, n, cc, cp, cn)
			end
		end

	new_integer_binary_as (t: detachable TYPE_AS; s: CHARACTER; v: detachable STRING; buf: READABLE_STRING_8; s_as: detachable SYMBOL_AS; l, c, p, n, cc, cp, cn: INTEGER): detachable INTEGER_CONSTANT
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_binary_string (t, s, v)
				Result.set_position (l, c, p, n, cc, cp, cn)
			end
		end

feature -- Access for Errors

	new_vtgc1_error (a_line: INTEGER; a_column: INTEGER; a_filename: like {ERROR}.file_name; a_type: TYPE_AS): VTGC1
			-- <Precursor>
		do
			create Result
			if attached {CLASS_C} parser.current_class as l_class_c then
				Result.set_class (l_class_c)
			end
			Result.set_location (a_type.start_location)
		end

	new_vvok1_error (a_line: INTEGER; a_column: INTEGER; a_filename: like {ERROR}.file_name; a_once_as: FEATURE_AS): VVOK1
			-- Create new VVOK1 error.
		do
			create Result.make (a_line, a_column, a_filename, Void)
		end

	new_vvok2_error (a_line: INTEGER; a_column: INTEGER; a_filename: like {ERROR}.file_name; a_once_as: FEATURE_AS): VVOK2
			-- Create new VVOK2 error.
		do
			create Result.make (a_line, a_column, a_filename, Void)
		end

feature {NONE} -- Validation

	validate_integer_real_type (a_psr: EIFFEL_SCANNER_SKELETON; a_type: detachable TYPE_AS; buffer: READABLE_STRING_8; for_integer: BOOLEAN)
			-- New integer value.
		local
			l_type: TYPE_A
			l_class_c: CLASS_C
		do
			is_valid_integer_real := True
			l_class_c ?= a_psr.current_class
			if for_integer then
				if a_type /= Void and l_class_c /= Void then
					l_type := type_a_generator.evaluate_type (a_type, l_class_c)
				end
				if l_type /= Void then
					if not l_type.is_valid or (not l_type.is_integer and not l_type.is_natural) then
						is_valid_integer_real := False
						a_psr.report_invalid_type_for_integer_error (a_type, buffer)
					end
				elseif a_type /= Void then
						-- A type was specified but did not result in a valid type
					is_valid_integer_real := False
					a_psr.report_invalid_type_for_integer_error (a_type, buffer)
				end
			else
				if a_type /= Void and l_class_c /= Void then
					l_type := type_a_generator.evaluate_type (a_type, l_class_c)
				end
				if l_type /= Void then
					if not l_type.is_valid or (not l_type.is_real_32 and not l_type.is_real_64) then
						is_valid_integer_real := False
						a_psr.report_invalid_type_for_real_error (a_type, buffer)
					end
				elseif a_type /= Void then
						-- A type was specified but did not result in a valid type
					is_valid_integer_real := False
					a_psr.report_invalid_type_for_real_error (a_type, buffer)
				end
			end
		end

	validate_non_conforming_inheritance_type (a_psr: EIFFEL_PARSER_SKELETON; a_type: detachable TYPE_AS)
			-- Validate `a_type' for non-conforming inheritance.
		local
			l_none_type_as: NONE_TYPE_AS
			l_syntax_error: SYNTAX_ERROR
		do
				-- Make sure that `a_type' is of type NONE_TYPE_AS.
			l_none_type_as ?= a_type
			if l_none_type_as = Void then
					-- Raise error.
				create l_syntax_error.make (a_psr.line, a_psr.column, a_psr.filename, "Use 'inherit {NONE}' to specify non-conforming inheritance")
				a_psr.report_one_error (l_syntax_error)
			end
		end

note
	ca_ignore:
		"CA011", "CA011: too many arguments",
		"CA033", "CA033: very long class"
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
