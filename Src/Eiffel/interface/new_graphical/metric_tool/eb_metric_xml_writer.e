note
	description: "Generator to generate xml for metric related items"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_XML_WRITER [G -> EB_METRIC_VISITABLE]

inherit
	EB_METRIC_XML_CONSTANTS

	EB_METRIC_VISITOR

	QL_SHARED_NAMES

	EB_METRIC_SHARED

create
	make

feature{NONE} -- Implementation

	make
			-- Initialize.
		do
			create element_stack.make
			create namespace.make_default
		end

feature -- Generate

	xml_element (a_item: G; a_parent: XM_COMPOSITE): XM_ELEMENT
			-- Xml element for `a_item'
			-- Generated xml element will be the last child of `a_parent'.
		require
			a_item_attached: a_item /= Void
			a_parent_attached: a_parent /= Void
		do
			element_stack.wipe_out
			element_stack.extend (a_parent)
			a_item.process (Current)
			Result := target_element
		ensure
			result_attached: Result /= Void
		end

	xml_document (a_item: G): XM_DOCUMENT
			-- Xml document for `a_item'
		local
			l_element: XM_ELEMENT
		do
			create Result.make
			element_stack.extend (Result)
			l_element := xml_element (a_item, Result)
			Result.wipe_out
			Result.set_root_element (l_element)
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	element_stack: LINKED_STACK [XM_COMPOSITE]
			-- Stack of generated xml element

	namespace: XM_NAMESPACE
			-- Default name space

	target_element: XM_ELEMENT
			-- Last recored element

	matching_strategy_name (a_strategy_id: INTEGER): STRING
			-- Matching strategy name of strategy id `a_strategy_id'
		local
			l_table: like matching_strategy_table
		do
			l_table := matching_strategy_table
			from
				l_table.start
			until
				l_table.after or Result /= Void
			loop
				if l_table.item_for_iteration = a_strategy_id then
					Result := l_table.key_for_iteration
				end
				l_table.forth
			end
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Process

	process_metric (a_metric: EB_METRIC; a_metric_element: XM_ELEMENT)
			-- Process `a_metric' to generate attribute name, unit and description.
			-- `a_metric_element' is the XML element for `a_metric'.
		require
			a_metric_attached: a_metric /= Void
			a_metric_element_attached: a_metric_element /= Void
		local
			l_stack: like element_stack
			l_description: XM_ELEMENT
			l_content: XM_CHARACTER_DATA
		do
			l_stack := element_stack

				-- Generate attribute "name", "unit".
			a_metric_element.add_unqualified_attribute (n_name, a_metric.name)
			a_metric_element.add_unqualified_attribute (n_unit, a_metric.unit.name)

				-- Generate "description" element if any.
			if a_metric.description /= Void then
				create l_description.make_last (a_metric_element, n_description, namespace)
				create l_content.make_last (l_description, a_metric.description)
			end
		end

	process_basic_metric (a_basic_metric: EB_METRIC_BASIC)
			-- Process `a_basic_metric'.
		local
			l_criterion: XM_ELEMENT
			l_metric: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
				-- Generate basic metric element.
			l_parent := element_stack.item
			create l_metric.make (l_parent, n_basic_metric, namespace)
			l_parent.force_last (l_metric)
			element_stack.extend (l_metric)

			process_metric (a_basic_metric, l_metric)
				-- Generate "criterion" element if any.
			if a_basic_metric.criteria /= Void then
				l_parent := element_stack.item
				create l_criterion.make (l_parent, n_criterion, namespace)
				l_parent.force_last (l_criterion)
				element_stack.extend (l_criterion)
				a_basic_metric.criteria.process (Current)
				element_stack.remove
			end
			target_element := l_metric
			element_stack.remove
		end

	process_linear_metric (a_linear_metric: EB_METRIC_LINEAR)
			-- Process `a_linear_metric'.
		local
			l_variable_metric: LIST [STRING]
			l_coefficient: LIST [DOUBLE]
			l_metric: XM_ELEMENT
			l_linear: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
				-- Generate basic linear element.
			l_parent := element_stack.item
			create l_linear.make (l_parent, n_linear_metric, namespace)
			l_parent.force_last (l_linear)
			element_stack.extend (l_linear)

			process_metric (a_linear_metric, l_linear)
			if a_linear_metric.variable_metric /= Void and then not a_linear_metric.variable_metric.is_empty then
				from
					l_variable_metric := a_linear_metric.variable_metric
					l_coefficient := a_linear_metric.coefficient
					l_variable_metric.start
					l_coefficient.start
				until
					l_variable_metric.after
				loop
					create l_metric.make_last (l_linear, n_variable_metric, namespace)
					l_metric.add_unqualified_attribute (n_name, l_variable_metric.item)
					l_metric.add_unqualified_attribute (n_coefficient, l_coefficient.item.out)
					l_variable_metric.forth
					l_coefficient.forth
				end
			end

			target_element := l_linear
			element_stack.remove
		end

	process_ratio_metric (a_ratio_metric: EB_METRIC_RATIO)
			-- Process `a_ratio_metric'.
		local
			l_ratio: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
				-- Generate ratio metric element.
			l_parent := element_stack.item
			create l_ratio.make (l_parent, n_ratio_metric, namespace)
			l_parent.force_last (l_ratio)
			process_metric (a_ratio_metric, l_ratio)
			element_stack.extend (l_ratio)

				-- Add attributes to element.
			l_ratio.add_unqualified_attribute (n_numerator, a_ratio_metric.numerator_metric_name)
			l_ratio.add_unqualified_attribute (n_numerator_coefficient, a_ratio_metric.numerator_coefficient.out)
			l_ratio.add_unqualified_attribute (n_denominator, a_ratio_metric.denominator_metric_name)
			l_ratio.add_unqualified_attribute (n_denominator_coefficient, a_ratio_metric.denominator_coefficient.out)

			target_element := l_ratio
			element_stack.remove
		end

	process_criterion_common (a_criterion: EB_METRIC_CRITERION; a_element: XM_ELEMENT)
			-- Add attribute "name", "unit" and "negation" for `a_criterion' into `a_element'.
		require
			a_criterion_attached: a_criterion /= Void
			a_element_attached: a_element /= Void
		do
			a_element.add_unqualified_attribute (n_name, a_criterion.name)
			a_element.add_unqualified_attribute (n_unit, a_criterion.scope.name)
			a_element.add_unqualified_attribute (n_negation, a_criterion.is_negation_used.out)
		end

	process_criterion (a_criterion: EB_METRIC_CRITERION)
			-- Process `a_criterion'.
		do
			check
				should_not_arrive_here: False
			end
		end

	process_domain_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION)
			-- Process `a_criterion'.
		local
			l_criterion: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
			l_parent := element_stack.item
			create l_criterion.make (l_parent, n_domain_criterion, namespace)
			l_parent.force_last (l_criterion)
			process_criterion_common (a_criterion, l_criterion)
			element_stack.extend (l_criterion)

			a_criterion.domain.process (Current)

			target_element := l_criterion
			element_stack.remove
		end

	process_caller_callee_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION)
			-- Process `a_criterion'.
		local
			l_criterion: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
				-- Generate element.
			l_parent := element_stack.item
			create l_criterion.make (l_parent, n_caller_criterion, namespace)
			l_parent.force_last (l_criterion)
			process_criterion_common (a_criterion, l_criterion)
			l_criterion.add_unqualified_attribute (n_only_current_version, a_criterion.only_current_version.out)
			element_stack.extend (l_criterion)

			a_criterion.domain.process (Current)

			target_element := l_criterion
			element_stack.remove
		end

	process_supplier_client_criterion (a_criterion: EB_METRIC_SUPPLIER_CLIENT_CRITERION)
			-- Process `a_criterion'.
		local
			l_criterion: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
				-- Generate element.
			l_parent := element_stack.item
			create l_criterion.make (l_parent, n_client_criterion, namespace)
			l_parent.force_last (l_criterion)
			process_criterion_common (a_criterion, l_criterion)
			l_criterion.add_unqualified_attribute (n_indirect, a_criterion.indirect_referenced_class_retrieved.out)
			l_criterion.add_unqualified_attribute (n_normal, a_criterion.normal_referenced_class_retrieved.out)
			l_criterion.add_unqualified_attribute (n_only_syntactical, a_criterion.only_syntactically_referencedd_class_retrieved.out)
			element_stack.extend (l_criterion)

			a_criterion.domain.process (Current)

			target_element := l_criterion
			element_stack.remove
		end

	process_text_criterion (a_criterion: EB_METRIC_TEXT_CRITERION)
			-- Process `a_criterion'.
		local
			l_criterion: XM_ELEMENT
			l_content: XM_CHARACTER_DATA
			l_parent: XM_COMPOSITE
			l_text: XM_ELEMENT
		do
				-- Generate element.
			l_parent := element_stack.item
			create l_criterion.make (l_parent, n_text_criterion, namespace)
			l_parent.force_last (l_criterion)
			process_criterion_common (a_criterion, l_criterion)
			l_criterion.add_unqualified_attribute (n_case_sensitive, a_criterion.is_case_sensitive.out)
			l_criterion.add_unqualified_attribute (n_matching_strategy, matching_strategy_name (a_criterion.matching_strategy))
			element_stack.extend (l_criterion)
			create l_text.make_last (l_criterion, n_text, namespace)
			create l_content.make_last (l_text, a_criterion.text)

			target_element := l_criterion
			element_stack.remove
		end

	process_path_criterion (a_criterion: EB_METRIC_PATH_CRITERION)
			-- Process `a_criterion'.
		local
			l_criterion: XM_ELEMENT
			l_content: XM_CHARACTER_DATA
			l_parent: XM_COMPOSITE
			l_path: XM_ELEMENT
		do
				-- Generate element.
			l_parent := element_stack.item
			create l_criterion.make (l_parent, n_path_criterion, namespace)
			l_parent.force_last (l_criterion)
			process_criterion_common (a_criterion, l_criterion)
			element_stack.extend (l_criterion)

			create l_path.make_last (l_criterion, n_path, namespace)
			create l_content.make_last (l_path, a_criterion.path)

			target_element := l_criterion
			element_stack.remove
		end

	process_normal_criterion (a_criterion: EB_METRIC_NORMAL_CRITERION)
			-- Process `a_criterion'.
		local
			l_criterion: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
				-- Generate element.
			l_parent := element_stack.item
			create l_criterion.make (l_parent, n_normal_criterion, namespace)
			l_parent.force_last (l_criterion)
			process_criterion_common (a_criterion, l_criterion)
			element_stack.extend (l_criterion)

			target_element := l_criterion
			element_stack.remove
		end

	process_value_criterion (a_criterion: EB_METRIC_VALUE_CRITERION)
			-- Process `a_criterion'.
		local
			l_criterion: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
				-- Generate element.
			l_parent := element_stack.item
			create l_criterion.make (l_parent, n_value_criterion, namespace)
			l_parent.force_last (l_criterion)
			process_criterion_common (a_criterion, l_criterion)
			l_criterion.add_unqualified_attribute (n_metric_name, a_criterion.metric_name)
			if a_criterion.should_delayed_domain_from_parent_be_used then
				l_criterion.add_unqualified_attribute (n_use_external_delayed, a_criterion.should_delayed_domain_from_parent_be_used.out)
			end
			element_stack.extend (l_criterion)

			a_criterion.domain.process (Current)
			a_criterion.value_tester.process (Current)

			target_element := l_criterion
			element_stack.remove
		end

	process_external_command_criterion (a_criterion: EB_METRIC_EXTERNAL_COMMAND_CRITERION)
			-- Process `a_criterion'.
		local
			l_criterion: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
				-- Generate element.
			l_parent := element_stack.item
			create l_criterion.make (l_parent, n_command_criterion, namespace)
			l_parent.force_last (l_criterion)
			element_stack.extend (l_criterion)
			process_criterion_common (a_criterion, l_criterion)
			a_criterion.tester.process (Current)
			target_element := l_criterion
			element_stack.remove
		end

	process_nary_criterion (a_criterion: EB_METRIC_NARY_CRITERION)
			-- Process `a_criterion'.
		do
			check
				should_not_arrive_here: False
			end
		end

	process_nary_criterion_common (a_criterion: EB_METRIC_NARY_CRITERION; a_criterion_name: STRING)
			-- Process `a_criterion' whose name is `a_criterion_name'.
		require
			a_criterion_attached: a_criterion /= Void
			a_criterion_name_attached: a_criterion_name /= Void
		local
			l_criterion: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
				-- Generate element.
			l_parent := element_stack.item
			create l_criterion.make (element_stack.item, a_criterion_name, namespace)
			l_parent.force_last (l_criterion)
			process_criterion_common (a_criterion, l_criterion)
			element_stack.extend (l_criterion)

			process_list (a_criterion.operands)

			target_element := l_criterion
			element_stack.remove
		end

	process_and_criterion (a_criterion: EB_METRIC_AND_CRITERION)
			-- Process `a_criterion'.
		do
			process_nary_criterion_common (a_criterion, n_and_criterion)
		end

	process_or_criterion (a_criterion: EB_METRIC_OR_CRITERION)
			-- Process `a_criterion'.
		do
			process_nary_criterion_common (a_criterion, n_or_criterion)
		end

	process_domain (a_domain: EB_METRIC_DOMAIN)
			-- Process `a_domain'.
		local
			l_domain: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
			l_parent := element_stack.item
			create l_domain.make (l_parent, n_domain, namespace)
			l_parent.force_last (l_domain)
			element_stack.extend (l_domain)

			a_domain.do_all (agent safe_process_item ({EB_METRIC_DOMAIN_ITEM}?))

			target_element := l_domain
			element_stack.remove
		end

	process_domain_item (a_item: EB_METRIC_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			check
				should_not_arrive_here: False
			end
		end

	process_domain_item_common (a_type: STRING; a_id: STRING; a_library_target_uuid: STRING)
			-- Add a domain element.
		local
			l_domain_item: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
			l_parent := element_stack.item
			create l_domain_item.make (l_parent, n_domain_item, namespace)
			l_parent.force_last (l_domain_item)
			l_domain_item.add_unqualified_attribute (n_type, a_type)
			l_domain_item.add_unqualified_attribute (n_id, a_id)
			if a_library_target_uuid /= Void then
				l_domain_item.add_unqualified_attribute (n_library_target_uuid, a_library_target_uuid)
			end
		end

	process_application_target_domain_item (a_item: EB_METRIC_TARGET_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			process_domain_item_common (n_target, a_item.text_of_id, a_item.library_target_uuid)
		end

	process_group_domain_item (a_item: EB_METRIC_GROUP_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			process_domain_item_common (n_group, a_item.text_of_id, a_item.library_target_uuid)
		end

	process_folder_domain_item (a_item: EB_METRIC_FOLDER_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			process_domain_item_common (n_folder, a_item.text_of_id, a_item.library_target_uuid)
		end

	process_class_domain_item (a_item: EB_METRIC_CLASS_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			process_domain_item_common (n_class, a_item.text_of_id, a_item.library_target_uuid)
		end

	process_feature_domain_item (a_item: EB_METRIC_FEATURE_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			process_domain_item_common (n_feature, a_item.text_of_id, a_item.library_target_uuid)
		end

	process_delayed_domain_item (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			process_domain_item_common (n_delayed, a_item.text_of_id, a_item.library_target_uuid)
		end

	process_metric_archive_node (a_item: EB_METRIC_ARCHIVE_NODE)
			-- Process `a_item'.
		local
			l_archive: XM_ELEMENT
			l_type_name: STRING
			l_parent: XM_COMPOSITE
		do
			l_parent := element_stack.item
			create l_archive.make (l_parent, n_metric, namespace)
			l_parent.force_last (l_archive)
			inspect
				a_item.metric_type
			when {EB_METRIC_SHARED}.basic_metric_type then
				l_type_name := n_basic
			when {EB_METRIC_SHARED}.linear_metric_type then
				l_type_name := n_linear
			when {EB_METRIC_SHARED}.ratio_metric_type then
				l_type_name := n_ratio
			end
			l_archive.add_unqualified_attribute (n_name, a_item.metric_name)
			l_archive.add_unqualified_attribute (n_type, l_type_name)
			l_archive.add_unqualified_attribute (n_time, a_item.calculated_time.out)
			l_archive.add_unqualified_attribute (n_value,a_item.value.out)
			l_archive.add_unqualified_attribute (n_uuid, a_item.uuid.out)
			l_archive.add_unqualified_attribute (n_filter, a_item.is_result_filtered.out)

			element_stack.extend (l_archive)

			a_item.input_domain.process (Current)
			a_item.value_tester.process (Current)

			target_element := l_archive
			element_stack.remove
		end

	process_value_tester (a_item: EB_METRIC_VALUE_TESTER)
			-- Process `a_item'.
		local
			l_testers_element: XM_ELEMENT
			l_testers: LIST [TUPLE [EB_METRIC_VALUE_RETRIEVER, INTEGER]]
			l_tester: TUPLE [l_retriever: EB_METRIC_VALUE_RETRIEVER; l_operator: INTEGER]
			l_tester_item: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
			if not a_item.criteria.is_empty then
				l_parent := element_stack.item
				create l_testers_element.make (l_parent, n_tester, namespace)
				l_parent.force_last (l_testers_element)
				element_stack.extend (l_testers_element)
				if a_item.is_anded then
					l_testers_element.add_unqualified_attribute (n_relation, query_language_names.ql_cri_and)
				else
					l_testers_element.add_unqualified_attribute (n_relation, query_language_names.ql_cri_or)
				end

				from
					l_testers := a_item.criteria
					l_testers.start
				until
					l_testers.after
				loop
					l_tester := l_testers.item
					create l_tester_item.make_last (l_testers_element, n_tester_item, namespace)
					l_tester_item.add_unqualified_attribute (n_name, operator_table.item (l_tester.l_operator))
					element_stack.extend (l_tester_item)
					l_tester.l_retriever.process (Current)
					element_stack.remove
					l_testers.forth
				end

				target_element := l_testers_element
				element_stack.remove
			end
		end

	process_value_retriever (a_item: EB_METRIC_VALUE_RETRIEVER)
			-- Process `a_item'.
		do
		end

	process_constant_value_retriever (a_item: EB_METRIC_CONSTANT_VALUE_RETRIEVER)
			-- Process `a_item'.
		local
			l_retriever: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
			l_parent := element_stack.item
			create l_retriever.make (l_parent, n_constant_value, namespace)
			l_parent.force_last (l_retriever)
			l_retriever.add_unqualified_attribute (n_value, a_item.value_internal.out)
			target_element := l_retriever
		end

	process_metric_value_retriever (a_item: EB_METRIC_METRIC_VALUE_RETRIEVER)
			-- Process `a_item'.
		local
			l_retriever: XM_ELEMENT
			l_parent: XM_COMPOSITE
		do
			l_parent := element_stack.item
			create l_retriever.make (l_parent, n_metric_value, namespace)
			l_parent.force_last (l_retriever)
			l_retriever.add_unqualified_attribute (n_metric_name, a_item.metric_name)
			if a_item.is_external_delayed_domain_used then
				l_retriever.add_unqualified_attribute (n_use_external_delayed, a_item.is_external_delayed_domain_used.out)
			end
			element_stack.extend (l_retriever)

			a_item.input_domain.process (Current)

			target_element := l_retriever
			element_stack.remove
		end

	process_external_command_tester (a_item: EB_METRIC_EXTERNAL_COMMAND_TESTER)
			-- Process `a_item'.
		local
			l_command: XM_ELEMENT
			l_dir: XM_ELEMENT
			l_input: XM_ELEMENT
			l_output: XM_ELEMENT
			l_error: XM_ELEMENT
			l_command_content: XM_CHARACTER_DATA
			l_dir_content: XM_CHARACTER_DATA
			l_input_content: XM_CHARACTER_DATA
			l_output_content: XM_CHARACTER_DATA
			l_error_content: XM_CHARACTER_DATA
			l_exit_code: XM_ELEMENT
			l_parent: XM_COMPOSITE
			l_namespace: like namespace
		do
			l_namespace := namespace
			l_parent := element_stack.item
				-- Create "command" node.
			create l_command.make (l_parent, n_command, l_namespace)
			create l_command_content.make_last (l_command, a_item.command)
			l_parent.force_last (l_command)

				-- Create "working_directory" node.
			create l_dir.make (l_parent, n_working_directory, l_namespace)
			create l_dir_content.make_last (l_dir, a_item.working_directory)
			l_parent.force_last (l_dir)

				-- Create "input" node.
			create l_input.make (l_parent, n_input, l_namespace)
			l_input.add_unqualified_attribute (n_as_file_name, a_item.is_input_as_file.out)
			create l_input_content.make_last (l_input, a_item.input)
			l_parent.force_last (l_input)

				-- Create "output" node.
			create l_output.make (l_parent, n_output, l_namespace)
			l_output.add_unqualified_attribute (n_enabled, a_item.is_output_enabled.out)
			l_output.add_unqualified_attribute (n_as_file_name, a_item.is_output_as_file.out)
			create l_output_content.make_last (l_output, a_item.output)
			l_parent.force_last (l_output)

				-- Create "error" node.
			create l_error.make (l_parent, n_error, l_namespace)
			l_error.add_unqualified_attribute (n_enabled, a_item.is_error_enabled.out)
			l_error.add_unqualified_attribute (n_as_file_name, a_item.is_error_as_file.out)
			l_error.add_unqualified_attribute (n_redirected_to_output, a_item.is_error_redirected_to_output.out)
			create l_error_content.make_last (l_error, a_item.error)
			l_parent.force_last (l_error)

				-- Create "exit_code" node.
			create l_exit_code.make (l_parent, n_exit_code, l_namespace)
			l_exit_code.add_unqualified_attribute (n_value, a_item.exit_code.out)
			l_exit_code.add_unqualified_attribute (n_enabled, a_item.is_exit_code_enabled.out)
			l_parent.force_last (l_exit_code)
			target_element := l_exit_code
		end

invariant
	element_stack_attached: element_stack /= Void

end
