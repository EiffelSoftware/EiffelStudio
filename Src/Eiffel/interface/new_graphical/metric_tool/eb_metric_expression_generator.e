note
	description: "Metric expression generator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_EXPRESSION_GENERATOR

inherit
	EB_METRIC_VISITOR

	SHARED_TEXT_ITEMS

	QL_SHARED_NAMES

	EB_METRIC_SHARED

create
	make

feature{NONE} -- Initialization

	make (a_output: like output)
			-- Initialize `output' with `a_output'.
		require
			a_output_attached: a_output /= Void
		do
			set_output (a_output)
		end

feature -- Access

	output: EB_METRIC_EXPRESSION_OUTPUT
			-- Generated metric expression output

feature -- Setting

	set_output (a_output: like output)
			-- Set `output' with `a_output'.
		require
			a_output_attached: a_output /= Void
		do
			output := a_output
		ensure
			output_set: output = a_output
		end

feature -- Output generation

	generate_output (a_item: EB_METRIC_VISITABLE)
			-- Generate output for `a_item'.
		require
			a_item_attached: a_item /= Void
		do
			a_item.process (Current)
			output.prepare_output
		end

feature{NONE} -- Process

	process_basic_metric (a_basic_metric: EB_METRIC_BASIC)
			-- Process `a_basic_metric'.
		do
			if a_basic_metric.criteria /= Void then
				a_basic_metric.criteria.process (Current)
			end
		end

	process_linear_metric (a_linear_metric: EB_METRIC_LINEAR)
			-- Process `a_linear_metric'.
		local
			l_metrics: LIST [STRING]
			l_coefficients: LIST [DOUBLE]
			l_is_first: BOOLEAN
			l_coefficient: DOUBLE
			l_output: like output
		do
			l_output := output
			l_metrics := a_linear_metric.variable_metric
			l_coefficients := a_linear_metric.coefficient
			from
				l_is_first := True
				l_metrics.start
				l_coefficients.start
			until
				l_metrics.after or l_coefficients.after
			loop
				l_coefficient := l_coefficients.item
				if l_coefficient >= 0 then
					if not l_is_first then
						l_output.put_operator (once " + ")
					end
				else
					if not l_is_first then
						l_output.put_operator (once " - ")
					else
						l_output.put_operator (once "- ")
					end
				end
				l_output.put_double (l_coefficient.abs)
				l_output.put_operator (once " * ")
				l_output.put_normal_text (ti_l_parenthesis.as_string_32)
				l_output.put_metric_name (l_metrics.item)

				l_output.put_normal_text (ti_r_parenthesis.as_string_32)
				l_is_first := False
				l_metrics.forth
				l_coefficients.forth
			end
		end

	process_ratio_metric (a_ratio_metric: EB_METRIC_RATIO)
			-- Process `a_ratio_metric'.
		do
			append_metric (a_ratio_metric.numerator_coefficient, a_ratio_metric.numerator_metric_name)
			output.put_operator (once " / ")
			append_metric (a_ratio_metric.denominator_coefficient, a_ratio_metric.denominator_metric_name)
		end

	process_criterion (a_criterion: EB_METRIC_CRITERION)
			-- Process `a_criterion'.
		do
		end

	process_domain_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION)
			-- Process `a_criterion'.
		do
			process_domain_criterion_internal (a_criterion, Void, Void)
		end

	process_domain_criterion_internal (a_criterion: EB_METRIC_DOMAIN_CRITERION; a_modifiers: LIST [STRING_GENERAL]; a_modifier_separator: STRING_GENERAL)
			-- Process `a_criterion'.
			-- If `a_modifiers' is not Void, display those modifiers (separated by `a_modifier_separator') as well.
		require
			a_criterion_attached: a_criterion /= Void
			a_modifiers_valid: a_modifiers /= Void implies (not a_modifiers.has (Void))
			a_modifier_separator_valid: (a_modifiers /= Void and then not a_modifiers.is_empty) implies a_modifier_separator /= Void
		local
			l_output: like output
			l_cursor: CURSOR
		do
			l_output := output
			append_negation_start (a_criterion)
			l_output.put_criterion_name (a_criterion)
			l_output.put_normal_text (ti_space.as_string_32)
			l_output.put_normal_text (ti_l_parenthesis.as_string_32)
			process_domain_internal (a_criterion.domain)
				-- Process modifiers if any.
			if a_modifiers /= Void and then not a_modifiers.is_empty then
				l_output.put_operator (", ")
				l_cursor := a_modifiers.cursor
				from
					a_modifiers.start
				until
					a_modifiers.after
				loop
					l_output.put_modifier (a_modifiers.item)
					if a_modifiers.index < a_modifiers.count then
						l_output.put_normal_text (" ")
						l_output.put_operator (a_modifier_separator)
						l_output.put_normal_text (" ")
					end
					a_modifiers.forth
				end
				a_modifiers.go_to (l_cursor)
			end
			l_output.put_normal_text (ti_r_parenthesis.as_string_32)
			append_negation_end (a_criterion)
		end

	process_caller_callee_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION)
			-- Process `a_criterion'.		
		local
			l_modifiers: ARRAYED_LIST [STRING_GENERAL]
		do
			create l_modifiers.make (2)
			if a_criterion.only_current_version then
				l_modifiers.extend (metric_names.l_current_version)
			else
				l_modifiers.extend (metric_names.l_current)
				l_modifiers.extend (metric_names.l_desendent_versions)
			end
			process_domain_criterion_internal (a_criterion, l_modifiers, "+")
		end

	process_supplier_client_criterion (a_criterion: EB_METRIC_SUPPLIER_CLIENT_CRITERION)
			-- Process `a_criterion'.
		local
			l_modifiers: ARRAYED_LIST [STRING_GENERAL]
		do
			create l_modifiers.make (3)
			if a_criterion.indirect_referenced_class_retrieved then
				l_modifiers.extend (metric_names.l_indirect)
			else
				l_modifiers.extend (metric_names.l_direct)
			end
			if a_criterion.normal_referenced_class_retrieved then
				l_modifiers.extend (metric_names.l_normal_referenced)
			end
			if a_criterion.only_syntactically_referencedd_class_retrieved then
				l_modifiers.extend (metric_names.l_syntactical_referenced)
			end
			process_domain_criterion_internal (a_criterion, l_modifiers, "+")
		end

	process_text_criterion_internal (a_criterion: EB_METRIC_TEXT_CRITERION; a_show_matching_strategy: BOOLEAN)
			-- Process `a_criterion'.
			-- If `a_show_matching_strategy' is True, display matching strategy modifier.
		require
			a_criterion_attached: a_criterion /= Void
		local
			l_output: like output
		do
			l_output := output
			append_negation_start (a_criterion)
			l_output.put_criterion_name (a_criterion)
			l_output.put_normal_text (once " ")
			l_output.put_normal_text (ti_l_parenthesis.as_string_32)
			if a_criterion.text.is_empty then
				l_output.put_warning ("%"%"")
			else
				l_output.put_string (a_criterion.text)
			end
			l_output.put_normal_text (", ")
			if a_show_matching_strategy then
				l_output.put_modifier (names.string_general_as_lower (matching_strategy_names_table.item (a_criterion.matching_strategy)))
				l_output.put_operator (" + ")
			end
			if a_criterion.is_case_sensitive then
				l_output.put_modifier (names.string_general_as_lower (metric_names.t_case_sensitive))
			else
				l_output.put_modifier (names.string_general_as_lower (metric_names.t_case_insensitive))
			end
			l_output.put_normal_text (ti_r_parenthesis.as_string_32)
			append_negation_end (a_criterion)
		end

	process_text_criterion (a_criterion: EB_METRIC_TEXT_CRITERION)
			-- Process `a_criterion'.
		do
			process_text_criterion_internal (a_criterion, True)
		end

	process_path_criterion (a_criterion: EB_METRIC_PATH_CRITERION)
			-- Process `a_criterion'.
		do
			process_text_criterion_internal (a_criterion, False)
		end

	process_normal_criterion (a_criterion: EB_METRIC_NORMAL_CRITERION)
			-- Process `a_criterion'.
		do
			append_negation_start (a_criterion)
			output.put_criterion_name (a_criterion)
			append_negation_end (a_criterion)
		end

	process_value_criterion (a_criterion: EB_METRIC_VALUE_CRITERION)
			-- Process `a_criterion'.
		local
			l_output: like output
		do
			l_output := output
			l_output.put_normal_text ("value of metric (")
			l_output.put_metric_name (a_criterion.metric_name)
			if a_criterion.should_delayed_domain_from_parent_be_used then
				l_output.put_normal_text (", ")
				l_output.put_modifier (metric_names.l_use_external_delayed_domain)
			end
			l_output.put_normal_text (") over (")
			process_domain_internal (a_criterion.domain)
			l_output.put_normal_text (") is (")
			a_criterion.value_tester.process (Current)
			l_output.put_normal_text (ti_r_parenthesis.as_string_32)
		end

	process_external_command_criterion (a_criterion: EB_METRIC_EXTERNAL_COMMAND_CRITERION)
			-- Process `a_criterion'.
		local
			l_output: like output
		do
			l_output := output
			l_output.put_normal_text ("satisfies command (")
			a_criterion.tester.process (Current)
			l_output.put_normal_text (")")
		end

	process_nary_criterion (a_criterion: EB_METRIC_NARY_CRITERION)
			-- Process `a_criterion'.
		local
			l_para_needed: BOOLEAN
			l_count: INTEGER
			l_operands: LIST [EB_METRIC_CRITERION]
			l_output: like output
		do
			l_output := output
			l_para_needed := a_criterion.operands.count > 1
			append_negation_start (a_criterion)
			if l_para_needed then
				l_output.put_normal_text (ti_l_parenthesis.as_string_32)
			end
			from
				l_operands := a_criterion.operands
				l_count := l_operands.count
				l_operands.start
			until
				l_operands.after
			loop
				if l_para_needed and then l_operands.item.is_nary_criterion then
					l_output.put_normal_text (ti_l_parenthesis.as_string_32)
				end
				l_operands.item.process (Current)
				if l_para_needed and then l_operands.item.is_nary_criterion then
					l_output.put_normal_text (ti_r_parenthesis.as_string_32)
				end
				if l_operands.index < l_count then
					l_output.put_normal_text (ti_space.as_string_32)
					l_output.put_criterion_name (a_criterion)
					l_output.put_normal_text (ti_space.as_string_32)
				end
				a_criterion.operands.forth
			end
			if l_para_needed then
				l_output.put_normal_text (ti_r_parenthesis.as_string_32)
			end
			append_negation_end (a_criterion)
		end

	process_and_criterion (a_criterion: EB_METRIC_AND_CRITERION)
			-- Process `a_criterion'.
		do
			process_nary_criterion (a_criterion)
		end

	process_or_criterion (a_criterion: EB_METRIC_OR_CRITERION)
			-- Process `a_criterion'.
		do
			process_nary_criterion (a_criterion)
		end

	process_domain (a_domain: EB_METRIC_DOMAIN)
			-- Process `a_domain'.
		local
			l_count: INTEGER
			l_output: like output
		do
			from
				l_output := output
				l_count := a_domain.count
				a_domain.start
			until
				a_domain.after
			loop
				if a_domain.item /= Void then
					a_domain.item.process (Current)
				end
				if a_domain.index < l_count then
					l_output.put_normal_text (ti_comma.as_string_32)
					l_output.put_normal_text (ti_space.as_string_32)
				end
				a_domain.forth
			end
		end

	process_domain_item (a_item: EB_METRIC_DOMAIN_ITEM)
			-- Process `a_item'.
		do
		end

	process_application_target_domain_item (a_item: EB_METRIC_TARGET_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			output.put_target_domain_item (a_item)
		end

	process_group_domain_item (a_item: EB_METRIC_GROUP_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			output.put_group_domain_item (a_item)
		end

	process_folder_domain_item (a_item: EB_METRIC_FOLDER_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			output.put_folder_domain_item (a_item)
		end

	process_class_domain_item (a_item: EB_METRIC_CLASS_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			output.put_class_domain_item (a_item)
		end

	process_feature_domain_item (a_item: EB_METRIC_FEATURE_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			output.put_feature_domain_item (a_item)
		end

	process_delayed_domain_item (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			output.put_delayed_domain_item (a_item)
		end

	process_metric_archive_node (a_item: EB_METRIC_ARCHIVE_NODE)
			-- Process `a_item'.
		do
		end

	process_value_retriever (a_item: EB_METRIC_VALUE_RETRIEVER)
			-- Process `a_item'.
		do
		end

	process_value_tester (a_item: EB_METRIC_VALUE_TESTER)
			-- Process `a_item'.
		local
			l_cri_list: LIST [TUPLE [l_retriever: EB_METRIC_VALUE_RETRIEVER; l_criterion_type: INTEGER]]
			l_count: INTEGER
			l_connector: STRING
			l_output: like output
		do
			l_output := output
			if a_item.criteria.is_empty then
				l_output.put_warning (metric_names.l_no_value_tester)
			else
				if a_item.is_anded then
					l_connector := query_language_names.ql_cri_and
				else
					l_connector := query_language_names.ql_cri_or
				end
				from
					l_cri_list := a_item.criteria
					l_count := l_cri_list.count
					l_cri_list.start
				until
					l_cri_list.after
				loop
					l_output.put_operator (operator_table.item (l_cri_list.item.l_criterion_type))
					l_cri_list.item.l_retriever.process (Current)
					if l_cri_list.index < l_count then
						l_output.put_normal_text (ti_space.as_string_32)
						l_output.put_keyword (l_connector)
						l_output.put_normal_text (ti_space.as_string_32)
					end
					l_cri_list.forth
				end
			end
		end

	process_constant_value_retriever (a_item: EB_METRIC_CONSTANT_VALUE_RETRIEVER)
			-- Process `a_item'.
		do
			output.put_double (a_item.value_internal)
		end

	process_metric_value_retriever (a_item: EB_METRIC_METRIC_VALUE_RETRIEVER)
			-- Process `a_item'.
		local
			l_output: like output
		do
			l_output := output
			l_output.put_normal_text ("value of metric (")
			l_output.put_metric_name (a_item.metric_name)
			l_output.put_normal_text (") over (")
			process_domain_internal (a_item.input_domain)
			l_output.put_normal_text (")")
		end

	process_domain_internal (a_domain: EB_METRIC_DOMAIN)
			-- Process `a_domain'.
		require
			a_domain_attached: a_domain /= Void
		do
			if a_domain.is_empty then
				output.put_warning (metric_names.l_empty_domain)
			else
				a_domain.process (Current)
			end
		end

	process_external_command_tester (a_item: EB_METRIC_EXTERNAL_COMMAND_TESTER)
			-- Process `a_item'.
		local
			l_first: BOOLEAN
			l_output: like output
		do
			l_output := output
			l_output.put_string (a_item.command)
			l_first := True
			if not a_item.input.is_empty then
				l_output.put_normal_text (ti_comma.as_string_32)
				l_output.put_normal_text (ti_space.as_string_32)
				l_first := False
				if a_item.is_input_as_file then
					l_output.put_modifier ("input as file")
				else
					l_output.put_modifier ("input")
				end
			end
			if a_item.is_output_enabled then
				if not l_first then
					l_output.put_operator (" + ")
				else
					l_output.put_normal_text (ti_comma.as_string_32)
					l_output.put_normal_text (ti_space.as_string_32)
					l_first := False
				end
				if a_item.is_output_as_file then
					l_output.put_modifier ("output as file")
				else
					l_output.put_modifier ("output")
				end
			end
			if a_item.is_error_enabled then
				if not l_first then
					l_output.put_operator (" + ")
				else
					l_output.put_normal_text (ti_comma.as_string_32)
					l_output.put_normal_text (ti_space.as_string_32)
					l_first := False
				end
				if not a_item.is_error_redirected_to_output then
					if a_item.is_error_as_file then
						l_output.put_modifier ("error as file")
					else
						l_output.put_modifier ("error")
					end
				end
			end
			if a_item.is_exit_code_enabled then
				if not l_first then
					l_output.put_operator (" + ")
				else
					l_output.put_normal_text (ti_comma.as_string_32)
					l_output.put_normal_text (ti_space.as_string_32)
				end
				l_output.put_modifier ("exit code (")
				l_output.put_integer (a_item.exit_code)
				l_output.put_modifier (")")
			end
		end

feature{NONE} -- Implementation

	append_negation_start (a_criterion: EB_METRIC_CRITERION)
			-- Append negation for `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		local
			l_output: like output
		do
			l_output := output
			if a_criterion.is_negation_used then
				l_output.put_normal_text (ti_l_parenthesis.as_string_32)
				l_output.put_keyword (ti_not_keyword.as_string_32)
				l_output.put_normal_text (ti_space.as_string_32)
			end
		end

	append_negation_end (a_criterion: EB_METRIC_CRITERION)
			-- Append negation end.
		require
			a_criterion_attached: a_criterion /= Void
		do
			if a_criterion.is_negation_used then
				output.put_normal_text (ti_r_parenthesis.as_string_32)
			end
		end

	append_metric (a_coefficient: DOUBLE; a_metric_name: STRING)
			-- Append `a_metric_name' with `a_coefficient'.
		require
			a_metric_name_attached: a_metric_name /= Void
		local
			l_output: like output
		do
			l_output := output
			l_output.put_normal_text (ti_l_parenthesis.as_string_32)
			l_output.put_double (a_coefficient)
			l_output.put_normal_text (ti_space.as_string_32)
			l_output.put_operator (once "*")
			l_output.put_normal_text (ti_space.as_string_32)
			l_output.put_metric_name (a_metric_name)
			l_output.put_normal_text (ti_r_parenthesis.as_string_32)
		end

invariant
	output_attached: output /= Void

note
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

end
