note
	description: "[
			RULE #63: Manifest array type
			
			The type of the manifest array does not match the array type of the target.
			This may lead to cat-calls.
		]"
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

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
			create {ARRAYED_STACK [FEATURE_I]} current_feature.make (1)
		end

feature {NONE} -- Activation

	register_actions (c: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			c.add_feature_pre_action (agent process_feature_start)
			c.add_feature_post_action (agent process_feature_end)
			c.add_assign_pre_action (agent process_assign)
			c.add_instruction_call_pre_action (agent process_instr_call_as)
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

feature {NONE} -- Checking the rule

	current_feature: STACK [FEATURE_I]
			-- A stack of descriptors of a currently being processed features (empty for class invariant).

	process_feature_start (a: FEATURE_AS)
			-- Remember the feature `current_feature` associated with `a`.
		do
			current_feature.put (current_context.checking_class.feature_named_32 (a.feature_name.name_32))
		ensure
			current_feature_added: current_feature.count = old current_feature.count + 1
		end

	process_feature_end (a: FEATURE_AS)
			-- Forget `current_feature`.
		do
			check
				current_feature_exists: not current_feature.is_empty
				current_feature_expected: current_feature.item = current_context.checking_class.feature_named_32 (a.feature_name.name_32)
			end
			current_feature.remove
		ensure
			current_feature_removed: current_feature.count = old current_feature.count - 1
		end

	process_assign (a: ASSIGN_AS)
			-- Check `a` for rule violations.
		do
			check_array_type (a.source, a.target)
		end

	process_instr_call_as (a: INSTR_CALL_AS)
			-- Check arguments of `a` for rule violations.
		local
			c: CLASS_C
			t: TYPE_A
			actual_arguments: like {EIFFEL_LIST [EXPR_AS]}.new_cursor
			actual_argument: EXPR_AS
		do
			c := current_context.checking_class
			if
				attached {ACCESS_FEAT_AS} a.call as g and then
				attached g.parameters as p and then
				attached c.feature_of_rout_id (g.routine_ids.first) as f and then
				attached f.arguments as formal_arguments
			then
				t := c.actual_type
				across
					formal_arguments as formal_argument
				from
					actual_arguments := p.new_cursor
				loop
--					check_array_type (actual_arguments.item, formal_argument.item.instantiation_in (t, c.class_id))
				end
			end
		end

	check_array_type (e: EXPR_AS; t: AST_EIFFEL)
			-- Check that the expression `e` is a manifest array which type matches the target type of a reattachment to `t`.
		local
			array_type: TYPE_A
			violation: CA_RULE_VIOLATION
			c: CLASS_C
			f: FEATURE_I
		do
			if attached {ARRAY_AS} e as a then
				if not attached a.type then
					c := current_context.checking_class
					f := current_feature.item
					array_type := current_context.node_type (a, f).as_normally_attached (c)
					if
						attached {GEN_TYPE_A} current_context.node_type (t, f) as raw_target_type and then
						attached raw_target_type.as_normally_attached (c) as target_type and then
						attached target_type.base_class as b and then
						b.name.is_case_insensitive_equal_general ("ARRAY") and then
						not (array_type.conform_to (c, target_type) and target_type.conform_to (c, array_type))
					then
						create violation.make_formatted
							(agent format_elements (?, locale.translation_in_context ("Manifest array type differs from target array type.", "code_analyzer"), <<>>),
							agent format_elements (?, locale.translation_in_context ("[
									Manifest array of type {1} is used in a reattachment with target type {2}:
										- consider adding an explicit manifest array type to make sure the types are the same.
										- disable the rule "{3}" in the code analizer preferences.
								]", "code_analyzer"),
								<<agent array_type.ext_append_to (?, c),
								agent target_type.ext_append_to (?, c),
								agent {TEXT_FORMATTER}.add (ca_names.manifest_array_type_mismatch_title)>>), Current)
						violation.set_location (a.first_token (System.match_list_server.item (c.class_id)))
						violation.fixes.extend (create {FIX_MANIFEST_ARRAY_TYPE_ADDER}.make
							(create {CA_MANIFEST_ARRAY_TYPE_PROVIDER}.make (c.lace_class, f.e_feature, target_type, a)))
						violations.extend (violation)
					end
				end
			elseif attached {PARAN_AS} e as p then
				check_array_type (p.expr, t)
			end
		end

note
	copyright:	"Copyright (c) 2018, Eiffel Software"
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
