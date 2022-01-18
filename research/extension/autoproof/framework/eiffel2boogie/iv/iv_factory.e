note
	description: "Helper class to create IV-nodes."

frozen class
	IV_FACTORY

inherit

	IV_SHARED_TYPES
		rename
			equal as any_equal
		end

	E2B_SHARED_CONTEXT
		rename
			equal as any_equal
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		rename
			equal as any_equal
		export
			{NONE} all
		end

feature -- Values

	false_: IV_VALUE
			-- Value for constant `false'.
		do
			create Result.make ("false", types.bool)
		end

	true_: IV_VALUE
			-- Value for constant `true'.
		do
			create Result.make ("true", types.bool)
		end

	void_: IV_VALUE
			-- Value for constant `Void'.
		do
			create Result.make ("Void", types.ref)
		end

	int_value (a_value: INTEGER): IV_VALUE
			-- Value for integer `a_value'.
		do
			create Result.make (a_value.out, types.int)
		end

	int64_value (a_value: INTEGER_64): IV_VALUE
			-- Value for integer `a_value'.
		do
			create Result.make (a_value.out, types.int)
		end

	nat64_value (a_value: NATURAL_64): IV_VALUE
			-- Value for integer `a_value'.
		do
			create Result.make (a_value.out, types.int)
		end

	real_value (a_value: REAL_64): IV_VALUE
			-- Value for floating point `a_value'.
		local
			l_temp: STRING
		do
			l_temp := a_value.out
			if not l_temp.has ('.') then
				l_temp.append (".0")
			end
			create Result.make (l_temp, types.real)
		end

	type_value (a_value: CL_TYPE_A): IV_VALUE
			-- Value for integer `a_value'.
		do
			create Result.make (name_translator.boogie_name_for_type (a_value), types.type)
		end

feature -- Entities

	entity (a_name: READABLE_STRING_8; a_type: IV_TYPE): IV_ENTITY
			-- Entity with name `a_name' and type `a_type'.
		do
			create Result.make (a_name, a_type)
		end

	unique_entity (a_name_prefix: READABLE_STRING_8; a_type: IV_TYPE): IV_ENTITY
			-- Entity with name `a_name_X' (where 'X' is unique) and type `a_type'.
		do
			create Result.make (helper.unique_identifier (a_name_prefix), a_type)
		end

	heap_entity (a_name: READABLE_STRING_8): IV_ENTITY
		do
			Result := entity (a_name, types.heap)
		end

	global_heap: IV_ENTITY
		once
			Result := heap_entity ("Heap")
		end

	old_heap: IV_EXPRESSION
		once
			Result := function_call ("old", << global_heap >>, types.heap)
		end

	ref_entity (a_name: READABLE_STRING_8): IV_ENTITY
		do
			Result := entity (a_name, types.ref)
		end

	std_current: IV_ENTITY
		once
			Result := ref_entity ("Current")
		end

	universe: IV_ENTITY
		once
			create Result.make ("universe", types.set (types.ref))
		end

feature -- Boolean operators

	or_ (a_left, a_right: IV_EXPRESSION): IV_BINARY_OPERATION
			-- Or operator `||'.
		do
			create Result.make (a_left, "||", a_right, types.bool)
		end

	or_clean (a_left, a_right: IV_EXPRESSION): IV_EXPRESSION
			-- Or operator `||', removing "false" disjuncts.
		do
			if a_left.is_false then
				Result := a_right
			elseif a_right.is_false then
				Result := a_left
			else
				Result := or_ (a_left, a_right)
			end
		end

	and_ (a_left, a_right: IV_EXPRESSION): IV_BINARY_OPERATION
			-- And operator `&&'.
		do
			create Result.make (a_left, "&&", a_right, types.bool)
		end

	and_clean (a_left, a_right: IV_EXPRESSION): IV_EXPRESSION
			-- And operator `&&', removing "true" conjuncts.
		do
			if a_left.is_true then
				Result := a_right
			elseif a_right.is_true then
				Result := a_left
			else
				Result := and_ (a_left, a_right)
			end
		end

	implies_ (a_left, a_right: IV_EXPRESSION): IV_BINARY_OPERATION
			-- Implies operator `==>'.
		do
			create Result.make (a_left, "==>", a_right, types.bool)
		end

	implies_clean (a_left, a_right: IV_EXPRESSION): IV_EXPRESSION
			-- Implies operator `==>', removing "true" antecedents.
		do
			if a_left.is_true then
				Result := a_right
			else
				Result := implies_ (a_left, a_right)
			end
		end

	equiv (a_left, a_right: IV_EXPRESSION): IV_BINARY_OPERATION
			-- Equivalence operator `==>'.
		do
			create Result.make (a_left, "<==>", a_right, types.bool)
		end

	not_ (a_expr: IV_EXPRESSION): IV_UNARY_OPERATION
			-- Not operator `!'.
		do
			create Result.make ("!", a_expr, types.bool)
		end

	conditional (a_cond, a_then, a_else: IV_EXPRESSION): IV_CONDITIONAL_EXPRESSION
			-- Expression "if a_cond then a_then else a_else"
		do
			create Result.make_if_then_else (a_cond, a_then, a_else)
		end

	conjunction (a_conjuncts: ITERABLE [IV_ASSERT]): IV_EXPRESSION
			-- Conjunction of all expressions in `a_conjuncts'.
		do
			Result := true_
			across
				a_conjuncts as i
			loop
				Result := and_clean (Result, i.expression)
			end
		end

feature -- Relational operators

	equal (a_left, a_right: IV_EXPRESSION): IV_BINARY_OPERATION
			-- Equal operator `=='.
		do
			create Result.make (a_left, "==", a_right, types.bool)
		end

	not_equal (a_left, a_right: IV_EXPRESSION): IV_BINARY_OPERATION
			-- Not equal operator `!='.
		do
			create Result.make (a_left, "!=", a_right, types.bool)
		end

	less_equal (a_left, a_right: IV_EXPRESSION): IV_BINARY_OPERATION
			-- Less than or equal operator `<='.
		do
			create Result.make (a_left, "<=", a_right, types.bool)
		end

	less (a_left, a_right: IV_EXPRESSION): IV_BINARY_OPERATION
			-- Less than operator `<'.
		do
			create Result.make (a_left, "<", a_right, types.bool)
		end

	sub_type (a_left, a_right: IV_EXPRESSION): IV_BINARY_OPERATION
			-- Less than operator `<:'.
		do
			create Result.make (a_left, "<:", a_right, types.bool)
		end

feature -- Integer operators

	plus (a_left, a_right: IV_EXPRESSION): IV_BINARY_OPERATION
			-- Plus operator `+'.
		do
			create Result.make (a_left, "+", a_right, types.int)
		end

	plus_one (a_expr: IV_EXPRESSION): IV_BINARY_OPERATION
			-- `a_expr + 1'.
		do
			Result := plus (a_expr, int_value (1))
		end

	minus (a_left, a_right: IV_EXPRESSION): IV_BINARY_OPERATION
			-- Plus operator `-'.
		do
			create Result.make (a_left, "-", a_right, types.int)
		end

	minus_one (a_expr: IV_EXPRESSION): IV_BINARY_OPERATION
			-- `a_expr - 1'.
		do
			Result := minus (a_expr, int_value (1))
		end

feature -- Functions

	type_of (a_arg: IV_EXPRESSION): IV_FUNCTION_CALL
			-- Function call `type_of (a_arg)'.
		do
			create Result.make ("type_of", types.type)
			Result.add_argument (a_arg)
		end

	old_ (a_arg: IV_EXPRESSION): IV_FUNCTION_CALL
			-- Function call `old (a_arg)'.
		do
			create Result.make ("old", a_arg.type)
			Result.add_argument (a_arg)
		end

	function_call (a_function_name: READABLE_STRING_8; a_arguments: ARRAY [IV_EXPRESSION]; a_result_type: IV_TYPE): IV_FUNCTION_CALL
			-- Function call to `a_function_name' with arguments `a_arguments'.
		do
			create Result.make (a_function_name, a_result_type)
			if attached a_arguments then
				across a_arguments as i loop
					Result.add_argument (i)
				end
			end
		end

feature -- Heap and map access

	map_access (a_map: IV_EXPRESSION; a_indexes: like {IV_MAP_ACCESS}.indexes): IV_MAP_ACCESS
			-- Map access to `a_map'[`a_index'].
		do
			create Result.make (a_map, a_indexes)
		end

	map_update (a_map: IV_EXPRESSION; a_indexes: ARRAYED_LIST [IV_EXPRESSION]; a_value: IV_EXPRESSION): IV_MAP_UPDATE
			-- Map update `a_map'[`a_index' := `a_value'].
		do
			create Result.make (a_map, a_indexes, a_value)
		end

	heap_access (a_heap: IV_EXPRESSION; a_target: IV_EXPRESSION; a_name: READABLE_STRING_8; a_content_type: IV_TYPE): IV_MAP_ACCESS
			-- Heap access to `a_feature' on `Current'.
		do
			Result := map_access (a_heap, create {ARRAYED_LIST [IV_EXPRESSION]}.make_from_array (<<a_target, create {IV_ENTITY}.make (a_name, types.field (a_content_type)) >>))
		end

	heap_current_access (a_mapping: E2B_ENTITY_MAPPING; a_name: READABLE_STRING_8; a_content_type: IV_TYPE): IV_MAP_ACCESS
			-- Heap access to `a_feature' on `Current'.
		do
			Result := heap_access (a_mapping.heap, a_mapping.current_expression, a_name, a_content_type)
		end

	is_heap (a_heap: IV_EXPRESSION): IV_EXPRESSION
			-- Expression "IsHeap(a_entity)".
		do
			Result := function_call ("IsHeap", << a_heap >>, types.bool)
		end

	array_access (a_heap: IV_EXPRESSION; a_array, a_index: IV_EXPRESSION; a_content_type: IV_TYPE): IV_MAP_ACCESS
			-- Array access to `a_array'[`a_index'].
		do
			Result := map_access (
				heap_access (a_heap, a_array, "area", create {IV_MAP_TYPE}.make (<<>>, create {ARRAYED_LIST [IV_TYPE]}.make_from_array (<<types.int>>), a_content_type)),
				create {ARRAYED_LIST [IV_EXPRESSION]}.make_from_array (<<a_index>>))
		end

feature -- Statements

	procedure_call (a_proc_name: STRING; a_arguments: ARRAY [IV_EXPRESSION]): IV_PROCEDURE_CALL
			-- Procedure call.
		do
			create Result.make (a_proc_name)
			if attached a_arguments then
				across a_arguments as i loop
					Result.add_argument (i)
				end
			end
		end

	singleton_block (a_statement: IV_STATEMENT): IV_BLOCK
			-- Block that consists of `a_statement'.
		do
			if attached {IV_BLOCK} a_statement as b then
				Result := b
			else
				create Result.make
				Result.add_statement (a_statement)
			end
		end

	return: IV_RETURN
			-- Return statement.
		once
			create Result
		end

feature -- Framing

	global_writable: IV_ENTITY
			-- Procedure-wide writable frame.
		do
			create Result.make ("writable", types.frame)
		end

	global_readable: IV_ENTITY
			-- Procedure-wide readable frame.
		do
			create Result.make ("readable", types.frame)
		end

	frame_access (a_frame, a_obj, a_field: IV_EXPRESSION): IV_MAP_ACCESS
			-- Expression `a_frame [a_obj, a_field]'.
		do
			create Result.make (a_frame, create {ARRAYED_LIST [IV_EXPRESSION]}.make_from_array (<< a_obj, a_field >>))
		end

	writes_routine_frame (a_feature: FEATURE_I; a_type: CL_TYPE_A; a_boogie_procedure: IV_PROCEDURE): IV_EXPRESSION
			-- Boolean expression stating that only the modifies set of `a_feature' in `a_type' (translated into `a_boogie_procedure')
			-- has changed between the old heap and the current heap.
		local
			l_fcall: IV_FUNCTION_CALL
			l_old_heap: IV_EXPRESSION
		do
			l_old_heap := old_ (create {IV_ENTITY}.make ("Heap", types.heap))
			create l_fcall.make (name_translator.boogie_function_for_write_frame (a_feature, a_type), types.set (types.ref))
			l_fcall.add_argument (l_old_heap)
			across a_boogie_procedure.arguments as i loop
				l_fcall.add_argument (i.entity)
			end
			if helper.is_setter (a_feature) then
				Result := function_call ("flat_same_outside", <<l_old_heap, global_heap, l_fcall>>, types.bool)
			else
				Result := function_call ("same_outside", <<l_old_heap, global_heap, l_fcall>>, types.bool)
			end
				-- TODO: fix inlining
			if not a_boogie_procedure.name.has_substring (a_feature.feature_name) then
				Result := true_
			end
		end

feature -- Axioms

	add_dynamic_predicate_definition (a_call, a_body: IV_EXPRESSION; a_type: CL_TYPE_A; a_heap, a_current: IV_ENTITY; a_extra_vars: ARRAY [IV_ENTITY])
			-- Add axioms that define predicate `a_call' as `a_body' if the dynamic type of `a_current' is `a_type',
			-- and state that this definition can only be strengthened in descendants.
		local
			l_forall: IV_FORALL
		do
				-- type_of(current) == type  ==> call(heap, current) == body
			create l_forall.make (implies_ (
				function_call ("attached_exact", << a_heap, a_current, type_value (a_type) >>, types.bool),
				equiv (a_call, a_body)))
			l_forall.add_bound_variable (a_heap)
			l_forall.add_bound_variable (a_current)
			across a_extra_vars as v loop
				l_forall.add_bound_variable (v)
			end
			l_forall.add_trigger (a_call)

			boogie_universe.add_declaration (create {IV_AXIOM}.make (l_forall))

				-- If the definition is trivially true, no point stating that it is only strengthened.
			if not a_body.is_true then
					-- Inheritance axiom:
					-- type_of(current) <: type  ==> call(heap, current) ==> body
				create l_forall.make (implies_ (
						function_call ("attached", << a_heap, a_current, type_value (a_type) >>, types.bool),
						implies_ (a_call, a_body)))
				l_forall.add_bound_variable (a_heap)
				l_forall.add_bound_variable (a_current)
				across a_extra_vars as v loop
					l_forall.add_bound_variable (v)
				end
				l_forall.add_trigger (a_call)

				boogie_universe.add_declaration (create {IV_AXIOM}.make (l_forall))
			end
		end

feature -- Miscellaneous

	trace (a_text: READABLE_STRING_8): IV_STATEMENT
			-- Tracing statement.
		local
			l_assume: IV_ASSERT
		do
			create l_assume.make_assume (true_)
			l_assume.set_attribute_string (":captureState %"" + a_text + "%"")
			Result := l_assume
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2014 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
