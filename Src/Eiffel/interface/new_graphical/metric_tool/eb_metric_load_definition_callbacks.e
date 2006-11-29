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

	EB_METRIC_UTILITY

	EB_METRIC_SHARED

create
	make_with_factory

feature{NONE} -- Initialization

	make_with_factory (a_factory: like factory) is
			-- Initialize `factory' with `a_factory'.
		require
			a_factory_attached: a_factory /= Void
		do
			factory := a_factory
			create {LINKED_LIST [EB_METRIC_CRITERION]} current_criterion.make
			create current_tag.make
			create current_attributes.make (5)
			create current_content.make (256)
			create current_domain.make
			create metrics.make (64)
			create {LINKED_STACK [EB_METRIC_NARY_CRITERION]} current_criterion_stack.make
		ensure
			factory_set: factory = a_factory
			current_criterion_attached: current_criterion /= Void
			current_attributes_attached: current_attributes /= Void
			current_domain_attached: current_domain /= Void
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
				when t_linear_metric then
					process_linear_metric
				when t_ratio_metric then
					process_ratio_metric
				when t_criterion then
					process_criterion
				when t_normal_criterion then
					process_normal_criterion
				when t_domain_criterion then
					process_domain_criterion
				when t_caller_criterion then
					process_caller_criterion
				when t_text_criterion then
					process_text_criterion
				when t_path_criterion then
					process_path_criterion
				when t_and_criterion then
					process_and_criterion
				when t_or_criterion then
					process_or_criterion
				when t_variable_metric then
					process_variable_metric
				when t_domain then
					process_domain
				when t_domain_item then
					process_domain_item
				else
				end
				current_attributes.clear_all
			end
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- End tag.
		do
			if not has_error then
				inspect
					current_tag.item
				when t_description then
					process_description
				when t_domain_criterion then
					current_domain_criterion.set_domain (current_domain)
				when t_caller_criterion then
					current_caller_criterion.set_domain (current_domain)
				when t_text then
					process_text
				when t_path then
					process_path
				when t_criterion then
					check current_criterion.count = 1 end
					current_basic_metric.set_criteria (current_criterion.first)
				when t_basic_metric then
					process_metric
				when t_linear_metric then
					process_linear_metric_end
				when t_ratio_metric then
					process_metric
				when t_scope_ratio_metric then
					process_metric
				when t_and_criterion then
					if not current_criterion_stack.is_empty then
						current_criterion_stack.remove
					end
				when t_or_criterion then
					if not current_criterion_stack.is_empty then
						current_criterion_stack.remove
					end
				else
				end
				create current_content.make_empty
				current_tag.remove
			end
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

	process_metric is
			-- Process "metric" definition list node.
		local
			l_metrics: like metrics
			l_cur_metric: like current_metric
		do
			l_metrics := metrics
			l_cur_metric := current_metric
			if l_metrics.has (l_cur_metric.name) then
				set_parse_error_message (metric_names.err_duplicated_metric_name (l_cur_metric.name), Void)
			else
				l_metrics.put (l_cur_metric, l_cur_metric.name)
			end
		end

	process_basic_metric is
			-- Process "basic_metric" definition list node.		
		local
			l_id: TUPLE [name: STRING; unit: STRING; uuid: UUID]
		do
			l_id := current_metric_identifier (basic_metric_type)
			if not has_error then
				current_basic_metric := factory.new_basic_metric (l_id.name, unit_table.item (l_id.unit), l_id.uuid)
				current_metric := current_basic_metric
				create {LINKED_LIST [EB_METRIC_CRITERION]} current_criterion.make
			end
		end

	process_linear_metric is
			-- Process "linear_metric" definition list node.		
		local
			l_id: TUPLE [name: STRING; unit: STRING; uuid: UUID]
		do
			l_id := current_metric_identifier (linear_metric_type)
			if not has_error then
				current_linear_metric := factory.new_linear_metric (l_id.name, unit_table.item (l_id.unit), l_id.uuid)
				current_metric := current_linear_metric
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
		do
			l_id := current_metric_identifier (ratio_metric_type)
			if not has_error then
				l_num := current_attributes.item (at_numerator)
				l_den := current_attributes.item (at_denominator)
				l_num_uuid_str := current_attributes.item (at_numerator_uuid)
				l_den_uuid_str := current_attributes.item (at_denominator_uuid)
				if l_num = Void then
					set_parse_error_message (
						metric_names.err_numerator_metric_missing,
						metric_names.ratio_metric_location_section (l_id.name)
					)
				end
				if not has_error and then l_den = Void then
					set_parse_error_message (
						metric_names.err_denominator_metric_missing,
						metric_names.ratio_metric_location_section (l_id.name)
					)
				end
				if not has_error then
					check_uuid_vadility (
						l_num_uuid_str,
						metric_names.numerator_location (l_id.name, l_num)
					)
					if not has_error then
						l_num_uuid := last_valid_uuid
					end
				end
				if not has_error then
					check_uuid_vadility (
						l_den_uuid_str,
						metric_names.denominator_location (l_id.name, l_den)
					)
					if not has_error then
						l_den_uuid := last_valid_uuid
					end
				end
				if not has_error then
					current_ratio_metric := factory.new_ratio_metric (l_id.name, unit_table.item (l_id.unit), l_id.uuid, l_num, l_num_uuid, l_den, l_den_uuid)
					current_metric := current_ratio_metric
				end
			end
		end

	process_linear_metric_end is
			-- Process when linear metric node ends
		do
			if current_linear_metric.variable_metric.is_empty then
				set_parse_error_message (
					metric_names.err_variable_metric_missing,
					metric_names.linear_metric_location_section (current_linear_metric.name)
				)
			else
				process_metric
			end
		end

	process_variable_metric is
			-- Process "variable_metric" definition list node.		
		local
			l_coefficient: STRING
			l_metric: STRING
			l_uuid_str: STRING
		do
			check current_linear_metric /= Void end
			l_coefficient := current_attributes.item (at_coefficient)
			l_metric := current_attributes.item (at_name)
			l_uuid_str := current_attributes.item (at_uuid)
			if l_metric = Void then
				set_parse_error_message (
					metric_names.err_variable_metric_name_missing,
					metric_names.linear_metric_location_section (current_linear_metric.name)
				)
			end
			if not has_error then
				if l_coefficient = Void then
					set_parse_error_message (
						metric_names.err_coefficient_missing,
						metric_names.variable_metric_location (current_linear_metric.name, l_metric)
					)
				elseif not l_coefficient.is_real then
					set_parse_error_message (
						metric_names.err_coefficient_invalid (l_coefficient),
						metric_names.variable_metric_location (current_linear_metric.name, l_metric)
					)
				end
			end
			if not has_error then
				check
					current_linear_metric_attached: current_linear_metric /= Void
				end
				current_linear_metric.coefficient.extend (l_coefficient.to_double)
				current_linear_metric.variable_metric.extend (l_metric)
			end
			if not has_error then
				check_uuid_vadility (
					l_uuid_str,
					metric_names.variable_metric_location (current_linear_metric.name, l_metric)
				)
				if not has_error then
					current_linear_metric.variable_metric_uuid.extend (last_valid_uuid)
				end
			end
		end

	process_criterion is
			-- Process "criterion" definition list node.		
		do
			if not current_criterion.is_empty then
				set_parse_error_message (
					metric_names.err_too_many_criterion_section,
					metric_names.basic_metric_location_section (current_metric.name)
				)
			end
		end

	process_normal_criterion is
			-- Process "normal_criterion" definition list node.		
		local
			l_id: TUPLE [name: STRING; scope: QL_SCOPE; negation: BOOLEAN]
		do
			l_id := current_criterion_identifier
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
			l_id := current_criterion_identifier
			if not has_error then
				current_domain_criterion := factory.new_domain_criterion (l_id.name, l_id.scope)
				last_criterion := current_domain_criterion
				setup_criterion (current_domain_criterion, l_id.negation)
				register_criterion (current_domain_criterion)
				create current_domain.make
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
		do
			l_id := current_criterion_identifier
			if not has_error then
				check current_basic_metric /= Void end
				l_case_sensitive := internal_name (current_attributes.item (at_case_sensitive))
				l_regular_expression := internal_name (current_attributes.item (at_regular_expression))
				if l_case_sensitive = Void then
					set_parse_error_message (
						metric_names.err_case_sensitive_attr_missing,
						metric_names.criterion_location (current_basic_metric.name, l_id.name)
					)
				end
				if not has_error and then l_regular_expression = Void then
					set_parse_error_message (
						metric_names.err_regular_expression_attr_missing,
						metric_names.criterion_location (current_basic_metric.name, l_id.name)
					)
				end
				if not has_error then
					if is_valid_boolean_attribute (l_case_sensitive) then
						l_case_sensitive_value := l_case_sensitive.to_boolean
					else
						set_parse_error_message (
							metric_names.err_case_sensitive_attr_invalid (l_case_sensitive),
							metric_names.criterion_location (current_basic_metric.name, l_id.name)
						)
					end
				end
				if not has_error then
					if is_valid_boolean_attribute (l_regular_expression) then
						l_regular_expression_value := l_regular_expression.to_boolean
					else
						set_parse_error_message (
							metric_names.err_regular_expression_attr_invalid (l_regular_expression),
							metric_names.criterion_location (current_basic_metric.name, l_id.name)
						)
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
			l_id := current_criterion_identifier
			if not has_error then
				current_path_criterion := factory.new_path_criterion (l_id.name, l_id.scope)
				last_criterion := current_path_criterion
				setup_criterion (current_path_criterion, l_id.negation)
				register_criterion (current_path_criterion)
			end
		end

	process_caller_criterion is
			-- Process "caller_criterion" definition list node.		
		local
			l_id: TUPLE [name: STRING; scope: QL_SCOPE; negation: BOOLEAN]
			l_only_current_vertion: STRING
			l_only_current_vertion_value: BOOLEAN
		do
			l_id := current_criterion_identifier
			if not has_error then
				l_only_current_vertion := current_attributes.item (at_only_current_version)
				if l_only_current_vertion /= Void then
					if is_valid_boolean_attribute (l_only_current_vertion) then
						l_only_current_vertion_value := l_only_current_vertion.to_boolean
					else
						set_parse_error_message (
							metric_names.err_only_current_version_attr_invalid (l_only_current_vertion),
							metric_names.criterion_location (current_basic_metric.name, l_id.name)
						)
					end
				end
				current_caller_criterion := factory.new_caller_criterion (l_id.name, l_id.scope)
				last_criterion := current_caller_criterion
				setup_criterion (current_caller_criterion, l_id.negation)
				if l_only_current_vertion_value then
					current_caller_criterion.enable_only_current_version
				else
					current_caller_criterion.disable_only_current_version
				end
				register_criterion (current_caller_criterion)
				create current_domain.make
			end
		end

	process_and_criterion is
			-- Process "and_criterion".
		local
			l_id: TUPLE [name: STRING; scope: QL_SCOPE; negation: BOOLEAN]
			l_criterion: EB_METRIC_CRITERION
		do

			l_id := current_criterion_identifier
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
			l_id := current_criterion_identifier
			if not has_error then
				l_criterion := factory.new_or_criterion (l_id.name, l_id.scope)
				last_criterion := l_criterion
				setup_criterion (l_criterion, l_id.negation)
				register_criterion (l_criterion)
			end
		end

	process_text is
			-- Process "text" definition list node.
		do
			if current_tag.item /= t_text then
				set_parse_error_message (metric_names.err_invalid_tag, Void)
			else
				current_text_criterion.set_text (current_content)
			end
		end

	process_path is
			-- Process "path" definition list node.		
		do
			if current_tag.item /= t_path then
				set_parse_error_message (metric_names.err_invalid_tag, Void)
			else
				current_path_criterion.set_path (current_content)
			end
		end

	process_domain is
			-- Process "domain" definition list node.		
		do

			if not current_domain.is_empty then
				set_parse_error_message (
					metric_names.err_too_many_domain,
					metric_names.linear_metric_location_section (current_linear_metric.name)
				)
			end
		end

	process_domain_item is
			-- Process "domain_item" definition list node.		
		local
			l_id: STRING
			l_type: STRING
			l_library_target_uuid: STRING
			l_domain_item: EB_METRIC_DOMAIN_ITEM
		do
			l_id := current_attributes.item (at_id)
			l_type := current_attributes.item (at_type)
			l_library_target_uuid := current_attributes.item (at_library_target_uuid)
			if l_id = Void then
				check
					current_metric /= Void
					last_criterion /= Void
				end
				set_parse_error_message (
					metric_names.err_domain_item_id_is_missing,
					metric_names.criterion_location (current_metric.name, last_criterion.name)
				)
			end
			if not has_error then
				if l_type = Void then
					set_parse_error_message (
						metric_names.err_domain_item_type_is_missing,
						metric_names.criterion_location (current_metric.name, last_criterion.name)
					)
				else
					l_type := internal_name (l_type)
					if not is_domain_item_type_valid (l_type) then
						set_parse_error_message (
							metric_names.err_domain_item_type_invalid (l_type),
							metric_names.criterion_location (current_metric.name, last_criterion.name)
						)
					else
						if l_library_target_uuid /= Void then
							if not shared_uuid.is_valid_uuid (l_library_target_uuid) then
								set_parse_error_message (
									metric_names.err_library_target_uuid_invalid (l_library_target_uuid),
									metric_names.criterion_location (current_metric.name, last_criterion.name)
								)
							end
						end
						if not has_error then
							l_domain_item := domain_item_type_table.item (l_type).item ([l_id])
							if l_library_target_uuid /= Void then
								l_domain_item.set_library_target_uuid (l_library_target_uuid)
							end
							current_domain.extend (l_domain_item)
						end
					end
				end
			end
		end

	process_description is
			-- Process "description" definition list node.		
		do
			if current_metric /= Void then
				current_metric.set_description (current_content.twin)
			else
				set_parse_error_message (metric_names.err_invalid_description_tag, Void)
			end
		end

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

	current_criterion: LIST [EB_METRIC_CRITERION]
			-- Current criterion list

	current_domain: EB_METRIC_DOMAIN
			-- Current domain

	current_criterion_stack: LINKED_STACK [EB_METRIC_NARY_CRITERION]
			-- Current stack for "and" and "or" criterion

	last_criterion: EB_METRIC_CRITERION
			-- Last processed criterion

feature{NONE} -- Implementation

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

				-- scope_ratio_metric
				-- => description
			create l_trans.make (1)
			l_trans.force (t_description, n_description)
			Result.force (l_trans, t_scope_ratio_metric)

				-- criterion
				-- => normal_criterion
				-- => domain_criterion
				-- => text_criterion
				-- => path_criterion
				-- => caller_criterion
				-- => and_criterion
				-- => or_criterion
			create l_trans.make (7)
			l_trans.force (t_normal_criterion, n_normal_criterion)
			l_trans.force (t_domain_criterion, n_domain_criterion)
			l_trans.force (t_text_criterion, n_text_criterion)
			l_trans.force (t_path_criterion, n_path_criterion)
			l_trans.force (t_caller_criterion, n_caller_criterion)
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

				-- and_criterion
				-- => normal_criterion
				-- => domain_criterion
				-- => text_criterion
				-- => path_criterion
				-- => caller_criterion
				-- => and_criterion
				-- => or_criterion
			create l_trans.make (7)
			l_trans.force (t_normal_criterion, n_normal_criterion)
			l_trans.force (t_domain_criterion, n_domain_criterion)
			l_trans.force (t_text_criterion, n_text_criterion)
			l_trans.force (t_path_criterion, n_path_criterion)
			l_trans.force (t_caller_criterion, n_caller_criterion)
			l_trans.force (t_and_criterion, n_and_criterion)
			l_trans.force (t_or_criterion, n_or_criterion)
			Result.force (l_trans, t_and_criterion)

				-- or_criterion
				-- => normal_criterion
				-- => domain_criterion
				-- => text_criterion
				-- => path_criterion
				-- => caller_criterion
				-- => and_criterion
				-- => or_criterion
			create l_trans.make (7)
			l_trans.force (t_normal_criterion, n_normal_criterion)
			l_trans.force (t_domain_criterion, n_domain_criterion)
			l_trans.force (t_text_criterion, n_text_criterion)
			l_trans.force (t_path_criterion, n_path_criterion)
			l_trans.force (t_caller_criterion, n_caller_criterion)
			l_trans.force (t_and_criterion, n_and_criterion)
			l_trans.force (t_or_criterion, n_or_criterion)
			Result.force (l_trans, t_or_criterion)

				-- domain
				-- => domain_item
			create l_trans.make (1)
			l_trans.force (t_domain_item, n_domain_item)
			Result.force (l_trans, t_domain)
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
			create l_attr.make (7)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_uuid, n_uuid)
			l_attr.force (at_numerator, n_numerator)
			l_attr.force (at_numerator_uuid, n_numerator_uuid)
			l_attr.force (at_denominator, n_denominator)
			l_attr.force (at_denominator_uuid, n_denominator_uuid)
			Result.force (l_attr, t_ratio_metric)

				-- scope_ratio_metric
				-- * name
				-- * unit
				-- * numerator
				-- * denominator_scope
			create l_attr.make (4)
			l_attr.force (at_name, n_name)
			l_attr.force (at_unit, n_unit)
			l_attr.force (at_numerator, n_numerator)
			l_attr.force (at_denominator_scope, n_denominator_scope)
			Result.force (l_attr, t_scope_ratio_metric)

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
			l_unit := internal_name (current_attributes.item (at_unit))
			l_uuid_str := current_attributes.item (at_uuid)
			if not has_error then
				if l_name = Void then
					set_parse_error_message (metric_names.err_metric_name_missing_in_metric_definition, Void)
				else
					check_metric_name (l_name)
				end
			end
			if not has_error then
				if l_unit = Void then
					set_parse_error_message (
						metric_names.err_unit_name_missing,
						metric_names.metric_location_section (l_name, metric_type_name (a_metric_type_id))
					)
				elseif not is_unit_valid (l_unit) then
					set_parse_error_message (
						metric_names.err_unit_name_invalid (l_unit),
						metric_names.metric_location_section (l_name, metric_type_name (a_metric_type_id))
					)
				end
			end
			if not has_error then
				check_uuid_vadility (
					l_uuid_str,
					metric_names.metric_location_section (l_name, metric_type_name (a_metric_type_id))
				)
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
			l_name := internal_name (current_attributes.item (at_name))
			l_scope := internal_name (current_attributes.item (at_unit))
			l_negation := internal_name (current_attributes.item (at_negation))
			if l_name = Void then
				set_parse_error_message (
					metric_names.err_criterion_name_missing,
					metric_names.basic_metric_location_section (current_metric.name)
				)
			end
			if not has_error then
				if l_scope = Void then
					set_parse_error_message (
						metric_names.err_unit_name_missing,
						metric_names.criterion_location (current_metric.name, l_name)
					)
				else
					l_ql_scope := scope_table.item (l_scope)
					if l_ql_scope = Void then
						set_parse_error_message (
							metric_names.err_unit_name_invalid (l_scope),
							metric_names.criterion_location (current_metric.name, l_name)
						)
					end
				end
				if not has_error then
					if current_metric.unit.scope /= l_ql_scope then
						set_parse_error_message (
							metric_names.err_basic_metric_unit_not_correct (l_ql_scope.name, current_metric.unit.name),
							metric_names.criterion_location (current_metric.name, l_name)
						)
					end
				end
			end
			if not has_error then
				if l_negation /= Void then
					if not l_negation.is_boolean then
						set_parse_error_message (
							metric_names.err_negation_attr_invalid (l_negation),
							metric_names.criterion_location (current_metric.name, l_name)
						)
					else
						l_negation_used := l_negation.to_boolean
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
					set_parse_error_message (
						metric_names.err_too_many_criteria,
						metric_names.basic_metric_location_section (current_metric.name)
					)
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
				set_parse_error_message (metric_names.err_metric_name_empty, Void)
			else
				if not a_name.item (1).is_graph or else (a_name.count > 1 and then (not a_name.item (a_name.count).is_graph)) then
					set_parse_error_message (metric_names.err_metric_name_invalid (a_name), Void)
				end
			end
		end

invariant
	current_criterion_attached: current_criterion /= Void
	current_attributes_attached: current_attributes /= Void
	current_domain_attached: current_domain /= Void
	metrics_attached: metrics /= Void

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
