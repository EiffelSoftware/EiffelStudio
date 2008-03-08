indexing
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
			new_bits_as,
			new_class_as,
			new_class_type_as,
			set_expanded_class_type,
			new_debug_as,
			new_expr_address_as,
			new_feature_as,
			new_formal_dec_as,
			new_integer_as,
			new_integer_hexa_as,
			new_integer_octal_as,
			new_integer_binary_as,
			new_external_lang_as,
			new_vtgc1_error,
			validate_integer_real_type,
			validate_non_conforming_inheritance_type
		end

	PREDEFINED_NAMES
		export
			{NONE} all
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

	new_array_as (exp: EIFFEL_LIST [EXPR_AS]; l_as, r_as: SYMBOL_AS): COMPILER_ARRAY_AS is
			-- New COMPILER_ARRAY_AS
		do
			if exp /= Void then
				create Result.initialize (exp, l_as, r_as)
			end
		end

	new_bits_as (v: INTEGER_AS; b_as: KEYWORD_AS): BITS_AS is
			-- New BITS AST node
		local
			l_vtbt: VTBT_SIMPLE
		do
			if v /= Void then
				create Result.initialize (v, b_as)
				if (v.integer_32_value <= 0) then
					create l_vtbt
					l_vtbt.set_class (system.current_class)
					l_vtbt.set_value (v.integer_32_value)
					l_vtbt.set_location (v.start_location)
					Error_handler.insert_error (l_vtbt)
				end
			end
		end

	new_class_as (n: ID_AS; ext_name: STRING_AS;
			is_d, is_e, is_s, is_fc, is_ex, is_par: BOOLEAN;
			top_ind, bottom_ind: INDEXING_CLAUSE_AS;
			g: EIFFEL_LIST [FORMAL_DEC_AS];
			cp: PARENT_LIST_AS;
			ncp: PARENT_LIST_AS
			c: EIFFEL_LIST [CREATE_AS];
			co: CONVERT_FEAT_LIST_AS;
			f: EIFFEL_LIST [FEATURE_CLAUSE_AS];
			inv: INVARIANT_AS;
			s: SUPPLIERS_AS;
			o: STRING_AS;
			ed: KEYWORD_AS): CLASS_AS
		is
			-- New CLASS AST node
		do
			if n /= Void and s /= Void and (co = Void or else not co.is_empty) and ed /= Void then
				create Result.initialize (n, ext_name, is_d, is_e, is_s, is_fc, is_ex, is_par, top_ind,
				bottom_ind, g, cp, ncp, c, co, f, inv, s, o, ed)

					-- Check for Concurrent Eiffel which is not yet supported
				if Result.is_separate then
					error_handler.insert_error (create {SEPARATE_SYNTAX_ERROR}.init (eiffel_parser))
				end
			end
		end

	new_class_type_as (n: ID_AS; g: TYPE_LIST_AS): CLASS_TYPE_AS is
		do
			if n /= Void then
				if g /= Void then
					create {GENERIC_CLASS_TYPE_AS} Result.initialize (n, g)
				else
					create Result.initialize (n)
				end
			end
		end

	set_expanded_class_type (a_type: TYPE_AS; is_expanded: BOOLEAN; s_as: KEYWORD_AS) is
		do
			Precursor {AST_FACTORY} (a_type, is_expanded, s_as)
			if is_expanded then
				system.set_has_expanded
				check
					system_initialized: system.current_class /= Void
				end
				system.current_class.set_has_expanded
			end
		end

	new_debug_as (k: DEBUG_KEY_LIST_AS; c: EIFFEL_LIST [INSTRUCTION_AS]; d_as, e: KEYWORD_AS): DEBUG_AS is
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
						l_str := k.keys.item.value
						l_str.to_lower
						system.add_new_debug_clause (l_str)
						k.keys.forth
					end
				end
			end
		end

	new_expr_address_as (e: EXPR_AS; a_as, l_as, r_as: SYMBOL_AS): EXPR_ADDRESS_AS is
		do
			if not system.address_expression_allowed then
				error_handler.insert_error (create {SYNTAX_ERROR}.init (eiffel_parser))
			elseif e /= Void then
				create Result.initialize (e, a_as, l_as, r_as)
			end
		end

	new_external_lang_as (l: STRING_AS): COMPILER_EXTERNAL_LANG_AS is
			-- New EXTERNAL_LANGUAGE AST node
		do
			if l /= Void then
				create Result.initialize (l)
			end
		end

	new_feature_as (f: EIFFEL_LIST [FEATURE_NAME]; b: BODY_AS; i: INDEXING_CLAUSE_AS; next_pos: INTEGER): FEATURE_AS is
			-- New FEATURE AST node
		local
			feature_name: FEATURE_NAME
			is_query: BOOLEAN
			argument_count: INTEGER
			alias_name: STRING_AS
			operator: STRING
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
					alias_name := feature_name.alias_name
					if feature_name.is_prefix or else feature_name.is_infix then
							-- Infix and prefix features will be checked for VFFD(5,6) later
					elseif alias_name /= Void then
							-- TODO This code occurs in almost the same fashion in `{RENAMING_A}.adapt_alias_feature_name_properties'
						vfav := Void
						operator := alias_name.value
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
						if feature_name.is_bracket then
							if not is_query or else argument_count < 1 then
									-- Invalid bracket alias
								create {VFAV2_SYNTAX} vfav.make (feature_name)
							elseif feature_name.has_convert_mark then
									-- Invalid convert mark
								create {VFAV3_SYNTAX} vfav.make (feature_name)
							end
						elseif is_query and then (
								(argument_count = 0 and then feature_name.is_valid_unary_operator (operator)) or else
								(argument_count = 1 and then feature_name.is_valid_binary_operator (operator))
							)
						then
							if argument_count = 1 then
								feature_name.set_is_binary
							elseif feature_name.has_convert_mark then
									-- Invalid convert mark
								create {VFAV3_SYNTAX} vfav.make (feature_name)
							else
								feature_name.set_is_unary
							end
						else
								-- Invalid operator alias
							create {VFAV1_SYNTAX} vfav.make (feature_name)
						end
						if vfav /= Void then
							error_handler.insert_error (vfav)
							error_handler.checksum
						end
					end
					f.forth
				end
				create Result.initialize (f, b, i, system.feature_as_counter.next_id, next_pos)

				if b.is_built_in then
					-- We have a built in so we set the replacement feature inside if available.
					l_built_in_processor := built_in_processor
					l_built_in_processor.parse_current_class (system.current_class, system.il_generation)
					l_built_in_class_as := l_built_in_processor.class_as
					if l_built_in_class_as /= Void then
							-- We have an associating built in class.
							-- If we find a feature with the name matching the built in then we set this
							-- replacement feature as an attribute of the dummy built in.
						l_built_in_feature_node := l_built_in_class_as.feature_with_name (f.first.internal_name.name_id)
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

				if b.is_unique then
					if system.current_class /= Void then
						system.current_class.set_has_unique
					end
				end
			end
		end

	new_formal_dec_as (f: FORMAL_AS; c: CONSTRAINT_LIST_AS; cf: EIFFEL_LIST [FEATURE_NAME]; c_as: SYMBOL_AS; ck_as, ek_as: KEYWORD_AS): FORMAL_CONSTRAINT_AS is
			-- New FORMAL_DECLARATION AST node
		do
			if f /= Void then
				create Result.initialize (f, c, cf, c_as, ck_as, ek_as)
			end
		end

	new_integer_as (t: TYPE_AS; s: BOOLEAN; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_CONSTANT is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
				Result.set_position (l, c, p, n)
			end
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_CONSTANT is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
				Result.set_position (l, c, p, n)
			end
		end

	new_integer_octal_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_CONSTANT is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_octal_string (t, s, v)
				Result.set_position (l, c, p, n)
			end
		end

	new_integer_binary_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_CONSTANT is
			-- New INTEGER_AS node
		do
			if v /= Void then
				create Result.make_from_binary_string (t, s, v)
				Result.set_position (l, c, p, n)
			end
		end

feature -- Access for Erros

	new_vtgc1_error (a_line, a_column: INTEGER_32; a_filename: STRING_8;  a_id: ID_AS; a_current: CURRENT_AS): VTGC1
			-- Create new VTGC1 error.
		local
			l_location: LOCATION_AS
		do
			if a_id /= Void then
				l_location := a_id
			elseif a_current /= Void then
				l_location := a_current
			end
			check l_location_not_void: l_location /= Void end
			create Result
			Result.set_class (system.current_class)
			Result.set_location (l_location)
		end

feature {NONE} -- Validation

	validate_integer_real_type (a_psr: EIFFEL_PARSER_SKELETON; a_type: TYPE_AS; buffer: STRING; for_integer: BOOLEAN) is
			-- New integer value.
		local
			l_type: TYPE_A
		do
			is_valid_integer_real := True
			if for_integer then
				if a_type /= Void then
					l_type := type_a_generator.evaluate_type_if_possible (a_type, System.current_class)
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
				if a_type /= Void then
					l_type := type_a_generator.evaluate_type (a_type, System.current_class)
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

	validate_non_conforming_inheritance_type (a_psr: EIFFEL_PARSER_SKELETON; a_type: TYPE_AS)
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

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
