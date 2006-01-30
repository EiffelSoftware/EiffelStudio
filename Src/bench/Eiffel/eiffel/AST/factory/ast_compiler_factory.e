indexing
	description: "Factory for compiler which generates descendans of certain AST classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_COMPILER_FACTORY

inherit
	AST_FACTORY
		redefine
			new_bits_as,
			new_class_as,
			new_class_type_as,
			new_debug_as,
			new_expr_address_as,
			new_feature_as,
			new_integer_as,
			new_integer_hexa_as,
			new_external_lang_as
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

feature -- Access

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
						-- Cannot go on here
					Error_handler.raise_error
				end
			end
		end

	new_class_as (n: ID_AS; ext_name: STRING_AS;
			is_d, is_e, is_s, is_fc, is_ex: BOOLEAN;
			top_ind, bottom_ind: INDEXING_CLAUSE_AS;
			g: EIFFEL_LIST [FORMAL_DEC_AS];
			p: PARENT_LIST_AS;
			c: EIFFEL_LIST [CREATE_AS];
			co: CONVERT_FEAT_LIST_AS;
			f: EIFFEL_LIST [FEATURE_CLAUSE_AS];
			inv: INVARIANT_AS;
			s: SUPPLIERS_AS;
			o: STRING_AS;
			he: BOOLEAN; ed: KEYWORD_AS): CLASS_AS
		is
			-- New CLASS AST node
		do
			if n /= Void and s /= Void and (co = Void or else not co.is_empty) and ed /= Void then
				create Result.initialize (n, ext_name, is_d, is_e, is_s, is_fc, is_ex, top_ind,
				bottom_ind, g, p, c, co, f, inv, s, o, he, ed)

					-- Check for Concurrent Eiffel which is not yet supported
				if Result.is_separate then
					error_handler.insert_error (create {SEPARATE_SYNTAX_ERROR}.init)
					error_handler.raise_error
				end
			end
		end

	new_class_type_as (n: ID_AS; g: TYPE_LIST_AS; is_exp: BOOLEAN; is_sep: BOOLEAN; e_as, s_as: KEYWORD_AS): CLASS_TYPE_AS is
		do
			if n /= Void then
				create Result.initialize (n, g, is_exp, is_sep, e_as, s_as)
				if is_exp then
					system.set_has_expanded
					check
						system_initialized: system.current_class /= Void
					end
					system.current_class.set_has_expanded
				end
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
				error_handler.insert_error (create {SYNTAX_ERROR}.init)
				error_handler.raise_error
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
								if
									is_semi_strict_id (feature_name.internal_alias_name_id) and then
									system.current_class.lace_class /= system.boolean_class
								then
										-- Semistrict operator alias name is declared in a class that is not BOOLEAN
									create {VFAV4_SYNTAX} vfav.make (feature_name)
								end
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
				if b.is_unique then
					check
						system_initialized: system.current_class /= Void
					end
					system.current_class.set_has_unique
				end
			end
		end

	new_integer_as (t: TYPE_AS; s: BOOLEAN; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_CONSTANT is
			-- New INTEGER_AS node
		require else
			valid_type: t /= Void implies (t.actual_type.is_integer or t.actual_type.is_natural)
		do
			if v /= Void then
				create Result.make_from_string (t, s, v)
			end
		end

	new_integer_hexa_as (t: TYPE_AS; s: CHARACTER; v: STRING; buf: STRING; s_as: SYMBOL_AS; l, c, p, n: INTEGER): INTEGER_CONSTANT is
			-- New INTEGER_AS node
		require else
			valid_type: t /= Void implies (t.actual_type.is_integer or t.actual_type.is_natural)
		do
			if v /= Void then
				create Result.make_from_hexa_string (t, s, v)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
