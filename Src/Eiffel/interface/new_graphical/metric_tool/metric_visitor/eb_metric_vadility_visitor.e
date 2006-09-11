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
			l_error_msg: STRING
			l_to_do_msg: STRING
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
						create l_error_msg.make (100)
						l_error_msg.append (once "Variable metric missing in linear metric %"")
						l_error_msg.append (a_linear_metric.name)
						l_error_msg.append (once "%".")
						create l_to_do_msg.make (256)
						append_linear_metric_info (l_to_do_msg)
						l_to_do_msg.append (once "Make sure that at lease one variable metric is listed %Nin a linear metric definition.")
						create_last_error_with_to_do (l_error_msg, l_to_do_msg)
					else
							-- Check unit of every sub metric.
						from
							l_sub_metrics.start
						until
							l_sub_metrics.after or has_error
						loop
							if not metric_manager.has_metric (l_sub_metrics.item) then
								create l_error_msg.make (100)
								l_error_msg.append (once "No definition for variable metric %"")
								l_error_msg.append (l_sub_metrics.item)
								l_error_msg.append (once " in linear metric %"")
								l_error_msg.append (a_linear_metric.name)
								l_error_msg.append (once "%".")
								create l_to_do_msg.make (256)
								append_linear_metric_info (l_to_do_msg)
								l_to_do_msg.append (once "Make sure every variable metric referenced by a linear metric is defined.")
								create_last_error_with_to_do (l_error_msg, l_to_do_msg)
							else
								l_sub_metric := metric_manager.metric_with_name (l_sub_metrics.item)
								if l_sub_metric.unit /= a_linear_metric.unit then
									create l_error_msg.make (256)
									l_error_msg.append (once "Unit of variable metric %"")
									l_error_msg.append (l_sub_metric.name)
									l_error_msg.append (once "%" is ")
									l_error_msg.append (l_sub_metric.unit.name)
									l_error_msg.append (once ", which is different from unit of linear metric %"")
									l_error_msg.append (a_linear_metric.name)
									l_error_msg.append (once "%", which is ")
									l_error_msg.append (a_linear_metric.unit.name)
									l_error_msg.append (".")
									create l_to_do_msg.make (256)
									append_linear_metric_info (l_to_do_msg)
									l_to_do_msg.append (once "Make sure unit of every variable metric is same as that of the linear metric.")
									create_last_error_with_to_do (l_error_msg, l_to_do_msg)
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
			l_error_msg: STRING
			l_to_do_msg: STRING
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
						create l_error_msg.make (256)
						l_error_msg.append (once "Numerator metric %"")
						l_error_msg.append (a_ratio_metric.numerator_metric_name)
						l_error_msg.append (once "%" is not defined in ratio metric %"")
						l_error_msg.append (a_ratio_metric.name)
						l_error_msg.append (once "%".")
						create l_to_do_msg.make (256)
						append_ratio_metric_info (l_to_do_msg)
						l_to_do_msg.append (once "Make sure that numerator and denominator metric referenced by ratio metric are defined.")
						create_last_error_with_to_do (l_error_msg, l_to_do_msg)
					else
						l_num_metric := metric_manager.metric_with_name (a_ratio_metric.numerator_metric_name)
					end
				end
					-- Check the existance of denominator metric.
				if not has_error then
					if not metric_manager.has_metric (a_ratio_metric.denominator_metric_name) then
						create l_error_msg.make (256)
						l_error_msg.append (once "Denominator metric %"")
						l_error_msg.append (a_ratio_metric.denominator_metric_name)
						l_error_msg.append (once "%" is not defined in ratio metric %"")
						l_error_msg.append (a_ratio_metric.name)
						l_error_msg.append (once "%".")
						create l_to_do_msg.make (256)
						append_ratio_metric_info (l_to_do_msg)
						l_to_do_msg.append (once "Make sure that numerator and denominator metric referenced by ratio metric are defined.")
						create_last_error_with_to_do (l_error_msg, l_to_do_msg)
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
		local
			l_error_msg: STRING
			l_to_do_msg: STRING
		do
			last_criterion := a_criterion
			if not has_error then
				check last_metric /= Void end
				if a_criterion.scope /= last_metric.unit.scope then
					create l_error_msg.make (256)
					l_error_msg.append (once "Criterion unit is different from basic metric scope: ")
					l_error_msg.append (once "In basic metric %"")
					l_error_msg.append (last_metric.name)
					l_error_msg.append (once "%" whose unit is ")
					l_error_msg.append (last_metric.unit.scope.name)
					l_error_msg.append (once ", criterion %"")
					l_error_msg.append (a_criterion.name)
					l_error_msg.append (once "%" is of unit ")
					l_error_msg.append (a_criterion.scope.name)
					l_error_msg.append (".")
					create l_to_do_msg.make (256)
					l_to_do_msg.append (once "Make sure every (recursive) criterion in basic metric%Nis of the same unit with that basic metric.")
					create_last_error_with_to_do (l_error_msg, l_to_do_msg)
				end
				if not has_error and then not criterion_factory_table.item (a_criterion.scope).has_criterion_with_name (a_criterion.name) then
					create l_error_msg.make (100)
					l_error_msg.append (once "Criterion %"")
					l_error_msg.append (a_criterion.name)
					l_error_msg.append (once "%" of unit ")
					l_error_msg.append (a_criterion.scope.name)
					l_error_msg.append (once " doesn't exist.")
					create l_to_do_msg.make_from_string (once "Make sure that the criterion of given unit exists.")
					create_last_error_with_to_do (l_error_msg, l_to_do_msg)
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
			l_error_msg: STRING
			l_to_do_msg: STRING
		do
			if not has_error then
				process_criterion (a_criterion)
			end
			if not has_error then
				if a_criterion.domain.is_empty then
					check last_metric /= Void end
					create l_error_msg.make (256)
					l_error_msg.append (once "No domain item defined in criterion %"")
					l_error_msg.append (a_criterion.name)
					l_error_msg.append (once "%" in metric %"")
					l_error_msg.append (last_metric.name)
					l_error_msg.append (once "%".")

					create l_to_do_msg.make (256)
					l_to_do_msg.append (once "Make sure that at least one domain item%N")
					l_to_do_msg.append (once "is listed in the criterion in trouble.")
					create_last_error_with_to_do (l_error_msg, l_to_do_msg)
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
		local
			l_error_msg: STRING
			l_to_do_msg: STRING
		do
			if not has_error then
				process_criterion (a_criterion)
			end
			if not has_error then
				if a_criterion.text.is_empty then
					check last_metric /= Void end
					create l_error_msg.make (100)
					l_error_msg.append (once "Text cannot be empty in criterion %"")
					l_error_msg.append (a_criterion.name)
					l_error_msg.append (once "%" in metric %"")
					l_error_msg.append (last_metric.name)
					l_error_msg.append (once "%".")
					create l_to_do_msg.make (100)
					l_to_do_msg.append ("Make sure to specify a non-empty string for the criterion in trouble.")
					create_last_error_with_to_do (l_error_msg, l_to_do_msg)
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
			l_error_msg: STRING
			l_to_do_msg: STRING
		do
			if not has_error then
				l_conf_group := group_of_id (a_item.id)
				if l_conf_group = Void then
					check
						last_metric /= Void
						last_criterion /= Void
					end
					create l_error_msg.make (100)
					l_error_msg.append (once "Group ")
					if last_group_name /= Void then
						l_error_msg.append (once "%"")
						l_error_msg.append (last_group_name)
						l_error_msg.append (once "%" ")
					end
					l_error_msg.append (once "(ID:")
					l_error_msg.append (a_item.id)
					l_error_msg.append (once ") is invalid in criterion %"")
					l_error_msg.append (last_criterion.name)
					l_error_msg.append (once "%" in metric %"")
					l_error_msg.append (last_metric.name)
					l_error_msg.append (once "%".")
					create l_to_do_msg.make (256)
					append_invalid_domain_item_info (l_to_do_msg)
					create_last_error_with_to_do (l_error_msg, l_to_do_msg)
				end
			end
		end

	process_folder_domain_item (a_item: EB_METRIC_FOLDER_DOMAIN_ITEM) is
			-- Process `a_item'.
			-- A folder domain item is valid if and only if:
			--		* the folder it represents exists in current system
		local
			l_folder: EB_FOLDER
			l_error_msg: STRING
			l_to_do_msg: STRING
		do
			if not has_error then
				l_folder := folder_of_id (a_item.id)
				if l_folder = Void then
					check
						last_metric /= Void
						last_criterion /= Void
					end
					create l_error_msg.make (100)
					l_error_msg.append (once "Folder ")
					if last_group_name /= Void then
						l_error_msg.append (once "%"")
						l_error_msg.append (last_folder_name)
						l_error_msg.append (once "%" ")
					end
					l_error_msg.append (once "(ID:")
					l_error_msg.append (a_item.id)
					l_error_msg.append (once ") is invalid in criterion %"")
					l_error_msg.append (last_criterion.name)
					l_error_msg.append (once "%" in metric %"")
					l_error_msg.append (last_metric.name)
					l_error_msg.append (once "%".")
					create l_to_do_msg.make (256)
					append_invalid_domain_item_info (l_to_do_msg)
					create_last_error_with_to_do (l_error_msg, l_to_do_msg)
				end
			end
		end

	process_class_domain_item (a_item: EB_METRIC_CLASS_DOMAIN_ITEM) is
			-- Process `a_item'.
			-- A class domain item is valid if and only if:
			--		* the class it represents exists in current system		
		local
			l_conf_class: CONF_CLASS
			l_error_msg: STRING
			l_to_do_msg: STRING
		do
			if not has_error then
				l_conf_class := class_of_id (a_item.id)
				if l_conf_class = Void then
					check
						last_metric /= Void
						last_criterion /= Void
					end
					create l_error_msg.make (100)
					l_error_msg.append ("Class ")
					if last_group_name /= Void then
						l_error_msg.append (once "%"")
						l_error_msg.append (last_class_name)
						l_error_msg.append (once "%" ")
					end
					l_error_msg.append (once "(ID:")
					l_error_msg.append (a_item.id)
					l_error_msg.append (once ") is invalid in criterion %"")
					l_error_msg.append (last_criterion.name)
					l_error_msg.append (once "%" in metric %"")
					l_error_msg.append (last_metric.name)
					l_error_msg.append (once "%".")
					create l_to_do_msg.make (256)
					append_invalid_domain_item_info (l_to_do_msg)
					create_last_error_with_to_do (l_error_msg, l_to_do_msg)
				end
			end
		end

	process_feature_domain_item (a_item: EB_METRIC_FEATURE_DOMAIN_ITEM) is
			-- Process `a_item'.
			-- A feature domain item is valid if and only if:
			--		* the feature it represents exists in current system
		local
			l_feature: E_FEATURE
			l_error_msg: STRING
			l_to_do_msg: STRING
		do
			if not has_error then
				l_feature := feature_of_id (a_item.id)
				if l_feature = Void then
					check
						last_metric /= Void
						last_criterion /= Void
					end
					create l_error_msg.make (100)
					l_error_msg.append ("Feature ")
					if last_group_name /= Void then
						l_error_msg.append (once "%"")
						l_error_msg.append (last_feature_name)
						l_error_msg.append (once "%" ")
					end
					l_error_msg.append (once "(ID:")
					l_error_msg.append (a_item.id)
					l_error_msg.append (once ") is invalid in criterion %"")
					l_error_msg.append (last_criterion.name)
					l_error_msg.append (once "%" in metric %"")
					l_error_msg.append (last_metric.name)
					l_error_msg.append (once "%".")
					create l_to_do_msg.make (256)
					append_invalid_domain_item_info (l_to_do_msg)
					create_last_error_with_to_do (l_error_msg, l_to_do_msg)
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
		local
			l_error_msg: STRING
			l_to_do_msg: STRING
		do
			check
				current_metric_attached: current_metric /= Void
			end
			if a_metric.name.is_equal (current_metric.name) then
				if is_current_metric_processed then
					create l_error_msg.make (100)
					l_error_msg.append (once "Recursive definition in metric %"")
					l_error_msg.append (current_metric.name)
					l_error_msg.append ("%".")
					create l_to_do_msg.make (256)
					l_to_do_msg.append (once "In linear metric, make sure that every variable metric doesn't involve %Nrecursive metric.%N")
					l_to_do_msg.append (once "In ratio metric, make sure that numerator metric or denominator metric %Ndoesn't involve recursive metric.")
					create_last_error_with_to_do (l_error_msg, l_to_do_msg)
				else
					is_current_metric_processed := True
				end
			end
		end

	is_current_metric_processed: BOOLEAN
			-- Is `current_metric' processed?
			-- Used for recursive definition detection.

	create_last_error (a_msg: STRING) is
			-- Create `last_error' with message `a_msg' and set `has_error' with True.
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
		do
			has_error := True
			create {EB_METRIC_ERROR_VADILITY} last_error.make (a_msg)
		ensure
			last_error_created: last_error /= Void
		end

	create_last_error_with_to_do (a_msg: STRING; a_to_do: STRING) is
			-- Create `last_error' with message `a_msg' and set `to_do' with `a_to_do'.
		require
			a_msg_attached: a_msg /= Void
			not_a_msg_is_empty: not a_msg.is_empty
		do
			create_last_error (a_msg)
			last_error.set_to_do (a_to_do)
		end

	last_metric: EB_METRIC
			-- Last metric been checked

	last_criterion: EB_METRIC_CRITERION
			-- Last analyzed criterion

	append_metric_name_info (a_str: STRING) is
			-- Append metric name information information to `a_str'.
		require
			a_str_attached: a_str /= Void
		do
			a_str.append (once "A valid metric name is a non-empty string %Nwhich doesn't start with%N")
			a_str.append (once "space, enter or tab, and doesn't end with space, enter or tab.%N")
		end

	append_linear_metric_info (a_str: STRING) is
			-- Append linear metric information information to `a_str'.
		require
			a_str_attached: a_str /= Void
		do
			a_str.append (once "Linear metric is in the form:%N%N")
			a_str.append (once "%Ta * metric1 + b * metric2 + c * metric3 + ...%N%N")
			a_str.append (once "a, b, c are coefficients and %N")
			a_str.append (once "metric1, metric2, metric3 are variable metrics.%N%N")
		end

	append_ratio_metric_info (a_str: STRING) is
			-- Append ratio metric information information to `a_str'.
		require
			a_str_attached: a_str /= Void
		do
			a_str.append (once "Ratio metric is in the form:%N%N")
			a_str.append (once "%TNumerator metric / Denominator metric%N%N")
			a_str.append (once "Numerator metric and denominator metric can be of any valid unit.%N%N")
		end

	append_invalid_domain_item_info (a_str: STRING) is
			-- Append invalid domain help information to `a_str'.
		require
			a_str_attached: a_str /= Void
		do
			a_str.append (once "Make sure that every item specified in a domain is valid.%N")
			a_str.append (once "Following are some reasons which can cause a domain item invalid:%N")
			a_str.append (once "%TDomain item ID is damaged or incorrect.%N")
			a_str.append (once "%TDomain item doesn't exist (Maybe due to removal/rename of a folder, group, class or feature).%N")
		end

	check_metric_name (a_name: STRING) is
			-- Check if `a_name' is a valid metric name.
		local
			l_error_msg: STRING
			l_to_do_msg: STRING
			l_first_char, l_last_char: CHARACTER
		do
			if a_name = Void or else a_name.is_empty then
				create l_error_msg.make_from_string (once "Metric name cannot be empty.")
				create l_to_do_msg.make (256)
				l_to_do_msg.append (once "Make sure metric name is not empty and contains valid charactors.")
				create_last_error_with_to_do (l_error_msg, l_to_do_msg)
			else
				l_first_char := a_name.item (1)
				if not l_first_char.is_graph then
					create l_error_msg.make_from_string (once "Metric name cannot start with space, enter, tab.")
					create l_to_do_msg.make (100)
					append_metric_name_info (l_to_do_msg)
					create_last_error_with_to_do (l_error_msg, l_to_do_msg)
				end
				if not has_error and then a_name.count > 1 then
					l_last_char := a_name.item (a_name.count)
					if not l_last_char.is_graph then
						create l_error_msg.make_from_string (once "Metric name cannot end with space, enter, tab.")
						create l_to_do_msg.make (100)
						append_metric_name_info (l_to_do_msg)
						create_last_error_with_to_do (l_error_msg, l_to_do_msg)
					end
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
