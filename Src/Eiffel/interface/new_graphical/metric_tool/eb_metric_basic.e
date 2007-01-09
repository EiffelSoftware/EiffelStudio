indexing
	description: "Basic metric used in EiffelStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_BASIC

inherit
	EB_METRIC
		redefine
			is_basic,
			is_just_line_counting
		end

	QL_SHARED

	EB_METRIC_VISITOR

create
	make

feature -- Status report

	is_result_domain_available: BOOLEAN is
			-- After metric calculation, can we get the last generated domain
			-- for detail display?
		do
			Result := unit.scope /= Void
		end

	is_basic: BOOLEAN is True
			-- Is current a basic metric?

	is_just_line_counting: BOOLEAN is
			-- Is current metric a line counting metric?
		do
			Result := criteria = Void
		end

feature -- Access

	direct_referenced_metrics: LIST [STRING] is
			-- Name of metrics which are directly referenced by Current
		do
			create {LINKED_LIST [STRING]} referenced_metrics.make
			criteria.process (Current)
			Result := referenced_metrics
		end

feature -- Metric calculation

	value (a_scope: EB_METRIC_DOMAIN): QL_QUANTITY_DOMAIN is
			-- Value of current metric calculated over `a_scope'
		local
			l_cri: like evaluated_criteria
			l_dummy_domain: QL_DOMAIN
			l_metric: QL_METRIC
			l_has_delayed_input_domain: BOOLEAN
			l_metric_cri: like criteria
		do
			create {QL_TARGET_DOMAIN} l_dummy_domain.make
			last_result_domain := Void
			internal_value := 0.0
			l_metric := metric
			l_has_delayed_input_domain := criteria /= Void and then criteria.has_delayed_input_domain

			if not l_has_delayed_input_domain or else criteria = Void then
				l_cri := evaluated_criteria (criteria)
				if l_cri /= Void then
					l_metric.set_criterion (l_cri)
				end
				from
					a_scope.start
				until
					a_scope.after
				loop
					if unit.scope /= Void then
						calculate_domain (l_metric, a_scope.item_domain (unit.scope))
					else
						calculate_domain (l_metric, l_dummy_domain)
					end
					a_scope.forth
				end
			else
				l_metric_cri := criteria.twin
				l_metric_cri.replace_delayed_input_domain (a_scope)
				l_metric.set_criterion (evaluated_criteria (l_metric_cri))
				calculate_domain (l_metric, current_application_target_domain)
			end
			create Result.make
			Result.extend (create{QL_QUANTITY}.make_with_value (internal_value))
		end

	criteria: EB_METRIC_CRITERION
			-- List of criterion

feature -- Setting

	set_criteria (a_criteria: like criteria) is
			-- Set `criteria' with `a_criteria'.
		do
			criteria := a_criteria
		ensure
			criteria_set: criteria = a_criteria
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR) is
			-- Process current using `a_visitor'.
		do
			a_visitor.process_basic_metric (Current)
		end

feature{NONE} -- Implementation

	metric: QL_METRIC is
			-- Query language metric used to calculation result
		do
			Result := metric_factory.metric (unit)
		ensure
			result_attached: Result /= Void
		end

	internal_value: DOUBLE
			-- Internal value used when current metric is being calculated

	calculate_domain (a_metric: QL_METRIC; a_domain: QL_DOMAIN) is
			-- Calculate `a_metric' value for `a_domain'.
			-- Added calculated value into `internal_value'.
			-- If `is_fill_domain_enabled' store generated domain into `last_result_domain'.
		require
			a_metric_attached: a_metric /= Void
			a_domain_attached: a_domain /= Void
		do
			if is_fill_domain_enabled then
				a_metric.enable_fill_domain
			else
				a_metric.disable_fill_domain
			end
			internal_value := internal_value + a_metric.value (a_domain).first.value
			if is_fill_domain_enabled then
				check
					a_metric.last_domain /= Void
				end
				if last_result_domain = Void then
					last_result_domain := a_metric.last_domain.twin
				else
					last_result_domain := last_result_domain.union (a_metric.last_domain)
				end
			end
		end

	evaluated_criteria (a_criteria: like criteria): QL_CRITERION is
			-- Evaluated query language criterion from `criteria'
		local
			l_scope: QL_SCOPE
			l_cri: QL_CRITERION
		do
			if a_criteria /= Void then
				Result := a_criteria.new_criterion (unit.scope)
				if Result /= Void then
					l_scope := Result.scope
					if should_result_be_filtered and then l_scope.is_code_structure_scope then
						l_cri := criterion_factory_table.item (l_scope).criterion_with_name ("is_visible", [])
						if l_cri /= Void then
							Result := Result and l_cri
						end
					end
				end
			end
		end

	current_application_target_domain: QL_TARGET_DOMAIN is
			-- Current application target domain
		do
			create Result.make
			Result.extend (create{QL_TARGET}.make (universe.target))
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Visitor/Referenced metrics checking

	referenced_metrics: LIST [STRING]
			-- List of directed referenced metrics by current

	process_basic_metric (a_basic_metric: EB_METRIC_BASIC) is
			-- Process `a_basic_metric'.
		do
		end

	process_linear_metric (a_linear_metric: EB_METRIC_LINEAR) is
			-- Process `a_linear_metric'.
		do
		end

	process_ratio_metric (a_ratio_metric: EB_METRIC_RATIO) is
			-- Process `a_ratio_metric'.
		do
		end

	process_criterion (a_criterion: EB_METRIC_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_domain_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_caller_callee_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_supplier_client_criterion (a_criterion: EB_METRIC_SUPPLIER_CLIENT_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_text_criterion (a_criterion: EB_METRIC_TEXT_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_path_criterion (a_criterion: EB_METRIC_PATH_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_normal_criterion (a_criterion: EB_METRIC_NORMAL_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_value_criterion (a_criterion: EB_METRIC_VALUE_CRITERION) is
			-- Process `a_criterion'.
		do
			check referenced_metrics /= Void end
			referenced_metrics.extend (a_criterion.metric_name)
		end

	process_nary_criterion (a_criterion: EB_METRIC_NARY_CRITERION) is
			-- Process `a_criterion'.
		do
			process_list (a_criterion.operands)
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

	process_domain (a_domain: EB_METRIC_DOMAIN) is
			-- Process `a_domain'.
		do
		end

	process_domain_item (a_item: EB_METRIC_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_application_target_domain_item (a_item: EB_METRIC_TARGET_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_group_domain_item (a_item: EB_METRIC_GROUP_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_folder_domain_item (a_item: EB_METRIC_FOLDER_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_class_domain_item (a_item: EB_METRIC_CLASS_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_feature_domain_item (a_item: EB_METRIC_FEATURE_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_delayed_domain_item (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_metric_archive_node (a_item: EB_METRIC_ARCHIVE_NODE) is
			-- Process `a_item'.
		do
		end

	process_value_tester (a_item: EB_METRIC_VALUE_TESTER) is
			-- Process `a_item'.
		do
		end

	process_constant_value_retriever (a_item: EB_METRIC_CONSTANT_VALUE_RETRIEVER) is
			-- Process `a_item'.
		do
		end

	process_metric_value_retriever (a_item: EB_METRIC_METRIC_VALUE_RETRIEVER) is
			-- Process `a_item'.
		do
			check referenced_metrics /= Void end
			referenced_metrics.extend (a_item.metric_name)
		end

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
