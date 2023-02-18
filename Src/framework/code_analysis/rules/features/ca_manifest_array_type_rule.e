note
	description: "[
			RULE #93: Manifest array type
			
			The type of the manifest array does not match the array type of the target.
			This may lead to cat-calls.
		]"

class
	CA_MANIFEST_ARRAY_TYPE_RULE

inherit
	CA_STANDARD_RULE
		rename
			make_with_defaults as make
		redefine
			make
		end

	SHARED_LOCALE

create
	make

feature {NONE} -- Creation

	make
			-- <Precursor>
		do
			Precursor
			create {ARRAYED_STACK [FEATURE_I]} current_features.make (1)
		end

feature {NONE} -- Activation

	register_actions (c: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
				-- Context setup.
			c.add_feature_pre_action (agent process_feature_start)
			c.add_feature_post_action (agent process_feature_end)
			c.add_invariant_pre_action (agent process_invariant_start)
			c.add_invariant_post_action (agent process_invariant_end)
				-- Processing.
			c.add_assign_pre_action (agent process_assign)
			c.add_binary_pre_action (agent process_binary)
			c.add_bracket_pre_action (agent process_bracket)
			c.add_expression_call_pre_action (agent process_expr_call)
			c.add_inline_agent_creation_pre_action (agent process_agent_start)
			c.add_inline_agent_creation_post_action (agent process_agent_end)
			c.add_instruction_call_pre_action (agent process_instr_call)
			c.add_nested_expr_pre_action (agent process_nested_expr)
			c.add_precursor_pre_action (agent process_precursor)
			checker := c
		end

feature -- Properties

	name: STRING = "manifest_array_type_mismatch"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.manifest_array_type_mismatch_title
		end

	id: STRING_32 = "CA093"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result :=  ca_names.manifest_array_type_mismatch_description
		end

	format_violation_description (violation: CA_RULE_VIOLATION; formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
		end

feature {NONE} -- State

	checker: CA_ALL_RULES_CHECKER
			-- Code analysis iterator.

feature {NONE} -- Context

	current_feature: FEATURE_I
			-- A feature currently being processed (Void for class invariant).
		require
			has_current_feature: not current_features.is_empty
		do
			Result := current_features.item
		end

	current_features: STACK [FEATURE_I]
			-- A stack of descriptors of a currently being processed features (empty for class invariant).

	process_feature_start (a: FEATURE_AS)
			-- Remember the feature `current_feature` associated with `a`.
		do
			current_features.put (current_context.checking_class.feature_named_32 (a.feature_name.name_32))
		ensure
			current_feature_added: current_features.count = old current_features.count + 1
		end

	process_feature_end (a: FEATURE_AS)
			-- Forget `current_feature`.
		do
			check
				current_feature_exists: attached current_feature
				current_feature_expected: current_feature = current_context.checking_class.feature_named_32 (a.feature_name.name_32)
			end
			current_features.remove
		ensure
			current_feature_removed: current_features.count = old current_features.count - 1
		end

	process_invariant_start (a: INVARIANT_AS)
			-- Remember the feature `current_feature` associated with `a`.
		do
			if attached current_context.checking_class.invariant_feature as f then
				current_features.put (f)
			end
		ensure
			current_feature_added: attached current_context.checking_class.invariant_feature implies current_features.count = old current_features.count + 1
			no_current_feature: not attached current_context.checking_class.invariant_feature implies current_features.count = old current_features.count
		end

	process_invariant_end (a: INVARIANT_AS)
			-- Forget `current_feature`.
		do
			if attached current_feature then
				check
					current_feature_expected: current_feature = current_context.checking_class.invariant_feature
				end
				current_features.remove
			else
				check
					no_invariant_feature: not attached current_context.checking_class.invariant_feature
				end
			end
		ensure
			current_feature_removed: attached current_context.checking_class.invariant_feature implies current_features.count = old current_features.count - 1
			no_current_feature: not attached current_context.checking_class.invariant_feature implies current_features.count = old current_features.count
		end

feature {NONE} -- Checking the rule

	process_agent_start (a: INLINE_AGENT_CREATION_AS)
			-- Remember the feature `current_feature` associated with `a`.
		do
			current_features.put (current_context.checking_class.feature_of_rout_id (a.routine_ids.first))
		ensure
			current_feature_added: current_features.count = old current_features.count + 1
		end

	process_agent_end (a: INLINE_AGENT_CREATION_AS)
			-- Forget `current_feature`.
		do
			check
				current_feature_exists: attached current_feature
				current_feature_expected: current_feature = current_context.checking_class.feature_of_rout_id (a.routine_ids.first)
			end
			current_features.remove
		ensure
			current_feature_removed: current_features.count = old current_features.count - 1
		end

	process_assign (a: ASSIGN_AS)
			-- Check `a` for rule violations.
		do
			check_array_type (a.source, current_context.node_type (a.target, current_feature))
		end

	process_binary (a: BINARY_AS)
			-- Check operand of `a` for rule violations.
		local
			c: CLASS_C
		do
			c := current_context.checking_class
			if
				attached current_context.node_type (a.left, current_feature) as left_type and then
				attached system.class_of_id (a.class_id) as operator_class and then
				attached operator_class.feature_of_rout_id (a.routine_ids.first) as operator_feature
			then
				check_array_type (a.right, operator_feature.arguments.first.instantiation_in (left_type, c.class_id))
			end
		end

	process_bracket (a: BRACKET_AS)
			-- Check operand of `a` for rule violations.
		do
			if
				attached current_context.node_type (a.target, current_feature) as target_type and then
				attached system.class_of_id (a.class_id) as operator_class and then
				attached operator_class.feature_of_rout_id (a.routine_ids.first) as operator_feature
			then
				process_arguments (a.operands, a, target_type)
			end
		end

	process_expr_call (a: EXPR_CALL_AS)
			-- Check arguments of `a` for rule violations.
		do
			process_call (a.call, current_context.checking_class.actual_type)
		end

	process_instr_call (a: INSTR_CALL_AS)
			-- Check arguments of `a` for rule violations.
		do
			process_call (a.call, current_context.checking_class.actual_type)
		end

	process_nested_expr (a: NESTED_EXPR_AS)
			-- Check arguments of the call in `a` for rule violations.
		do
			process_call (a.message, current_context.node_type (a.target, current_feature))
		end

	process_precursor (a: PRECURSOR_AS)
			-- Check arguments of `a` for rule violations.
		do
			process_argument_list (a.internal_parameters, a.precursor_keyword, a, current_context.checking_class.actual_type)
		end

	process_call (a: CALL_AS; t: TYPE_A)
			-- Check arguments of `a` called on type `t` for rule violations.
		do
			if attached {STATIC_ACCESS_AS} a as g then
					-- Use explicit type.
				process_argument_list (g.internal_parameters, g.feature_name, g, current_context.node_type (g.class_type, current_feature))
			elseif attached {ACCESS_FEAT_AS} a as g then
					-- Use context type.
				process_argument_list (g.internal_parameters, g.feature_name, g, t)
			end
		end

	process_argument_list (a: PARAMETER_LIST_AS; p: AST_EIFFEL; r: ID_SET_ACCESSOR; t: TYPE_A)
			-- Check arguments `p` passed to a routine identified by `r` called on type `t` for rule violations
			-- taking into account the possibility of a parentheses call on a target identified by `p`.
		do
			if attached a and then attached a.parameters as actual_arguments then
				if
					attached system.class_of_id (r.class_id) as c and then
					attached c.feature_of_rout_id (r.routine_ids.first) as f and then
					f.argument_count > 0
				 then
						-- It must be a normal call.
					process_arguments (actual_arguments, r, t)
				elseif
					a.class_id /= 0 and then
					a.routine_ids.first /= 0 and then
					attached p and then
					attached current_context.node_type (p, current_feature) as q
				then
						-- It must be a parenthesis call.
					process_arguments (actual_arguments, a, q)
				end
			end
		end

	process_arguments (a: detachable EIFFEL_LIST [EXPR_AS]; r: ID_SET_ACCESSOR; t: TYPE_A)
			-- Check arguments `p` passed to a routine identified by `r` called on type `t` for rule violations.
		local
			actual_arguments: like {EIFFEL_LIST [EXPR_AS]}.new_cursor
		do
			if
				attached a and then
				attached system.class_of_id (r.class_id) as c and then
				attached c.feature_of_rout_id (r.routine_ids.first) as f and then
				attached f.arguments as formal_arguments
			then
				across
					formal_arguments as formal_argument
				from
					actual_arguments := a.new_cursor
				loop
					if attached t.base_class as b then
						check_array_type (actual_arguments.item, formal_argument.evaluated_type_in_descendant (c,b,current_feature).instantiation_in (t, b.class_id))
					end
					actual_arguments.forth
				end
			end
		end

	check_array_type (e: EXPR_AS; t: TYPE_A)
			-- Check that the expression `e` is a manifest array which type matches the target type `t` of a reattachment.
		local
			array_type: TYPE_A
			v: like {EIFFEL_LIST [EXPR_AS]}.new_cursor
			violation: CA_RULE_VIOLATION
			c: CLASS_C
			f: FEATURE_I
		do
			if attached {ARRAY_AS} e as a then
				if not attached a.type then
					c := current_context.checking_class
					f := current_feature
					array_type := current_context.node_type (a, f).as_normally_attached (c)
					if
						attached {GEN_TYPE_A} t.conformance_type.as_normally_attached (c) as target_type and then
						attached target_type.base_class as b and then
						b.name.is_case_insensitive_equal_general ("ARRAY") and then
						not (array_type.conform_to (c, target_type) and target_type.conform_to (c, array_type))
					then
						create violation.make_formatted
							(agent format_elements (?, locale.translation_in_context ("Manifest array type differs from target array type.", "code_analyzer"), <<>>),
							agent format_elements (?, locale.translation_in_context ("[
									Manifest array of type {1} is used in a reattachment with target type {2}:
										- add an explicit manifest array type;
										- change target type to make sure the types are the same;
										- disable the rule "{3}" in the code analizer preferences or add the rule {4} to the list of ignored rules of the class.
								]", "code_analyzer"),
								<<agent array_type.ext_append_to (?, c),
								agent target_type.ext_append_to (?, c),
								agent {TEXT_FORMATTER}.add (ca_names.manifest_array_type_mismatch_title),
								agent {TEXT_FORMATTER}.add (id)>>), Current)
						violation.set_location (a.first_token (System.match_list_server.item (c.class_id)))
						violation.fixes.extend (create {FIX_MANIFEST_ARRAY_TYPE_ADDER}.make
							(create {CA_MANIFEST_ARRAY_TYPE_PROVIDER}.make (c.lace_class, f.e_feature, target_type, a)))
						violations.extend (violation)
					end
				end
			elseif attached {TUPLE_AS} e as s then
				c := current_context.checking_class
				if
					attached {TUPLE_TYPE_A} t.conformance_type.as_normally_attached (c) as target_type and then
					attached target_type.generics as generics and then
					attached s.expressions as expressions and then
					generics.count = expressions.count
				then
					across
						generics as g
					from
						v := expressions.new_cursor
					loop
						check_array_type (v.item, g)
						v.forth
					end
				end
			elseif attached {PARAN_AS} e as p then
				check_array_type (p.expr, t)
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright:	"Copyright (c) 2018-2023, Eiffel Software"
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
