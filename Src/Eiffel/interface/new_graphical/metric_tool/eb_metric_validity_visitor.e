note
	description: "Metric validity visitor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_VALIDITY_VISITOR

inherit
	EB_METRIC_VISITOR

	EB_SHARED_ID_SOLUTION

	QL_SHARED

	EB_METRIC_SHARED
		rename
			metric_manager as metric_manager_internal
		end

	SHARED_BENCH_NAMES

create
	make

feature{NONE} -- Initialization

	make (a_manager: EB_METRIC_MANAGER)
			-- Initialize `metric_manager' with `a_manager'.
		do
			metric_manager := a_manager
			create metric_stack.make
			create location_stack.make
			create original_location_stack.make
			create error_table.make (10)
		ensure
			metric_manager_set: metric_manager = a_manager
		end

feature -- Access

	delayed_validity_function: FUNCTION [ANY, TUPLE [a_delayed_domain_item: EB_METRIC_DELAYED_DOMAIN_ITEM], EB_METRIC_ERROR]
			-- Function used to check validity of `a_delayed_domain_item'.
			-- If `a_delayed_domain_item' is invalid, error information is returned from this function, otherwise,
			-- Void is returned.
			-- If this function is Void, validity of a delayed domain item is not checkes thus it's always valid.

feature -- Setting

	set_delayed_validity_function (a_function: like delayed_validity_function)
			-- Set `delayed_validity_function' with `a_function'.
		do
			delayed_validity_function := a_function
		ensure
			delayed_validity_function_set: delayed_validity_function = a_function
		end

	remove_error
			-- Set `has_error' to False, set `last_error' to Void.
		do
			set_last_error (Void)
		ensure
			has_error_set: not has_error
			last_error_set: last_error = Void
		end

	reset
			-- Reset current validator to default status
		do
			remove_error
			error_table.wipe_out
			metric_stack.wipe_out
			location_stack.wipe_out
			original_location_stack.wipe_out
		end

feature -- Validate

	check_metric_validity (a_metric: EB_METRIC; a_force: BOOLEAN)
			-- Process `a_metric' to see if it is valid.
			-- If `a_force' is True, recheck validity for `a_metric' even if it has been checked.
		require
			a_metric_attached: a_metric /= Void
		do
			is_force_check_enabled := a_force
			reset
			current_metric := a_metric
			if (not a_force) and then is_metric_validity_checked (a_metric.name) then
				set_last_error (metric_manager.metric_validity (a_metric.name))
				error_table.force (last_error, a_metric.name)
			else
				a_metric.process (Current)
			end
		end

	check_validity (a_item: EB_METRIC_VISITABLE)
			-- Check validity for `a_item' and store result in `last_error'.
			-- `last_error' is Void means `a_item' is valid, or it contains detailed error information.
		require
			a_item_attached: a_item /= Void
		do
			reset
			a_item.process (Current)
			if has_error then
				set_last_error (error_for_current_level)
			end
		end

feature{NONE} -- Process

	process_basic_metric (a_basic_metric: EB_METRIC_BASIC)
			-- Process `a_basic_metric'.
			-- A basic metric is valid if and only if:
			-- 		* scope of all criteria must be the same as the metric's unit
			--		* every criterion is valid
		local
			l_scope: QL_SCOPE
			l_criteria: EB_METRIC_CRITERION
		do
			if not has_error then
				if is_metric_validity_checked (a_basic_metric.name) then
					raise_error_of_metric (a_basic_metric.name)
				else
					metric_stack.extend (a_basic_metric)
					location_stack.extend (a_basic_metric.visitable_name)
					if not has_error then
						check_metric_name (a_basic_metric.name)
					end
					if not has_error then
						detect_recursive (a_basic_metric)
						if not has_error then
							l_scope := a_basic_metric.unit.scope
							l_criteria := a_basic_metric.criteria
							if l_criteria /= Void then
								if not has_error then
										-- Check validity of criteria.
									if not has_error then
										l_criteria.process (Current)
									end
								end
							end
						end
					end
					register_error_for_current_metric
					metric_stack.remove
					location_stack.remove
				end
			end
		end

	process_linear_metric (a_linear_metric: EB_METRIC_LINEAR)
			-- Process `a_linear_metric'.
			-- A linear metric is valid if and only if:
			--		* there must be at least one sub metric
			--		* every term must have the same unit as the metric
			--		* every term is valid
			--		* no recursive definition
		local
			l_sub_metrics: LIST [STRING]
			l_sub_metric: EB_METRIC
		do
			if not has_error then
				if is_metric_validity_checked (a_linear_metric.name) then
					raise_error_of_metric (a_linear_metric.name)
				else
					metric_stack.extend (a_linear_metric)
					location_stack.extend (a_linear_metric.visitable_name)
					if not has_error then
						check_metric_name (a_linear_metric.name)
					end
					if not has_error then
						detect_recursive (a_linear_metric)
						if not has_error then
								-- Check sub metrics' validity.
							l_sub_metrics := a_linear_metric.variable_metric
							if l_sub_metrics.is_empty then
								create_last_error_with_to_do (
									metric_names.err_variable_metric_missing,
									metric_names.variable_metric_missing_to_do
								)
							else
									-- Check unit of every sub metric.
								from
									l_sub_metrics.start
								until
									l_sub_metrics.after or has_error
								loop
									if not metric_manager.has_metric (l_sub_metrics.item) then
										create_last_error_with_to_do (
											metric_names.err_variable_metric_not_defined,
											metric_names.variable_metric_not_defined_to_do
										)
									else
										l_sub_metric := metric_manager.metric_with_name (l_sub_metrics.item)
										if l_sub_metric.unit /= a_linear_metric.unit then
											create_last_error_with_to_do (
												metric_names.err_variable_metric_unit_not_correct (l_sub_metric.unit.name, a_linear_metric.unit.name),
												metric_names.variable_metric_unit_not_correct_to_do
											)
										end
									end
									l_sub_metrics.forth
								end
									-- Check validity of every sub metric.
								if not has_error then
									from
										l_sub_metrics.start
									until
										l_sub_metrics.after or has_error
									loop
										l_sub_metric := metric_manager.metric_with_name (l_sub_metrics.item)
										l_sub_metric.process (Current)
										l_sub_metrics.forth
									end
								end
							end
						end
					end
					register_error_for_current_metric
					metric_stack.remove
					location_stack.remove
				end
			end
		end

	process_ratio_metric (a_ratio_metric: EB_METRIC_RATIO)
			-- Process `a_ratio_metric'.
			-- A ratio metric is valid if and only if:
			--		* numerator and denomerator metric are valid
			--		* numerator coefficient is valid (valid real number)
			--		* denominator coefficient is valid (valid non-zero real number)
			--		* no recursive definition
		local
			l_num_metric: EB_METRIC
			l_den_metric: EB_METRIC
		do
			if not has_error then
				if is_metric_validity_checked (a_ratio_metric.name) then
					raise_error_of_metric (a_ratio_metric.name)
				else
					metric_stack.extend (a_ratio_metric)
					location_stack.extend (a_ratio_metric.visitable_name)
					if not has_error then
						check_metric_name (a_ratio_metric.name)
					end
					if not has_error then
						detect_recursive (a_ratio_metric)

							-- Check the existance of numerator metric.
						if not has_error then
							if not metric_manager.has_metric (a_ratio_metric.numerator_metric_name) then
								create_last_error_with_to_do (
									metric_names.err_numerator_metric_not_defined (a_ratio_metric.numerator_metric_name),
									metric_names.numerator_denominator_metric_not_defined_to_do
								)
							else
								l_num_metric := metric_manager.metric_with_name (a_ratio_metric.numerator_metric_name)
							end
						end
							-- Check the existance of denominator metric.
						if not has_error then
							if not metric_manager.has_metric (a_ratio_metric.denominator_metric_name) then
								create_last_error_with_to_do (
									metric_names.err_denominator_metric_not_defined (a_ratio_metric.denominator_metric_name),
									metric_names.numerator_denominator_metric_not_defined_to_do
								)
							else
								l_den_metric := metric_manager.metric_with_name (a_ratio_metric.denominator_metric_name)
							end
						end
							-- Check validity of numerator and denominator metric.
						if not has_error then
							l_num_metric.process (Current)
						end
						if not has_error then
							l_den_metric.process (Current)
						end

							-- Check denominator coefficient
						if not has_error then
							if a_ratio_metric.denominator_coefficient = 0 then
								create_last_error_with_to_do (
									metric_names.err_denominator_coefficient_is_zero,
									metric_names.make_sure_denominator_coefficient_non_zero_to_do
								)
							end
						end
					end
					register_error_for_current_metric
					metric_stack.remove
					location_stack.remove
				end
			end
		end

	process_criterion (a_criterion: EB_METRIC_CRITERION)
			-- Process `a_criterion'.
			-- A criterion is valid if it is registered.
		local
			l_last_metric: EB_METRIC
		do
			if not has_error then
				last_criterion := a_criterion
				location_stack.extend (a_criterion.visitable_name)
				l_last_metric := last_metric
				if a_criterion.scope /= l_last_metric.unit.scope then
					create_last_error_with_to_do (
						metric_names.err_basic_metric_unit_not_correct (a_criterion.scope.name,	l_last_metric.unit.name),
						metric_names.unit_in_basic_metric_not_same_to_do
					)
				end
				if not has_error and then not criterion_factory_table.item (a_criterion.scope).has_criterion_with_name (a_criterion.name) then
					create_last_error_with_to_do (
						metric_names.err_criterion_not_exist (a_criterion.name, a_criterion.scope.name),
						metric_names.criterion_not_exist_to_do
					)
				end
				location_stack.remove
			end
		end

	process_domain_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION)
			-- Process `a_criterion'.
			-- A domain criterion is valid if and only if:
			--		* it is a registered criterion
			--		* every domain item is valid
		do
			if not has_error then
				process_criterion (a_criterion)
			end
			if not has_error then
				location_stack.extend (a_criterion.visitable_name)
				if not a_criterion.domain.is_empty then
					a_criterion.domain.process (Current)
				end
				location_stack.remove
			end
		end

	process_caller_callee_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION)
			-- Process `a_criterion'.
			-- A caller/callee criterion is valid if and only if:
			--		* it is a registered criterion
			--		* it contains at least one domain item
			--		* every domain item is valid
		do
			process_domain_criterion (a_criterion)
		end

	process_supplier_client_criterion (a_criterion: EB_METRIC_SUPPLIER_CLIENT_CRITERION)
			-- Process `a_criterion'.
			-- A supplier/client criterion is valid if and only if:
			--		* it is a registered criterion
			--		* it contains at least one domain item
			--		* every domain item is valid			
		do
			process_domain_criterion (a_criterion)
		end

	process_text_criterion (a_criterion: EB_METRIC_TEXT_CRITERION)
			-- Process `a_criterion'.
			-- A text criterion is valid if and only if
			--		* it's a registered criterion
		do
			if not has_error then
				process_criterion (a_criterion)
			end
			if not has_error then
				location_stack.extend (a_criterion.visitable_name)
				location_stack.remove
			end
		end

	process_path_criterion (a_criterion: EB_METRIC_PATH_CRITERION)
			-- Process `a_criterion'.
			-- A path criterion is valid if and only if:
			--		* it's a registered criterion

		do
			if not has_error then
				process_criterion (a_criterion)
			end
		end

	process_normal_criterion (a_criterion: EB_METRIC_NORMAL_CRITERION)
			-- Process `a_criterion'.
			-- A normal criterion is valid if and only if:
			--		* it's a registered criterion
		do
			if not has_error then
				process_criterion (a_criterion)
			end
		end

	process_nary_criterion (a_criterion: EB_METRIC_NARY_CRITERION)
			-- Process `a_criterion'.
		do
			if not has_error then
				location_stack.extend (a_criterion.visitable_name)
				process_list (a_criterion.operands)
				location_stack.remove
			end
		end

	process_value_criterion (a_criterion: EB_METRIC_VALUE_CRITERION)
			-- Process `a_criterion'.
			-- A value criterion is valid if and only if:
			--		* metric name is specified and that metric is valid.
			--		* specified domain is valid.
			--		* specified value tester is valid.
		local
			l_metric: EB_METRIC
			l_metric_name: STRING
		do
			if not has_error then
				process_domain_criterion (a_criterion)
			end
			if not has_error then
				location_stack.extend (a_criterion.visitable_name)
				l_metric_name := a_criterion.metric_name
				if not metric_manager.has_metric (l_metric_name) then
					create_last_error_with_to_do (
						metric_names.err_metric_name_invalid (l_metric_name),
						metric_names.metric_invalid_to_do
					)
				else
					l_metric := metric_manager.metric_with_name (l_metric_name)
					if not has_error then
						l_metric.process (Current)
					end
--					if not has_error then
--						if a_criterion.value_tester.criteria.is_empty then
--							create_last_error_with_to_do (
--								metric_names.err_no_value_tester_specified,
--								metric_names.no_value_tester_specified_to_do)
--						end
--					end
						-- Check validity of referenced metric by current value criterion.
					if not has_error then
						l_metric.process (Current)
					end
						-- Check if value tester is valid.
					if not has_error then
						a_criterion.value_tester.process (Current)
					end
				end
				location_stack.remove
			end
		end

	process_external_command_criterion (a_criterion: EB_METRIC_EXTERNAL_COMMAND_CRITERION)
			-- Process `a_criterion'.
		do
			if not has_error then
				process_criterion (a_criterion)
				if not has_error then
					a_criterion.tester.process (Current)
				end
			end
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
		do
			if not has_error then
				location_stack.extend (a_domain.visitable_name)
				process_list (a_domain)
				location_stack.remove
			end
		end

	process_domain_item (a_item: EB_METRIC_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			check last_domain_item_error_retriever /= Void end
			location_stack.extend (a_item.visitable_name)
			if not a_item.is_valid then
				create_last_error_with_to_do (
					last_domain_item_error_retriever.item ([a_item.string_representation, a_item.id]),
					metric_names.invalid_domain_item_info
				)
			end
			location_stack.remove
		end

	process_application_target_domain_item (a_item: EB_METRIC_TARGET_DOMAIN_ITEM)
			-- Process `a_item'.
		do
			-- Nothing to be done here.
		end

	process_group_domain_item (a_item: EB_METRIC_GROUP_DOMAIN_ITEM)
			-- Process `a_item'.
			-- A group domain item is valid if and only if:
			--		* the group it represents exists in current system
		do
			if not has_error then
				set_last_domain_item_error_retriever (agent metric_names.err_invalid_group_domain_item)
				process_domain_item (a_item)
				set_last_domain_item_error_retriever (Void)
			end
		end

	process_folder_domain_item (a_item: EB_METRIC_FOLDER_DOMAIN_ITEM)
			-- Process `a_item'.
			-- A folder domain item is valid if and only if:
			--		* the folder it represents exists in current system
		do
			if not has_error then
				set_last_domain_item_error_retriever (agent metric_names.err_invalid_folder_domain_item)
				process_domain_item (a_item)
				set_last_domain_item_error_retriever (Void)
			end
		end

	process_class_domain_item (a_item: EB_METRIC_CLASS_DOMAIN_ITEM)
			-- Process `a_item'.
			-- A class domain item is valid if and only if:
			--		* the class it represents exists in current system		
		do
			if not has_error then
				set_last_domain_item_error_retriever (agent metric_names.err_invalid_class_domain_item)
				process_domain_item (a_item)
				set_last_domain_item_error_retriever (Void)
			end
		end

	process_feature_domain_item (a_item: EB_METRIC_FEATURE_DOMAIN_ITEM)
			-- Process `a_item'.
			-- A feature domain item is valid if and only if:
			--		* the feature it represents exists in current system
		do
			if not has_error then
				set_last_domain_item_error_retriever (agent metric_names.err_invalid_feature_domain_item)
				process_domain_item (a_item)
				set_last_domain_item_error_retriever (Void)
			end
		end

	process_delayed_domain_item (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM)
			-- Process `a_item'.
		local
			l_error: EB_METRIC_ERROR
		do
			if delayed_validity_function /= Void then
				l_error := delayed_validity_function.item ([a_item])
				if l_error /= Void then
					create_last_error_with_to_do (l_error.message, l_error.to_do)
				end
			end
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
			l_item: TUPLE [value_retriever: EB_METRIC_VALUE_RETRIEVER; operator_name: INTEGER]
			l_testers: LIST [TUPLE [value_retriever: EB_METRIC_VALUE_RETRIEVER; operator_name: INTEGER]]
			l_cursor: CURSOR
		do
			if not has_error then
				location_stack.extend (a_item.visitable_name)
				l_testers := a_item.criteria
				l_cursor := l_testers.cursor
				from
					l_testers.start
				until
					l_testers.after
				loop
					l_item := l_testers.item
					l_item.value_retriever.process (Current)
					l_testers.forth
				end
				l_testers.go_to (l_cursor)
				location_stack.remove
			end
		end

	process_constant_value_retriever (a_item: EB_METRIC_CONSTANT_VALUE_RETRIEVER)
			-- Process `a_item'.
		do
		end

	process_metric_value_retriever (a_item: EB_METRIC_METRIC_VALUE_RETRIEVER)
			-- Process `a_item'.
		do
			if not has_error then
				location_stack.extend (a_item.visitable_name)
				test_metric (a_item.metric_name)
				if not has_error then
					a_item.input_domain.process (Current)
				end
				location_stack.remove
			end
		end

	process_external_command_tester (a_item: EB_METRIC_EXTERNAL_COMMAND_TESTER)
			-- Process `a_item'.
			-- An external command tester is valid if and only if:
			-- 	* If input is redirected to file, a file is specified
			--  * If output is redirected to file, a file is specified
			--	* If error is redirected to file, a file is specified
		do
			if not has_error then
				if not a_item.is_command_specified then
					create_last_error (metric_names.err_external_command_empty)
				end
				if 	not has_error and then
					a_item.is_input_as_file and then
					a_item.input.is_empty
				then
					create_last_error (metric_names.err_external_command_file_not_specified (names.string_general_as_lower (external_output_names.l_input)))
				end
				if 	not has_error and then
					a_item.is_output_enabled and then
					a_item.is_output_as_file and then
					a_item.output.is_empty
				then
					create_last_error (metric_names.err_external_command_file_not_specified (names.string_general_as_lower (external_output_names.l_output)))
				end

				if  not has_error and then
					a_item.is_error_enabled and then
					not a_item.is_error_redirected_to_output and then
					a_item.is_error_as_file and then
					a_item.error.is_empty
				then
					create_last_error (metric_names.err_external_command_file_not_specified (names.string_general_as_lower (names.l_error)))
				end
			end
		end

feature -- Access

	current_metric: EB_METRIC
			-- Current metric being visited

	metric_manager: EB_METRIC_MANAGER
			-- Metric manager

	last_error: EB_METRIC_ERROR
			-- Last error
			-- The actual error. For example, we have the following metric tree:
			-- metric_a
			--   |
			--   +- metric_b
			--       |
			--       +- metric_c
			-- which means metric_a references metric_b and metric_b references metric_c.
			-- And suppose when we are checking metric_a, and the checker will in turn checks metric_b and metric_c.
			-- When checking metric_c, if there is an error, then metric_a, metric_b and metric_c will be marked as invalid.
			-- They all have an item in `error_table'.

	error_table: HASH_TABLE [EB_METRIC_ERROR, STRING];
			-- Table for metric validity errors.
			-- Key is metric name, value is validity for that metric
			-- When check validity of a given metric, we may also need to check all the unchecked
			-- referenced metrics recursively, `error_table' will store all the validity of those referenced
			-- metrics indexed by metric name. Then later we don't need to check those referenced metrics
			-- a second time.

feature -- Status report

	has_error: BOOLEAN
			-- Has error?
		do
			Result := last_error /= Void
		end

feature{NONE} -- Status report

	is_metric_validity_checked (a_metric_name: STRING): BOOLEAN
			-- Is validity of metric named `a_metric_name' checked?
		require
			a_metric_name_attached: a_metric_name /= Void
		local
			l_manager: like metric_manager
		do
			if not is_force_check_enabled then
				l_manager := metric_manager
				Result :=  l_manager.has_metric (a_metric_name) and then
						   (error_table.has (a_metric_name) or else l_manager.is_metric_validity_checked (a_metric_name))
			end
		end

	is_force_check_enabled: BOOLEAN
			-- Should validity checking be performed even if specified metric has been checked?

feature{NONE} -- Implementation

	detect_recursive (a_metric: EB_METRIC)
			-- Detect recursive difinitoin of `current_metric'.
		require
			a_metric_attached: a_metric /= Void
			metric_stack_not_empty: not metric_stack.is_empty
		local
			l_metric_stack: like metric_stack
			l_linear: LIST [EB_METRIC]
			l_metric_manager: like metric_manager
			l_name: STRING
		do
			if not has_error then
				l_metric_stack := metric_stack.duplicate (metric_stack.count)
				if l_metric_stack.count > 1 then
					l_metric_stack.remove
					l_linear := l_metric_stack.linear_representation
					l_metric_manager := metric_manager
					l_name := a_metric.name
					from
						l_linear.start
					until
						l_linear.after
					loop
						if l_metric_manager.is_metric_name_equal (l_name, l_linear.item.name) then
							create_last_error_with_to_do (
								metric_names.err_recursive_metric_definition (current_metric.name),
								metric_names.recursive_definition_to_do
							)
						end
						l_linear.forth
					end
				end
			end
		end

	create_last_error (a_msg: STRING_GENERAL)
			-- Create `last_error' with message `a_msg' and set `has_error' with True.
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
		do
			create last_error.make (a_msg)
			store_location_stack
		ensure
			last_error_created: last_error /= Void
		end

	create_last_error_with_to_do (a_msg: STRING_GENERAL; a_to_do: STRING_GENERAL)
			-- Create `last_error' with message `a_msg', `a_location', `a_to_do'.
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
		do
			create_last_error (a_msg)
			last_error.set_to_do (a_to_do)
		end

	last_metric: EB_METRIC
			-- Last metric been checked
		require
			metric_stack_not_empty: not metric_stack.is_empty
		do
			Result := metric_stack.item
		ensure
			result_attached: Result /= Void
		end

	last_criterion: EB_METRIC_CRITERION
			-- Last analyzed criterion

	check_metric_name (a_name: STRING)
			-- Check if `a_name' is a valid metric name.
		do
			if a_name = Void or else a_name.is_empty then
				create_last_error_with_to_do (
					metric_names.err_metric_name_empty,
					metric_names.metric_name_empty_to_do
				)
			else
				if not a_name.item (1).is_graph or else (a_name.count > 1 and then (not a_name.item (a_name.count).is_graph)) then
					create_last_error_with_to_do (
						metric_names.err_metric_name_invalid (a_name),
						metric_names.metric_name_info)
				end
			end
		end

	test_metric (a_metric_name: STRING)
			-- Test validity of metric named `a_metric_name'.
			-- tests include existance, recursive definition.
			-- If `a_metric_name' represents a valid metric, make that metric in `last_tested_metric'.
			-- If error occurs, fire that error.
		require
			a_metric_name_attached: a_metric_name /= Void
		local
			l_metric: EB_METRIC
		do
			if not has_error then
				if not metric_manager.has_metric (a_metric_name) then
					create_last_error_with_to_do (
						metric_names.err_metric_name_invalid (a_metric_name),
						metric_names.metric_invalid_to_do
					)
				else
					l_metric := metric_manager.metric_with_name (a_metric_name)
					if not has_error then
						l_metric.process (Current)
					end
					if not has_error then
						last_tested_metric := l_metric
					end
				end
			end
		end

	last_tested_metric: EB_METRIC;
			-- Last successfully tested metric by `test_metric'

	metric_stack: LINKED_STACK [EB_METRIC]
			-- Stack of metrics during validity checking
			-- Used for recursive detection

	location_stack: LINKED_STACK [STRING_GENERAL]
			-- Stack of location information.
			-- For example, when we are checking a basic metric metric_a wich a caller_is criterion,
			-- and now we are in the domain of the caller_is criterion, we have the following location stack:
			-- domain					 -- top
			-- criterion (caller_is)
			-- basic metric (metric_a)   --  bottom

	original_location_stack: like location_stack
			-- Original location stack use to store `location_stack' when an error occurs.

	store_location_stack
			-- Store `location_stack' into `original_location_stack'.
		do
			original_location_stack := location_stack.duplicate (location_stack.count)
		end

	location: STRING_GENERAL
			-- Location of current error
		require
			has_error: has_error
		local
			l_level: INTEGER
			l_last_error_loc: STRING_GENERAL
			l_relative_loc_stack: like location_stack
			l_loc_list: LINKED_LIST [STRING_GENERAL]
			l_cnt: INTEGER
		do
			l_level := original_location_stack.count - location_stack.count + 1
			if l_level > 0 then
				from
					l_relative_loc_stack := original_location_stack.duplicate (l_level)
					create l_loc_list.make
				until
					l_relative_loc_stack.is_empty
				loop
					l_loc_list.put_front (l_relative_loc_stack.item)
					l_relative_loc_stack.remove
				end
				from
					l_loc_list.start
					l_cnt := l_loc_list.count
				until
					l_loc_list.after
				loop
					if l_last_error_loc = Void then
						l_last_error_loc := l_loc_list.item.twin
					else
						l_last_error_loc.append (l_loc_list.item)
					end
					if l_loc_list.index < l_cnt then
						l_last_error_loc.append (metric_names.location_connector)
					end
					l_loc_list.forth
				end
				if last_error.location /= Void then
					l_last_error_loc.append (metric_names.location_connector)
					l_last_error_loc.append (last_error.location)
				end
			end
			Result := l_last_error_loc
		ensure
			result_attached: Result /= Void
		end

	error_for_current_level: EB_METRIC_ERROR
			-- Error for current level
		require
			has_error: has_error
		do
			create Result.make (last_error.message)
			Result.set_to_do (last_error.to_do)
			Result.set_location (location)
		ensure
			result_attached: Result /= Void
		end

	register_error_for_current_metric
			-- Register `last_error' for top metric in `metric_stack'.
		do
			if has_error then
				error_table.force (error_for_current_level, metric_stack.item.name)
			else
				error_table.force (Void, metric_stack.item.name)
			end
		end

	last_domain_item_error_retriever: FUNCTION [ANY, TUPLE [STRING_GENERAL, STRING_GENERAL], STRING_GENERAL]
			-- Last error message retriever

	set_last_domain_item_error_retriever (a_retriever: like last_domain_item_error_retriever)
			-- Set `last_domain_item_error_retriever' with `a_retriever'.
		do
			last_domain_item_error_retriever := a_retriever
		ensure
			last_domain_item_error_retriever_set: last_domain_item_error_retriever = a_retriever
		end

	raise_error_of_metric (a_metric_name: STRING)
			-- Raise error of metric named `a_metric_name' if any.
		require
			a_metric_name_attached: a_metric_name /= Void
			metric_validity_checked: is_metric_validity_checked (a_metric_name)
		local
			l_error: like last_error
		do
			if metric_manager.is_metric_validity_checked (a_metric_name) then
				l_error := metric_manager.metric_validity (a_metric_name)
			elseif error_table.has (a_metric_name) then
				l_error := error_table.item (a_metric_name)
			end
			if l_error /= Void then
				create_last_error_with_to_do (l_error.message, l_error.to_do)
				if l_error.location /= Void then
					last_error.set_location (l_error.location.twin)
				end
			end
		end

	set_last_error (a_error: like last_error)
			-- Set `last_error' with `a_error'.
		do
			last_error := a_error
		ensure
			last_error_set: last_error = a_error
		end

invariant
	metric_manager_attached: metric_manager /= Void
	location_stack_attached: location_stack /= Void
	original_location_stack_attached: original_location_stack /= Void
	metric_stack_attached: metric_stack /= Void
	error_table_attached: error_table /= Void

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
