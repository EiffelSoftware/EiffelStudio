note
	description: "[
			RULE #71: Self-comparison
	
			An expression comparing a variable to
			itself always evaluates to the same boolean value. The comparison is
			thus redundant. In an Until expression it may lead to non-termination.
			Usually it is a typing error.
		]"
	author: "Stefan Zurfluh", "Eiffel Software"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_SELF_COMPARISON_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
			default_severity_score := 70
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_bin_eq_pre_action (agent process_comparison ({BIN_EQ_AS}?))
			a_checker.add_bin_ne_pre_action (agent process_comparison ({BIN_NE_AS}?))
			a_checker.add_bin_ge_pre_action (agent process_comparison ({BIN_GE_AS}?))
			a_checker.add_bin_gt_pre_action (agent process_comparison ({BIN_GT_AS}?))
			a_checker.add_bin_le_pre_action (agent process_comparison ({BIN_LE_AS}?))
			a_checker.add_bin_lt_pre_action (agent process_comparison ({BIN_LT_AS}?))
			a_checker.add_bin_not_tilde_post_action (agent process_comparison ({BIN_NOT_TILDE_AS}?))
			a_checker.add_bin_tilde_post_action (agent process_comparison ({BIN_TILDE_AS}?))
		end

feature -- Properties

	name: STRING = "self_comparison"
			-- <Precursor>

	title: STRING_32
			--<Precursor>
		do
			Result := ca_names.self_comparison_title
		end

	id: STRING_32 = "CA071"
			-- <Precursor>

	description: STRING_32
			--<Precursor>
		do
			Result :=  ca_names.self_comparison_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
			-- Ignore the old-style output.
		do
		end

feature {NONE} -- Context analysis

	process_comparison (a: BINARY_AS)
			-- Checks `a' for rule violations.
		local
			value: PROCEDURE [TEXT_FORMATTER]
		do
			if attached {CURRENT_AS} a.left and then attached {CURRENT_AS} a.right then
				value := agent {TEXT_FORMATTER}.process_keyword_text ({TEXT_FORMATTER}.ti_current, Void)
			elseif attached {RESULT_AS} a.left and then attached {RESULT_AS} a.right then
				value := agent {TEXT_FORMATTER}.process_keyword_text ({TEXT_FORMATTER}.ti_result, Void)
			elseif
				attached {EXPR_CALL_AS} a.left as e1 and then
				attached {ACCESS_AS} e1.call as call1 and then
				attached {EXPR_CALL_AS} a.right as e2
			then
				if
					attached {ACCESS_FEAT_AS} call1 as l and then
					attached {ACCESS_FEAT_AS} e2.call as r and then
					l.feature_name.is_equal (r.feature_name)
				then
					if l.is_feature then
							-- It's a feature. Check that it is an attribute rather than a routine.
						if
							system.has_class_of_id (l.class_id) and then
							attached system.class_of_id (l.class_id) as c and then
							attached c.feature_of_rout_id (l.routine_ids.first) as f and then
							not f.is_routine
						then
							value := agent {TEXT_FORMATTER}.process_feature_text (l.feature_name.name_32, f.e_feature, True)
						end
					else
							-- It's a named local (including argument, object-test local, separate variable, iteration cursor).
						value := agent {TEXT_FORMATTER}.process_local_text (l.feature_name, l.feature_name.name_32)
					end
				elseif
					attached {PRECURSOR_AS} call1 as l and then
					attached {PRECURSOR_AS} e2.call as r and then
					system.has_class_of_id (l.class_id) and then
					attached system.class_of_id (l.class_id) as c and then
					attached c.feature_of_rout_id (l.routine_ids.first) as f and then
					f.is_attribute and then
					l.class_id = r.class_id
				then
					value := agent {TEXT_FORMATTER}.process_keyword_text ({TEXT_FORMATTER}.ti_precursor_keyword, f.e_feature)
				end
			end
			if attached value then
				put_violation
					(ca_messages.locale.translation_in_context ("{1} is compared to itself.", once "code_analysis.violation"),
					<<value>>,
					ca_messages.locale.translation_in_context ("Self-comparison: {1} compared to itself always evaluates to the same boolean value.", once "code_analysis.violation"),
					<<value>>,
					a.operator_index)
			end
		end

note
	copyright:	"Copyright (c) 2014-2020, Eiffel Software"
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
