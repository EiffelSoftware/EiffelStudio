indexing
	description: "The callbacks that react on metric definitation xml parsing"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_LOAD_DEFINITION_CALLBACKS

inherit
	EB_LOAD_METRIC_CALLBACKS
		redefine
			on_start_tag_finish,
			on_end_tag,
			on_content
		end

	EB_METRIC_SHARED

	QL_SHARED_UNIT

create
	make_with_factory

feature{NONE} -- Initialization

	make_with_factory (a_factory: like factory) is
			-- Initialize `factory' with `a_factory'.
		require
			a_factory_attached: a_factory /= Void
		do
			initialize
			factory := a_factory
			create {LINKED_LIST [EB_METRIC_CRITERION]} current_criterion.make
			create current_tag.make
			create current_attributes.make (5)
			create current_content.make (256)
			create metrics.make (64)
			create {LINKED_STACK [EB_METRIC_NARY_CRITERION]} current_criterion_stack.make
			create domain_receiver_stack.make
			create tester_receiver_stack.make
			create value_retriever_stack.make
			set_is_for_whole_file (True)
		ensure
			factory_set: factory = a_factory
			current_criterion_attached: current_criterion /= Void
			current_attributes_attached: current_attributes /= Void
			metrics_attached: metrics /= Void
			current_criterion_stack_attached: current_criterion_stack /= Void
		end

feature -- Access

	metrics: HASH_TABLE [EB_METRIC, STRING]
			-- List of loaded metrics

feature -- Setting

	wipe_out_metrics is
			-- Wipe out `metrics'.
		do
			metrics.wipe_out
		ensure
			metrics_is_empty: metrics.is_empty
		end

feature{NONE} -- Callbacks

	on_start_tag_finish is
			-- End of start tag.
		do
			if not has_error then
				inspect
					current_tag.item
				when t_basic_metric then
					process_basic_metric
					set_first_parsed_node (current_basic_metric)
				when t_linear_metric then
					process_linear_metric
					set_first_parsed_node (current_linear_metric)
				when t_ratio_metric then
					process_ratio_metric
					set_first_parsed_node (current_ratio_metric)
				when t_criterion then
					process_criterion
				when t_normal_criterion then
					process_normal_criterion
					set_first_parsed_node (current_normal_criterion)
				when t_domain_criterion then
					process_domain_criterion
					set_first_parsed_node (current_domain)
				when t_caller_criterion then
					process_caller_callee_criterion
					set_first_parsed_node (current_caller_criterion)
				when t_client_criterion then
					process_supplier_client_criterion
					set_first_parsed_node (current_supplier_client_criterion)
				when t_value_criterion then
					process_value_criterion
					set_first_parsed_node (current_value_criterion)
				when t_text_criterion then
					process_text_criterion
					set_first_parsed_node (current_text_criterion)
				when t_path_criterion then
					process_path_criterion
					set_first_parsed_node (current_path_criterion)
				when t_and_criterion then
					process_and_criterion
					set_first_parsed_node (last_criterion)
				when t_or_criterion then
					process_or_criterion
					set_first_parsed_node (last_criterion)
				when t_variable_metric then
					process_variable_metric
				when t_domain then
					process_domain
					set_first_parsed_node (current_domain)
				when t_domain_item then
					process_domain_item
					set_first_parsed_node (current_domain_item)
				when t_tester then
					process_tester
					set_first_parsed_node (current_tester)
				when t_tester_item then
					process_tester_item
				when t_constant_value then
					process_constant_value
					set_first_parsed_node (current_constant_value_retriever)
				when t_metric_value then
					process_metric_value
					set_first_parsed_node (current_metric_value_retriever)
				when t_description then
					extend_location_section (Void)
				when t_text then
					extend_location_section (Void)
				when t_path then
					extend_location_section (Void)
				else
					set_first_parsed_node (Void)
					extend_location_section (Void)
				end
				current_attributes.clear_all
			end
		ensure then
			location_stored: (not has_error) implies (location_stack.count = old location_stack.count + 1)
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- End tag.
		do
			if not has_error then
				inspect
					current_tag.item
				when t_description then
					process_description_finish
				when t_domain_criterion then
					remove_domain_receiver_from_stack
				when t_caller_criterion then
					remove_domain_receiver_from_stack
				when t_client_criterion then
					remove_domain_receiver_from_stack
				when t_value_criterion then
					remove_receiver_from_stack (
						tester_receiver_stack,
						metric_names.err_value_tester_missing
					)
					remove_domain_receiver_from_stack
				when t_text then
					process_text_finish
				when t_path then
					process_path_finish
				when t_criterion then
					check current_criterion.count = 1 end
					current_basic_metric.set_criteria (current_criterion.first)
				when t_basic_metric then
					process_metric_finish
				when t_linear_metric then
					process_metric_finish
				when t_ratio_metric then
					process_metric_finish
				when t_and_criterion then
					if not current_criterion_stack.is_empty then
						current_criterion_stack.remove
					end
				when t_or_criterion then
					if not current_criterion_stack.is_empty then
						current_criterion_stack.remove
					end
				when t_tester then
					process_tester_finish
				when t_tester_item then
					current_tester.insert_criterion (current_tester_item)
					current_tester_item := Void
					remove_receiver_from_stack (
						value_retriever_stack,
						metric_names.err_value_retriever_missing
					)
				when t_metric_value then
					process_value_retriever_finish
					remove_domain_receiver_from_stack
				when t_domain then
					process_domain_finish
				when t_constant_value then
					process_value_retriever_finish
				else
				end
				create current_content.make_empty
				current_tag.remove
				element_stack.remove
				remove_location_section
			end
		ensure then
			location_removed: (not has_error) implies location_stack.count = (old location_stack.count - 1)
		end

	on_content (a_content: STRING) is
			-- Text content.
		local
			l_current_state: INTEGER
		do
			if not has_error then
				l_current_state := current_tag.item
				if
					l_current_state = t_description or
					l_current_state = t_path or
					l_current_state = t_text
				then
					current_content.append (a_content)
				end
			end
		end

feature{NONE} -- Process

	process_metric_finish is
			-- Process "metric" definition list node.
		local
			l_metrics: like metrics
			l_cur_metric: like current_metric
		do
			if not has_error then
				l_metrics := metrics
				l_cur_metric := current_metric
				if l_metrics.has (l_cur_metric.name) then
					create_last_error (metric_names.err_duplicated_metric_name (l_cur_metric.name))
				else
					l_metrics.put (l_cur_metric, l_cur_metric.name)
				end
			end
		end

	process_basic_metric is
			-- Process "basic_metric" definition list node.		
		local
			l_id: TUPLE [name: STRING; unit: STRING; uuid: UUID]
		do
			if not has_error then
				l_id := current_metric_identifier (basic_metric_type)
				if not has_error then
					current_basic_metric := factory.new_basic_metric (l_id.name, unit_table.item (l_id.unit), l_id.uuid)
					current_metric := current_basic_metric
					create {LINKED_LIST [EB_METRIC_CRITERION]} current_criterion.make
				end
			end
		end

	process_linear_metric is
			-- Process "linear_metric" definition list node.		
		local
			l_id: TUPLE [name: STRING; unit: STRING; uuid: UUID]
		do
			if not has_error then
				l_id := current_metric_identifier (linear_metric_type)
				if not has_error then
					current_linear_metric := factory.new_linear_metric (l_id.name, unit_table.item (l_id.unit), l_id.uuid)
					current_metric := current_linear_metric
				end
			end
		end

	process_ratio_metric is
			-- Process "ratio_metric" definition list node.		
		local
			l_id: TUPLE [name: STRING; unit: STRING; uuid: UUID]
			l_num: STRING
			l_den: STRING
			l_num_uuid_str: STRING
			l_den_uuid_str: STRING
			l_num_uuid: UUID
			l_den_uuid: UUID
			l_num_coefficient_str: STRING
			l_den_coefficient_str: STRING
			l_num_coefficient: DOUBLE
			l_den_coefficient: DOUBLE
		do
			if not has_error then
				l_id := current_metric_identifier (ratio_metric_type)
			end
			if not has_error then
				l_num := current_attributes.item (at_numerator)
				l_den := current_attributes.item (at_denominator)
				l_num_uuid_str := current_attributes.item (at_numerator_uuid)
				l_num_coefficient_str := current_attributes.item (at_numerator_coefficient)
				l_den_coefficient_str := current_attributes.item (at_denominator_coefficient)
				l_den_uuid_str := current_attributes.item (at_denominator_uuid)
				if l_num = Void then
					create_last_error (metric_names.err_numerator_metric_missing)
				end
				if not has_error and then l_den = Void then
					create_last_error (metric_names.err_denominator_metric_missing)
				end
				if not has_error then
					check_uuid_validity (l_num_uuid_str)
					if not has_error then
						l_num_uuid := last_valid_uuid
					end
				end
				if not has_error then
					check_uuid_validity (l_den_uuid_str)
					if not has_error then
						l_den_uuid := last_valid_uuid
					end
				end
				if not has_error then
					l_num_coefficient := coefficient_for_ratio_metric (
						l_num_coefficient_str,
						agent metric_names.err_numerator_coefficient_invalid
					)
				end
				if not has_error then
					l_den_coefficient := coefficient_for_ratio_metric (
						l_den_coefficient_str,
						agent metric_names.err_denominator_coefficient_invalid
					)
				end
				if not has_error then
					current_ratio_metric := factory.new_ratio_metric (
						l_id.name,
						unit_table.item (l_id.unit),
						l_id.uuid, l_num, l_num_uuid,
						l_den, l_den_uuid,
						l_num_coefficient,
						l_den_coefficient
					)
					current_metric := current_ratio_metric
				end
			end
		end

	process_variable_metric is
			-- Process "variable_metric" definition list node.		
		require
			current_linear_metric_attached: current_linear_metric /= Void
		local
			l_coefficient: STRING
			l_metric: STRING
			l_uuid_str: STRING
			l_coefficient_value: DOUBLE
		do
			if not has_error then
				l_coefficient := current_attributes.item (at_coefficient)
				l_metric := current_attributes.item (at_name)
				l_uuid_str := current_attributes.item (at_uuid)
				if l_metric = Void then
					create_last_error (metric_names.err_variable_metric_name_missing)
					extend_location_section (Void)
				else
					extend_location_section (l_metric)
				end
				if not has_error then
					if l_coefficient = Void then
						create_last_error (metric_names.err_coefficient_missing)
					else
						test_non_void_double_attribute (
							l_coefficient,
							agent metric_names.err_coefficient_invalid
						)
						if not has_error then
							l_coefficient_value := last_tested_double
						end
					end
				end
				if not has_error then
					check
						current_linear_metric_attached: current_linear_metric /= Void
					end
					current_linear_metric.coefficient.extend (l_coefficient_value)
					current_linear_metric.variable_metric.extend (l_metric)
				end
				if not has_error then
					check_uuid_validity (l_uuid_str)
					if not has_error then
						current_linear_metric.variable_metric_uuid.extend (last_valid_uuid)
					end
				end
			end
		end

	process_criterion is
			-- Process "criterion" definition list node.		
		do
			if not has_error then
				extend_location_section (Void)
				if not current_criterion.is_empty then
					create_last_error (metric_names.err_too_many_criterion_section)
				end
			end
		end

	process_normal_criterion is
			-- Process "normal_criterion" definition list node.		
		local
			l_id: TUPLE [name: STRING; scope: QL_SCOPE; negation: BOOLEAN]
		do
			if not has_error then
				l_id := current_criterion_identifier
			end
			if not has_error then
				current_normal_criterion := factory.new_normal_criterion (l_id.name, l_id.scope)
				last_criterion := current_normal_criterion
				setup_criterion (current_normal_criterion, l_id.negation)
				register_criterion (current_normal_criterion)
			end
		end

	process_domain_criterion is
			-- Process "domain_criterion" definition list node.
		local
			l_id: TUPLE [name: STRING; scope: QL_SCOPE; negation: BOOLEAN]
		do
			if not has_error then
				l_id := current_criterion_identifier
			end
			if not has_error then
				current_domain_criterion := factory.new_domain_criterion (l_id.name, l_id.scope)
				last_criterion := current_domain_criterion
				setup_criterion (current_domain_criterion, l_id.negation)
				register_criterion (current_domain_criterion)
				domain_receiver_stack.extend ([agent current_domain_criterion.set_domain, False])
			end
		end

	process_text_criterion is
			-- Process "text_criterion" definition list node.		
		local
			l_id: TUPLE [name: STRING; scope: QL_SCOPE; negation: BOOLEAN]
			l_case_sensitive: STRING
			l_regular_expression: STRING
			l_case_sensitive_value: BOOLEAN
			l_regular_expression_value: BOOLEAN
			l_boolean_set: BOOLEAN
		do
			if not has_error then
				l_id := current_criterion_identifier
			end
			if not has_error then
				check current_basic_metric /= Void end

					-- Validate "case_sensitive" attribute.
				l_case_sensitive_value := False
				l_case_sensitive := current_attributes.item (at_case_sensitive)
				l_boolean_set := test_ommitable_boolean_attribute (
					l_case_sensitive,
					agent metric_names.err_case_sensitive_attr_invalid
				)
				if not has_error and then l_boolean_set then
					l_case_sensitive_value := last_tested_boolean
				end

					-- Validate "regular_expression" attribute.				
				if not has_error then
					l_regular_expression_value := True
					l_regular_expression := current_attributes.item (at_regular_expression)
					l_boolean_set := test_ommitable_boolean_attribute (
						l_regular_expression,
						agent metric_names.err_regular_expression_attr_invalid
					)
					if not has_error and then l_boolean_set then
						l_regular_expression_value := last_tested_boolean
					end
				end
				if not has_error then
					current_text_criterion := factory.new_text_criterion (l_id.name, l_id.scope)
					setup_criterion (current_text_criterion, l_id.negation)
					if l_case_sensitive_value then
						current_text_criterion.enable_case_sensitive
					else
						current_text_criterion.disable_case_sensitive
					end
					if l_regular_expression_value then
						current_text_criterion.disable_identical_comparison
					else
						current_text_criterion.enable_identical_comparison
					end
					register_criterion (current_text_criterion)
					last_criterion := current_text_criterion
				end
			end
		end

	process_path_criterion is
			-- Process "path_criterion" definition list node.		
		local
			l_id: TUPLE [name: STRING; scope: QL_SCOPE; negation: BOOLEAN]
		do
			if not has_error then
				l_id := current_criterion_identifier
			end
			if not has_error then
				current_path_criterion := factory.new_path_criterion (l_id.name, l_id.scope)
				last_criterion := current_path_criterion
				setup_criterion (current_path_criterion, l_id.negation)
				register_criterion (current_path_criterion)
			end
		end

	process_caller_callee_criterion is
			-- Process "caller_criterion" definition list node.		
		local
			l_id: TUPLE [name: STRING; scope: QL_SCOPE; negation: BOOLEAN]
			l_only_current_vertion: STRING
			l_only_current_vertion_value: BOOLEAN
			l_boolean_set: BOOLEAN
		do
			if not has_error then
				l_id := current_criterion_identifier
			end
			if not has_error then
				l_only_current_vertion := current_attributes.item (at_only_current_version)
				l_boolean_set := test_ommitable_boolean_attribute (
					l_only_current_vertion,
					agent metric_names.err_only_current_version_attr_invalid
				)
				if not has_error then
					if l_boolean_set then
						l_only_current_vertion_value := last_tested_boolean
					end
					current_caller_criterion := factory.new_caller_callee_criterion (l_id.name, l_id.scope)
					last_criterion := current_caller_criterion
					setup_criterion (current_caller_criterion, l_id.negation)
					if l_only_current_vertion_value then
						current_caller_criterion.enable_only_current_version
					else
						current_caller_criterion.disable_only_current_version
					end
					register_criterion (current_caller_criterion)
					domain_receiver_stack.extend ([agent current_caller_criterion.set_domain, False])
				end
			end
		end

	process_supplier_client_criterion is
			-- Process "client_criterion" definition list node.
		local
			l_id: TUPLE [name: STRING; scope: QL_SCOPE; negation: BOOLEAN]
			l_only_current_vertion: STRING
			l_indirect: STRING
			l_indirect_value: BOOLEAN
			l_normal: STRING
			l_normal_value: BOOLEAN
			l_syntactical: STRING
			l_syntactical_value: BOOLEAN
			l_boolean_set: BOOLEAN
		do
			if not has_error then
				l_id := current_criterion_identifier
			end
			if not has_error then
				l_only_current_vertion := current_attributes.item (at_only_current_version)
				l_indirect := current_attributes.item (at_indirect)
				l_normal := current_attributes.item (at_normal)
				l_syntactical := current_attributes.item (at_only_syntactical)
				l_normal_value := True
				l_boolean_set := test_ommitable_boolean_attribute (
					l_normal,
					agent metric_names.err_normal_referenced_class_attr_invalid
				)
				if not has_error and then l_boolean_set then
					l_normal_value := last_tested_boolean
				end
				if not has_error then
					l_syntactical_value := False
					l_boolean_set := test_ommitable_boolean_attribute (
						l_syntactical,
						agent metric_names.err_only_syntactically_referenced_class_attr_invalid
					)
					if not has_error and then l_boolean_set then
						l_syntactical_value := last_tested_boolean
					end
				end
				if not has_error then
					l_indirect_value := False
					l_boolean_set := test_ommitable_boolean_attribute (
						l_indirect,
						agent metric_names.err_indirect_referenced_class_attr_invalid
					)
					if not has_error and then l_boolean_set then
						l_indirect_value := last_tested_boolean
					end
				end
				if not has_error then
					current_supplier_client_criterion := factory.new_supplier_client_criterion (l_id.name, l_id.scope)
					current_supplier_client_criterion.set_indirect_referenced_class_retrieved (l_indirect_value)
					current_supplier_client_criterion.set_only_syntactically_referencedd_class_retrieved (l_syntactical_value)
					current_supplier_client_criterion.set_normal_referenced_class_retrieved (l_normal_value)
					last_criterion := current_supplier_client_criterion
					setup_criterion (current_supplier_client_criterion, l_id.negation)
					register_criterion (current_supplier_client_criterion)
					domain_receiver_stack.extend ([agent current_supplier_client_criterion.set_domain, False])
				end
			end
		end


	process_value_criterion is
			-- Process value criterion.
		local
			l_id: TUPLE [name: STRING; scope: QL_SCOPE; negation: BOOLEAN]
			l_metric_name: STRING
			l_use_external_delayed: STRING
			l_boolean_set: BOOLEAN
		do
			if not has_error then
				l_id := current_criterion_identifier
			end
			if not has_error then
				l_metric_name := current_attributes.item (at_metric_name)
				if l_metric_name = Void then
					create_last_error (metric_names.err_metric_name_missing)
				end
				if not has_error then
					l_use_external_delayed := current_attributes.item (at_use_external_delayed)
					l_boolean_set := test_ommitable_boolean_attribute (
						l_use_external_delayed,
						agent metric_names.err_use_external_delayed_invalid (?, n_use_external_delayed)
					)
				end
				if not has_error then
					current_value_criterion := factory.new_value_criterion (l_id.name, l_id.scope)
					if l_boolean_set then
						current_value_criterion.set_should_delayed_domain_from_parent_be_used (last_tested_boolean)
					end
					last_criterion := current_value_criterion
					setup_criterion (current_value_criterion, l_id.negation)
					current_value_criterion.set_metric_name (l_metric_name)
					register_criterion (current_value_criterion)
					domain_receiver_stack.extend ([agent current_value_criterion.set_domain, False])
					tester_receiver_stack.extend ([agent current_value_criterion.set_value_tester, False])
				end
			end
		end

	process_and_criterion is
			-- Process "and_criterion".
		local
			l_id: TUPLE [name: STRING; scope: QL_SCOPE; negation: BOOLEAN]
			l_criterion: EB_METRIC_CRITERION
		do
			if not has_error then
				l_id := current_criterion_identifier
			end
			if not has_error then
				l_criterion := factory.new_and_criterion (l_id.name, l_id.scope)
				last_criterion := l_criterion
				setup_criterion (l_criterion, l_id.negation)
				register_criterion (l_criterion)
			end
		end

	process_or_criterion is
			-- Process "or_criterion".
		local
			l_id: TUPLE [name: STRING; scope: QL_SCOPE; negation: BOOLEAN]
			l_criterion: EB_METRIC_CRITERION
		do
			if not has_error then
				l_id := current_criterion_identifier
			end
			if not has_error then
				l_criterion := factory.new_or_criterion (l_id.name, l_id.scope)
				last_criterion := l_criterion
				setup_criterion (l_criterion, l_id.negation)
				register_criterion (l_criterion)
			end
		end

	process_text_finish is
			-- Process "text" definition list node.
		do
			if not has_error then
				if current_tag.item /= t_text then
					create_last_error (metric_names.err_invalid_tag)
				else
					current_text_criterion.set_text (current_content)
				end
			end
		end

	process_path_finish is
			-- Process "path" definition list node.		
		do
			if not has_error then
				if current_tag.item /= t_path then
					create_last_error (metric_names.err_invalid_tag)
				else
					current_path_criterion.set_path (current_content)
				end
			end
		end

	process_description_finish is
			-- Process "description" definition list node.		
		do
			if not has_error then
				if current_metric /= Void then
					current_metric.set_description (current_content.twin)
				else
					create_last_error (metric_names.err_invalid_description_tag)
				end
			end
		end

--	process_tester is
--			-- Process tester.
--		local
--			l_relation_str: STRING
--			l_item: TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_TESTER]]; is_called: BOOLEAN]
--		do
--			if not has_error then
--				extend_location_section (Void)
--				check not tester_receiver_stack.is_empty end
--				l_item := tester_receiver_stack.item
--				if l_item.is_called then
--					create_last_error (metric_names.err_too_many_tester)
--				else
--					l_relation_str := current_attributes.item (at_relation)
--					if l_relation_str = Void then
--						create_last_error (metric_names.err_tester_relation_missing)
--					else
--						if l_relation_str.is_case_insensitive_equal (query_language_names.ql_cri_and) then
--							current_tester.enable_anded
--						elseif l_relation_str.is_case_insensitive_equal (query_language_names.ql_cri_or) then
--							current_tester.enable_ored
--						else
--							create_last_error (metric_names.err_tester_relation_invalid (l_relation_str))
--						end
--					end
--				end
--			end
--		end

--	process_tester_item is
--			-- Process tester item.
--		require
--			current_tester_attached: current_tester /= Void
--		local
--			l_operator_name: STRING
--			l_operator_name_set: like operator_name_set
--			l_operator_id: INTEGER
--		do
--			if not has_error then
--				l_operator_name := current_attributes.item (at_name)
--				if l_operator_name = Void then
--					create_last_error (metric_names.err_operator_missing)
--					extend_location_section (Void)
--				else
--					extend_location_section (l_operator_name)
--					l_operator_name_set := operator_name_set
--					if not l_operator_name_set.has (l_operator_name) then
--						create_last_error (metric_names.err_operator_invalid (l_operator_name))
--					else
--						l_operator_id := operator_name_table.item (l_operator_name)
--					end
--					if not has_error then
--						current_tester_item := [Void, l_operator_id]
--						value_retriever_stack.extend ([agent set_current_tester_item, False])
--					end
--				end
--			end
--		end

--	process_constant_value is
--			-- Process "constant_value" node.
--		local
--			l_base_value: STRING
--			l_item: TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_RETRIEVER]]; is_called: BOOLEAN]
--		do
--			if not has_error then
--				extend_location_section (Void)
--				check not value_retriever_stack.is_empty end
--				l_item := value_retriever_stack.item
--				if l_item.is_called then
--						-- We already processed a "constant_value" node or a "metric_value" node,
--						-- only one should presents in a "tester_item" node, so report an error here.
--					create_last_error (metric_names.err_too_many_value_retriever)
--				else
--					l_base_value := current_attributes.item (at_value)
--					if l_base_value /= Void then
--						test_non_void_double_attribute (
--							l_base_value,
--							agent metric_names.err_base_value_invalid
--						)
--					else
--						create_last_error (metric_names.err_base_value_missing)
--					end
--					if not has_error then
--						create current_constant_value_retriever.make (last_tested_double)
--						current_value_retriever := current_constant_value_retriever
--						current_tester_item.put (current_constant_value_retriever, 1)
--					end
--				end
--			end
--		end

--	process_metric_value is
--			-- Process "metric_value" node.
--		local
--			l_metric_name: STRING
--			l_item: TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_RETRIEVER]]; is_called: BOOLEAN]
--			l_use_external: STRING
--			l_boolean_set: BOOLEAN
--		do
--			if not has_error then
--				extend_location_section (Void)
--				check not value_retriever_stack.is_empty end
--				l_item := value_retriever_stack.item
--				if l_item.is_called then
--						-- We already processed a "constant_value" node or a "metric_value" node,
--						-- only one should presents in a "tester_item" node, so report an error here.
--					create_last_error (metric_names.err_too_many_value_retriever)
--				else
--					l_metric_name := current_attributes.item (at_metric_name)
--					if l_metric_name = Void then
--						create_last_error (metric_names.err_metric_name_missing)
--					end
--					if not has_error then
--						l_use_external := current_attributes.item (at_use_external_delayed)
--						l_boolean_set := test_ommitable_boolean_attribute (
--							l_use_external,
--							agent metric_names.err_use_external_delayed_invalid (?, n_use_external_delayed)
--						)
--					end
--					if not has_error then
--						create current_metric_value_retriever
--						current_metric_value_retriever.set_metric_name (l_metric_name)
--						if l_boolean_set then
--							current_metric_value_retriever.set_is_external_delayed_domain_used (last_tested_boolean)
--						end
--						current_value_retriever := current_metric_value_retriever
--						current_tester_item.put (current_metric_value_retriever, 1)
--						domain_receiver_stack.extend ([agent current_metric_value_retriever.set_input_domain, False])
--					end
--				end
--			end
--		end

--	process_tester_finish is
--			-- Process when a tester node has been parsed.
--		local
--			l_item: TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_TESTER]]; is_called: BOOLEAN]
--		do
--			check not tester_receiver_stack.is_empty end
--			l_item := tester_receiver_stack.item
--			check l_item.setter /= Void end
--			l_item.setter.call ([current_tester])
--			l_item.is_called := True
--		end

--	process_value_retriever_finish is
--			-- Process when a value retriever has been parsed.
--		local
--			l_item: TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_RETRIEVER]]; is_called: BOOLEAN]
--		do
--			check not value_retriever_stack.is_empty end
--			l_item := value_retriever_stack.item
--			check l_item.setter /= Void end
--			l_item.setter.call ([current_value_retriever])
--			l_item.is_called := True
--		end

feature{NONE} -- Implementation

	current_content: STRING
			-- Content of last node

	current_metric: EB_METRIC
			-- Current metric

	current_basic_metric: EB_METRIC_BASIC
			-- Current basic metric

	current_linear_metric: EB_METRIC_LINEAR
			-- Current linear metric

	current_ratio_metric: EB_METRIC_RATIO
			-- Current ratio metric

	current_normal_criterion: EB_METRIC_NORMAL_CRITERION
			-- Current normal criterion

	current_text_criterion: EB_METRIC_TEXT_CRITERION
			-- Current name criterion

	current_path_criterion: EB_METRIC_PATH_CRITERION
			-- Current path criterion

	current_domain_criterion: EB_METRIC_DOMAIN_CRITERION
			-- Current domain criterion

	current_caller_criterion: EB_METRIC_CALLER_CALLEE_CRITERION
			-- Current caller/callee criterion

	current_supplier_client_criterion: EB_METRIC_SUPPLIER_CLIENT_CRITERION
			-- Current supplier/client criterion

	current_value_criterion: EB_METRIC_VALUE_CRITERION
			-- Current value criterion

	current_criterion: LIST [EB_METRIC_CRITERION]
			-- Current criterion list

	current_criterion_stack: LINKED_STACK [EB_METRIC_NARY_CRITERION]
			-- Current stack for "and" and "or" criterion

	last_criterion: EB_METRIC_CRITERION
			-- Last processed criterion

--	tester_receiver_stack: LINKED_STACK [TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_TESTER]]; is_called: BOOLEAN]]
--			-- Tester receiver stack
--			-- `setter' is the setter procedure to set last parsed tester.
--			-- `is_called' is a flag to indicate if a tester exists. It's used to detect if a needed tester is missing.

--	value_retriever_stack: LINKED_STACK [TUPLE [setter: PROCEDURE [ANY, TUPLE [EB_METRIC_VALUE_RETRIEVER]]; is_called: BOOLEAN]]
--			-- Value retriever stack
--			-- `setter' is the setter procedure to set last parsed value retriever.
--			-- `is_called' is a flag to indicate if a value retirever exists. It's used to detect if a needed value retriever is missing.	

feature{NONE} -- Implementation/XML structure

	state_transitions_tag: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER] is
			-- Mapping of possible tag state transitions from `current_tag' with the tag name to the new state.
		local
			l_trans: HASH_TABLE [INTEGER, STRING]
		once
			create Result.make (14)

				-- => metrics
			create l_trans.make (1)
			l_trans.force (t_metric, n_metric)
			Result.force (l_trans, t_none)

				-- metric
				-- => basic_metric
				-- => linear_metric
				-- => ratio_metric		
			create l_trans.make (4)
			l_trans.force (t_basic_metric, n_basic_metric)
			l_trans.force (t_linear_metric, n_linear_metric)
			l_trans.force (t_ratio_metric, n_ratio_metric)
			Result.force (l_trans, t_metric)

				-- basic_metric
				-- => description
				-- => criteria
			create l_trans.make (2)
			l_trans.force (t_description, n_description)
			l_trans.force (t_criterion, n_criterion)
			Result.force (l_trans, t_basic_metric)

				-- linear_metric
				-- => description
				-- => variable_metric	
			create l_trans.make (2)
			l_trans.force (t_description, n_description)
			l_trans.force (t_variable_metric, n_variable_metric)
			Result.force (l_trans, t_linear_metric)

				-- ratio_metric
				-- => description
			create l_trans.make (1)
			l_trans.force (t_description, n_description)
			Result.force (l_trans, t_ratio_metric)

				-- criterion
				-- => normal_criterion
				-- => domain_criterion
				-- => text_criterion
				-- => path_criterion
				-- => caller_criterion
				-- => client_criterion
				-- => value_criterion
				-- => and_criterion
				-- => or_criterion
			create l_trans.make (8)
			l_trans.force (t_normal_criterion, n_normal_criterion)
			l_trans.force (t_domain_criterion, n_domain_criterion)
			l_trans.force (t_text_criterion, n_text_criterion)
			l_trans.force (t_path_criterion, n_path_criterion)
			l_trans.force (t_caller_criterion, n_caller_criterion)
			l_trans.force (t_client_criterion, n_client_criterion)
			l_trans.force (t_value_criterion, n_value_criterion)
			l_trans.force (t_and_criterion, n_and_criterion)
			l_trans.force (t_or_criterion, n_or_criterion)
			Result.force (l_trans, t_criterion)

				-- domain_criterion
				-- => domain
			create l_trans.make (1)
			l_trans.force (t_domain, n_domain)
			Result.force (l_trans, t_domain_criterion)

				-- text_criterion
				-- => text
			create l_trans.make (1)
			l_trans.force (t_text, n_text)
			Result.force (l_trans, t_text_criterion)

				-- path_criterion
				-- => path
			create l_trans.make (1)
			l_trans.force (t_path, n_path)
			Result.force (l_trans, t_path_criterion)

				-- caller_criterion
				-- => domain
			create l_trans.make (1)
			l_trans.force (t_domain, n_domain)
			Result.force (l_trans, t_caller_criterion)

				-- client_criterion
			create l_trans.make (1)
			l_trans.force (t_domain, n_domain)
			Result.force (l_trans, t_client_criterion)

				-- value_criterion
				-- => domain
				-- => tester
			create l_trans.make (2)
			l_trans.force (t_domain, n_domain)
			l_trans.force (t_tester, n_tester)
			Result.force (l_trans, t_value_criterion)

				-- and_criterion
				-- => normal_criterion
				-- => domain_criterion
				-- => text_criterion
				-- => path_criterion
				-- => caller_criterion
				-- => client_criterion
				-- => value_criterion
				-- => and_criterion
				-- => or_criterion
			create l_trans.make (7)
			l_trans.force (t_normal_criterion, n_normal_criterion)
			l_trans.force (t_domain_criterion, n_domain_criterion)
			l_trans.force (t_text_criterion, n_text_criterion)
			l_trans.force (t_path_criterion, n_path_criterion)
			l_trans.force (t_caller_criterion, n_caller_criterion)
			l_trans.force (t_client_criterion, n_client_criterion)
			l_trans.force (t_value_criterion, n_value_criterion)
			l_trans.force (t_and_criterion, n_and_criterion)
			l_trans.force (t_or_criterion, n_or_criterion)
			Result.force (l_trans, t_and_criterion)

				-- or_criterion
				-- => normal_criterion
				-- => domain_criterion
				-- => text_criterion
				-- => path_criterion
				-- => caller_criterion
				-- => client_criterion
				-- => value_criterion
				-- => and_criterion
				-- => or_criterion
			create l_trans.make (7)
			l_trans.force (t_normal_criterion, n_normal_criterion)
			l_trans.force (t_domain_criterion, n_domain_criterion)
			l_trans.force (t_text_criterion, n_text_criterion)
			l_trans.force (t_path_criterion, n_path_criterion)
			l_trans.force (t_caller_criterion, n_caller_criterion)
			l_trans.force (t_client_criterion, n_client_criterion)
			l_trans.force (t_value_criterion, n_value_criterion)
			l_trans.force (t_and_criterion, n_and_criterion)
			l_trans.force (t_or_criterion, n_or_criterion)
			Result.force (l_trans, t_or_criterion)

				-- domain
				-- => domain_item
			create l_trans.make (1)
			l_trans.force (t_domain_item, n_domain_item)
			Result.force (l_trans, t_domain)

				-- tester
				-- => tester_item
			create l_trans.make (1)
			l_trans.force (t_tester_item, n_tester_item)
			Result.force (l_trans, t_tester)

				-- tester_item
				-- => constant_value
				-- => metric_value
			create l_trans.make (2)
			l_trans.force (t_constant_value, n_constant_value)
			l_trans.force (t_metric_value, n_metric_value)
			Result.force (l_trans, t_tester_item)

				-- metric_value
				-- => domain
			create l_trans.make (1)
			l_trans.force (t_domain, n_domain)
			Result.force (l_trans, t_metric_value)
		end

	tag_attributes: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER] is
			-- Mapping of possible attributes of tags.
		local
			l_attr: HASH_TABLE [INTEGER, STRING]
		once
			create Result.make (25)

				-- basic_metric
				-- * name
				-- * unit
				-- * uuid				
			create l_attr.make (3)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_uuid, n_uuid)
			Result.force (l_attr, t_basic_metric)

				-- linear_metric
				-- * name
				-- * unit
				-- * uuid
			create l_attr.make (3)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_uuid, n_uuid)
			Result.force (l_attr, t_linear_metric)

				-- ratio_metric
				-- * name
				-- * unit
				-- * uuid				
				-- * numerator
				-- * numerator uuid
				-- * denominator
				-- * denominator uuid
				-- * numerator coefficient
				-- * denominator coefficient
			create l_attr.make (9)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_uuid, n_uuid)
			l_attr.force (at_numerator, n_numerator)
			l_attr.force (at_numerator_uuid, n_numerator_uuid)
			l_attr.force (at_denominator, n_denominator)
			l_attr.force (at_denominator_uuid, n_denominator_uuid)
			l_attr.force (at_numerator_coefficient, n_numerator_coefficient)
			l_attr.force (at_denominator_coefficient, n_denominator_coefficient)
			Result.force (l_attr, t_ratio_metric)

				-- normal_criterion
				-- * name
				-- * unit
				-- * negation
			create l_attr.make (4)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_negation, n_negation)
			Result.force (l_attr, t_normal_criterion)

				-- text_criterion
				-- * name
				-- * unit
				-- * negation
				-- * case_sensitive
				-- * regular_expression
			create l_attr.make (6)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_negation, n_negation)
			l_attr.force (at_case_sensitive, n_case_sensitive)
			l_attr.force (at_regular_expression, n_regular_expression)
			Result.force (l_attr, t_text_criterion)

				-- path_criterion
				-- * name
				-- * unit
				-- * negation
			create l_attr.make (4)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_negation, n_negation)
			Result.force (l_attr, t_path_criterion)

				-- domain_criterion
				-- * name
				-- * unit
				-- * negation
			create l_attr.make (4)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_negation, n_negation)
			Result.force (l_attr, t_domain_criterion)

				-- caller_criterion
				-- * name
				-- * unit
				-- * negation
				-- * only_current_version
			create l_attr.make (5)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_negation, n_negation)
			l_attr.force (at_only_current_version, n_only_current_version)
			Result.force (l_attr, t_caller_criterion)

				-- client_criterion
				-- * name
				-- * unit
				-- * negation
			create l_attr.make (6)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_negation, n_negation)
			l_attr.force (at_indirect, n_indirect)
			l_attr.force (at_normal, n_normal)
			l_attr.force (at_only_syntactical, n_only_syntactical)
			Result.force (l_attr, t_client_criterion)

				-- value_criterion
				-- * name
				-- * unit
				-- * negation
				-- * metric_name
				-- * use_external_delayed
			create l_attr.make (4)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_negation, n_negation)
			l_attr.force (at_metric_name, n_metric_name)
			l_attr.force (at_use_external_delayed, n_use_external_delayed)
			Result.force (l_attr, t_value_criterion)

				-- and_criterion
				-- * name
				-- * unit
				-- * negation
			create l_attr.make (4)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_negation, n_negation)
			Result.force (l_attr, t_and_criterion)

				-- or_criterion
				-- * name
				-- * unit
				-- * negation
			create l_attr.make (4)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_negation, n_negation)
			Result.force (l_attr, t_or_criterion)

				-- domain_item
				-- * id
				-- * type
				-- * library_target_uuid
			create l_attr.make (3)
			l_attr.force (at_id, n_id)
			l_attr.force (at_type, n_type)
			l_attr.force (at_library_target_uuid, n_library_target_uuid)
			Result.force (l_attr, t_domain_item)

				-- variable_metric
			create l_attr.make (2)
			l_attr.force (at_coefficient, n_coefficient)
			l_attr.force (at_name, n_name)
			l_attr.force (at_uuid, n_uuid)
			Result.force (l_attr, t_variable_metric)

				-- Tester
			create l_attr.make (1)
			l_attr.force (at_relation, n_relation)
			Result.force (l_attr, t_tester)

				-- tester_item
				-- * name
				-- * value
			create l_attr.make (2)
			l_attr.force (at_name, n_name)
			l_attr.force (at_value, n_value)
			Result.force (l_attr, t_tester_item)

				-- constant_value
				-- * value
			create l_attr.make (1)
			l_attr.force (at_value, n_value)
			Result.force (l_attr, t_constant_value)

				-- metric_value
				-- * name
				-- * use_external_delayed
			create l_attr.make (2)
			l_attr.force (at_metric_name, n_metric_name)
			l_attr.force (at_use_external_delayed, n_use_external_delayed)
			Result.force (l_attr, t_metric_value)
		end

	element_index_table: HASH_TABLE [INTEGER, STRING] is
			-- Table of indexes of supported elements indexed by element name.
		once
			create Result.make (20)
			Result.put (t_description, n_description)
			Result.put (t_metric, n_metric)
			Result.put (t_basic_metric, n_basic_metric)
			Result.put (t_linear_metric, n_linear_metric)
			Result.put (t_ratio_metric, n_ratio_metric)
			Result.put (t_variable_metric, n_variable_metric)
			Result.put (t_criterion, n_criterion)
			Result.put (t_normal_criterion, n_normal_criterion)
			Result.put (t_domain_criterion, n_domain_criterion)
			Result.put (t_text_criterion, n_text_criterion)
			Result.put (t_path_criterion, n_path_criterion)
			Result.put (t_caller_criterion, n_caller_criterion)
			Result.put (t_client_criterion, n_client_criterion)
			Result.put (t_and_criterion, n_and_criterion)
			Result.put (t_or_criterion, n_or_criterion)
			Result.put (t_value_criterion, n_value_criterion)
			Result.put (t_text, n_text)
			Result.put (t_path, n_path)
			Result.put (t_domain, n_domain)
			Result.put (t_domain_item, n_domain_item)
			Result.put (t_metric_archive, n_metric_archive)
			Result.put (t_tester, n_tester)
			Result.put (t_tester_item, n_tester_item)
			Result.put (t_constant_value, n_constant_value)
			Result.put (t_metric_value, n_metric_value)
		end

feature{NONE} -- Implementation

	current_metric_identifier (a_metric_type_id: INTEGER) : TUPLE [name: STRING; unit: STRING; uuid: UUID] is
			-- Metric identifier of `current_metric'
		require
			a_metric_type_id_valid: is_metric_type_valid (a_metric_type_id)
		local
			l_name: STRING
			l_unit: STRING
			l_uuid_str: STRING
		do
			l_name := current_attributes.item (at_name)
			l_unit := current_attributes.item (at_unit)
			l_uuid_str := current_attributes.item (at_uuid)
			if not has_error then
				if l_name = Void then
					extend_location_section (Void)
					create_last_error (metric_names.err_metric_name_missing_in_metric_definition)
				else
					extend_location_section (l_name)
					check_metric_name (l_name)
				end
			end
			if not has_error then
				if l_unit = Void then
					create_last_error (metric_names.err_unit_name_missing)
				elseif not is_unit_valid (l_unit.as_lower) then
					create_last_error (metric_names.err_unit_name_invalid (l_unit))
				end
			end
			if not has_error then
				check_uuid_validity (l_uuid_str)
				if not has_error then
					Result := [l_name, l_unit, last_valid_uuid]
				end
			end
		end

	current_criterion_identifier: TUPLE [name: STRING; scope: QL_SCOPE; is_negation_used: BOOLEAN] is
			-- Criterion identifier
			-- `name' is name of the criterion, `scope' is its scope.
			-- `is_negation_used' decides whether or not a "not" operation is applied when the criterion is evaluated.
		local
			l_name: STRING
			l_scope: STRING
			l_negation: STRING
			l_ql_scope: QL_SCOPE
			l_negation_used: BOOLEAN
		do
			check current_metric /= Void end
			l_name := current_attributes.item (at_name)
			l_scope := current_attributes.item (at_unit)
			l_negation := current_attributes.item (at_negation)
			if l_name = Void then
				extend_location_section (Void)
				create_last_error (metric_names.err_criterion_name_missing)
			end
			if not has_error then
				extend_location_section (l_name)
				if l_scope = Void then
					create_last_error (metric_names.err_unit_name_missing)
				else
					l_ql_scope := scope_table.item (l_scope)
					if l_ql_scope = Void then
						create_last_error (metric_names.err_unit_name_invalid (l_scope))
					end
				end
				if not has_error then
					if current_metric.unit.scope /= l_ql_scope then
						create_last_error (metric_names.err_basic_metric_unit_not_correct (l_ql_scope.name, current_metric.unit.name))
					end
				end
			end
			if not has_error then
				if l_negation /= Void then
					test_non_void_boolean_attribute (
						l_negation,
						metric_names.err_negation_attr_invalid (l_negation)
					)
					if not has_error then
						l_negation_used := last_tested_boolean
					end
				end
			end
			if not has_error then
				Result := [l_name, l_ql_scope, l_negation_used]
			end
		end

	setup_criterion (a_criterion: EB_METRIC_CRITERION; a_negation: BOOLEAN) is
			-- Setup `a_criterion' with `a_negation'.
		require
			a_criterion_attached: a_criterion /= Void
		do
			a_criterion.set_is_negation_used (a_negation)
		end

	register_criterion (a_criterion: EB_METRIC_CRITERION) is
			-- Register `a_criterion' into `current_criterion_stack' or `current_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		local
			l_parent: EB_METRIC_NARY_CRITERION
			l_nary_cri: EB_METRIC_NARY_CRITERION
		do
			if not current_criterion_stack.is_empty then
				l_parent := current_criterion_stack.item
				l_parent.operands.extend (a_criterion)
			else
				if not current_criterion.is_empty then
					create_last_error (metric_names.err_too_many_criteria)
				else
					current_criterion.extend (a_criterion)
				end
			end
			l_nary_cri ?= a_criterion
			if l_nary_cri /= Void then
				current_criterion_stack.extend (l_nary_cri)
			end
		end

	check_metric_name (a_name: STRING) is
			-- Check if `a_name' is a valid metric name.
		do
			if a_name = Void or else a_name.is_empty then
				create_last_error (metric_names.err_metric_name_empty)
			else
				if not metric_manager.is_metric_name_valid (a_name) then
					create_last_error (metric_names.err_metric_name_invalid (a_name))
				end
			end
		end

	coefficient_for_ratio_metric (a_value: STRING; a_error_message_agent: FUNCTION [ANY, TUPLE [STRING_GENERAL], STRING_GENERAL]): DOUBLE is
			-- Coefficient from `a_value' for ratio metric.
			-- If `a_value' doesn't represent a valid double, file an error with error message retrieved by `a_error_message_agent'.
		require
			a_error_message_agent_attached: a_error_message_agent /= Void
		do
			if a_value /= Void then
				test_non_void_double_attribute (a_value, a_error_message_agent)
				if not has_error then
					Result := last_tested_double
				end
			else
				Result := 1
			end
		end

	is_unit_valid (a_unit: STRING): BOOLEAN is
			-- Is `a_unit' valid?
			-- `a_unit' should be left and right trimmed and should be in lowercase.
		require
			a_unit_attached: a_unit /= Void
			not_a_unit_is_empty: not a_unit.is_empty
		do
			Result := unit_table.has (a_unit)
		end

invariant
	current_criterion_attached: current_criterion /= Void
	current_attributes_attached: current_attributes /= Void
	metrics_attached: metrics /= Void
	domain_receiver_stack_attached: domain_receiver_stack /= Void

indexing
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

