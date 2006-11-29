indexing
	description: "Metric vadility visitor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_VADILITY_VISITOR

inherit
	EB_METRIC_VISITOR

	EB_SHARED_ID_SOLUTION

	QL_SHARED

	EB_METRIC_SHARED
		rename
			metric_manager as metric_manager_internal
		end

create
	make

feature{NONE} -- Initialization

	make (a_manager: EB_METRIC_MANAGER) is
			-- Initialize `metric_manager' with `a_manager'.
		do
			metric_manager := a_manager
			create {ARRAYED_LIST [EB_METRIC]} processed_metrics.make (10)
		ensure
			metric_manager_set: metric_manager = a_manager
		end

feature -- Setting

	remove_error is
			-- Set `has_error' to False, set `last_error' to Void.
		do
			has_error := False
			last_error := Void
		ensure
			has_error_set: not has_error
			last_error_set: last_error = Void
		end

	reset is
			-- Reset current validator to default status
		do
			remove_error
			processed_metrics.wipe_out
			is_current_metric_processed := False
		end

feature -- Validate

	process_metric (a_metric: EB_METRIC) is
			-- Process `a_metric' to see if it is valid.
		require
			a_metric_attached: a_metric /= Void
		do
			reset
			current_metric := a_metric
			a_metric.process (Current)
		end

feature -- Process

	process_basic_metric (a_basic_metric: EB_METRIC_BASIC) is
			-- Process `a_basic_metric'.
			-- A basic metric is valid if and only if:
			-- 		* scope of all criteria must be the same as the metric's unit
			--		* every criterion is valid
		local
			l_scope: QL_SCOPE
			l_criteria: EB_METRIC_CRITERION
		do
			last_metric := a_basic_metric
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
								-- Check vadility of criteria.
							if not has_error then
								l_criteria.process (Current)
							end
						end
					end
				end
			end
		end

	process_linear_metric (a_linear_metric: EB_METRIC_LINEAR) is
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
			last_metric := a_linear_metric
			if not has_error then
				check_metric_name (a_linear_metric.name)
			end
			if not has_error then
				detect_recursive (a_linear_metric)
				if not has_error then
						-- Check sub metrics' vadility.
					l_sub_metrics := a_linear_metric.variable_metric
					if l_sub_metrics.is_empty then
						create_last_error_with_to_do (
							metric_names.err_variable_metric_missing,
							metric_names.linear_metric_location_section (a_linear_metric.name),
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
									metric_names.variable_metric_location (a_linear_metric.name, l_sub_metrics.item),
									metric_names.variable_metric_not_defined_to_do
								)
							else
								l_sub_metric := metric_manager.metric_with_name (l_sub_metrics.item)
								if l_sub_metric.unit /= a_linear_metric.unit then
									create_last_error_with_to_do (
										metric_names.err_variable_metric_unit_not_correct (l_sub_metric.unit.name, a_linear_metric.unit.name),
										metric_names.variable_metric_location (a_linear_metric.name, l_sub_metrics.item),
										metric_names.variable_metric_unit_not_correct_to_do
									)
								end
							end
							l_sub_metrics.forth
						end
							-- Check vadility of every sub metric.
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
		end

	process_ratio_metric (a_ratio_metric: EB_METRIC_RATIO) is
			-- Process `a_ratio_metric'.
			-- A ratio metric is valid if and only if:
			--		* numerator and denomerator metric are valid
			--		* no recursive definition
		local
			l_num_metric: EB_METRIC
			l_den_metric: EB_METRIC
		do
			last_metric := a_ratio_metric
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
							metric_names.ratio_metric_location_section (a_ratio_metric.name),
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
							metric_names.ratio_metric_location_section (a_ratio_metric.name),
							metric_names.numerator_denominator_metric_not_defined_to_do
						)
					else
						l_den_metric := metric_manager.metric_with_name (a_ratio_metric.denominator_metric_name)
					end
				end
					-- Check vadility of numerator and denominator metric.
				if not has_error then
					l_num_metric.process (Current)
				end
				if not has_error then
					l_den_metric.process (Current)
				end
			end
		end

	process_criterion (a_criterion: EB_METRIC_CRITERION) is
			-- Process `a_criterion'.
			-- A criterion is valid if it is registered.
		do
			last_criterion := a_criterion
			if not has_error then
				check last_metric /= Void end
				if a_criterion.scope /= last_metric.unit.scope then
					create_last_error_with_to_do (
						metric_names.err_basic_metric_unit_not_correct (a_criterion.scope.name,	last_metric.unit.name),
						metric_names.criterion_location (last_metric.name, a_criterion.name),
						metric_names.unit_in_basic_metric_not_same_to_do
					)
				end
				if not has_error and then not criterion_factory_table.item (a_criterion.scope).has_criterion_with_name (a_criterion.name) then
					create_last_error_with_to_do (
						metric_names.err_criterion_not_exist (a_criterion.name, a_criterion.scope.name),
						metric_names.metric_location_section (last_metric.name, metric_type_name (metric_type_id (last_metric))),
						metric_names.criterion_not_exist_to_do
					)
				end
			end
		end

	process_domain_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION) is
			-- Process `a_criterion'.
			-- A domain criterion is valid if and only if:
			--		* it is a registered criterion
			--		* it contains at least one domain item
			--		* every domain item is valid
		local
			l_domain: EB_METRIC_DOMAIN
		do
			if not has_error then
				process_criterion (a_criterion)
			end
			if not has_error then
				if a_criterion.domain.is_empty then
					check last_metric /= Void end
					create_last_error_with_to_do (
						metric_names.err_domain_item_not_exist,
						metric_names.criterion_location (last_metric.name, a_criterion.name),
						metric_names.domain_item_not_exists_to_do
					)
				end
				if not has_error then
					l_domain := a_criterion.domain
					from
						l_domain.start
					until
						l_domain.after or has_error
					loop
						l_domain.item.process (Current)
						l_domain.forth
					end
				end
			end
		end

	process_caller_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION) is
			-- Process `a_criterion'.
			-- A caller criterion is valid if and only if:
			--		* it is a registered criterion
			--		* it contains at least one domain item
			--		* every domain item is valid
		do
			process_domain_criterion (a_criterion)
		end

	process_text_criterion (a_criterion: EB_METRIC_TEXT_CRITERION) is
			-- Process `a_criterion'.
			-- A text criterion is valid if and only if
			--		* it's a registered criterion
			--		* its text is not emtpy
		do
			if not has_error then
				process_criterion (a_criterion)
			end
			if not has_error then
				if a_criterion.text.is_empty then
					check last_metric /= Void end
					create_last_error_with_to_do (
						metric_names.err_text_in_text_criterion_empty,
						metric_names.criterion_location (last_metric.name, a_criterion.name),
						metric_names.text_in_text_criterion_empty_to_do
					)
				end
			end
		end

	process_path_criterion (a_criterion: EB_METRIC_PATH_CRITERION) is
			-- Process `a_criterion'.
			-- A path criterion is valid if and only if:
			--		* it's a registered criterion

		do
			if not has_error then
				process_criterion (a_criterion)
			end
		end

	process_normal_criterion (a_criterion: EB_METRIC_NORMAL_CRITERION) is
			-- Process `a_criterion'.
			-- A normal criterion is valid if and only if:
			--		* it's a registered criterion
		do
			if not has_error then
				process_criterion (a_criterion)
			end
		end

	process_nary_criterion (a_criterion: EB_METRIC_NARY_CRITERION) is
			-- Process `a_criterion'.
		do
			if not has_error then
				process_list (a_criterion.operands)
			end
		end

	process_and_criterion (a_criterion: EB_METRIC_AND_CRITERION) is
			-- Process `a_criterion'.
		do
			process_nary_criterion (a_criterion)
		end

	process_or_criterion (a_criterion: EB_METRIC_OR_CRITERION) is
			-- Process `a_criterion'.
		do
			process_nary_criterion (a_criterion)
		end

	process_domain_item (a_item: EB_METRIC_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			check
				should_not_arrive_here: False
			end
		end

	process_application_target_domain_item (a_item: EB_METRIC_TARGET_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			-- Nothing to be done here.
		end

	process_group_domain_item (a_item: EB_METRIC_GROUP_DOMAIN_ITEM) is
			-- Process `a_item'.
			-- A group domain item is valid if and only if:
			--		* the group it represents exists in current system
		local
			l_conf_group: CONF_GROUP
		do
			if not has_error then
				l_conf_group := group_of_id (a_item.id)
				if l_conf_group = Void then
					check
						last_metric /= Void
						last_criterion /= Void
					end
					create_last_error_with_to_do (
						metric_names.err_invalid_group_domain_item (last_group_name, a_item.id),
						metric_names.criterion_location (last_metric.name, last_criterion.name),
						metric_names.invalid_domain_item_info
					)
				end
			end
		end

	process_folder_domain_item (a_item: EB_METRIC_FOLDER_DOMAIN_ITEM) is
			-- Process `a_item'.
			-- A folder domain item is valid if and only if:
			--		* the folder it represents exists in current system
		local
			l_folder: EB_FOLDER
		do
			if not has_error then
				l_folder := folder_of_id (a_item.id)
				if l_folder = Void then
					check
						last_metric /= Void
						last_criterion /= Void
					end
					create_last_error_with_to_do (
						metric_names.err_invalid_folder_domain_item (last_folder_name, a_item.id),
						metric_names.criterion_location (last_metric.name, last_criterion.name),
						metric_names.invalid_domain_item_info
					)
				end
			end
		end

	process_class_domain_item (a_item: EB_METRIC_CLASS_DOMAIN_ITEM) is
			-- Process `a_item'.
			-- A class domain item is valid if and only if:
			--		* the class it represents exists in current system		
		local
			l_conf_class: CONF_CLASS
		do
			if not has_error then
				l_conf_class := class_of_id (a_item.id)
				if l_conf_class = Void then
					check
						last_metric /= Void
						last_criterion /= Void
					end
					create_last_error_with_to_do (
						metric_names.err_invalid_class_domain_item (last_class_name, a_item.id),
						metric_names.criterion_location (last_metric.name, last_criterion.name),
						metric_names.invalid_domain_item_info
					)

				end
			end
		end

	process_feature_domain_item (a_item: EB_METRIC_FEATURE_DOMAIN_ITEM) is
			-- Process `a_item'.
			-- A feature domain item is valid if and only if:
			--		* the feature it represents exists in current system
		local
			l_feature: E_FEATURE
		do
			if not has_error then
				l_feature := feature_of_id (a_item.id)
				if l_feature = Void then
					check
						last_metric /= Void
						last_criterion /= Void
					end
					create_last_error_with_to_do (
						metric_names.err_invalid_feature_domain_item (last_feature_name, a_item.id),
						metric_names.criterion_location (last_metric.name, last_criterion.name),
						metric_names.invalid_domain_item_info
					)
				end
			end
		end

	process_delayed_domain_item (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
			-- Nothing to be done here.
		end

	process_metric_archive_node (a_item: EB_METRIC_ARCHIVE_NODE) is
			-- Process `a_item'.
		do
		end

feature -- Access

	current_metric: EB_METRIC
			-- Current metric being visited

	current_criterion: EB_METRIC_CRITERION
			-- Current criterion

	metric_manager: EB_METRIC_MANAGER
			-- Metric manager

	last_error: EB_METRIC_ERROR
			-- Last error

feature -- Status report

	has_error: BOOLEAN
			-- Has error?

feature{NONE} -- Implementation

	processed_metrics: LIST [EB_METRIC]
			-- List of process metrics used to detect recursive definition

	detect_recursive (a_metric: EB_METRIC) is
			-- Detect recursive difinitoin of `current_metric'.
		require
			a_metric_attached: a_metric /= Void
		do
			check
				current_metric_attached: current_metric /= Void
			end
			if a_metric.name.is_equal (current_metric.name) then
				if is_current_metric_processed then
					create_last_error_with_to_do (
						metric_names.err_recursive_metric_definition (current_metric.name),
						metric_names.metric_location_section (current_metric.name, metric_type_name (metric_type_id (current_metric))),
						metric_names.recursive_definition_to_do
					)
				else
					is_current_metric_processed := True
				end
			end
		end

	is_current_metric_processed: BOOLEAN
			-- Is `current_metric' processed?
			-- Used for recursive definition detection.

	create_last_error (a_msg: STRING_GENERAL) is
			-- Create `last_error' with message `a_msg' and set `has_error' with True.
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
		do
			has_error := True
			create last_error.make (a_msg)
		ensure
			last_error_created: last_error /= Void
		end

	create_last_error_with_to_do (a_msg: STRING_GENERAL; a_location: STRING_GENERAL; a_to_do: STRING_GENERAL) is
			-- Create `last_error' with message `a_msg', `a_location', `a_to_do'.
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
		do
			create_last_error (a_msg)
			last_error.set_location (a_location)
			last_error.set_to_do (a_to_do)
		end

	last_metric: EB_METRIC
			-- Last metric been checked

	last_criterion: EB_METRIC_CRITERION
			-- Last analyzed criterion



	check_metric_name (a_name: STRING) is
			-- Check if `a_name' is a valid metric name.
		do
			if a_name = Void or else a_name.is_empty then
				create_last_error_with_to_do (
					metric_names.err_metric_name_empty,
					Void,
					metric_names.metric_name_empty_to_do
				)
			else
				if not a_name.item (1).is_graph or else (a_name.count > 1 and then (not a_name.item (a_name.count).is_graph)) then
					create_last_error_with_to_do (
						metric_names.err_metric_name_invalid (a_name),
						metric_names.metric_location_section (current_metric.name, metric_type_name (metric_type_id (current_metric))),
						metric_names.metric_name_info)
				end
			end
		end

invariant
	metric_manager_attached: metric_manager /= Void
	processed_metrics_attached: processed_metrics /= Void

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
