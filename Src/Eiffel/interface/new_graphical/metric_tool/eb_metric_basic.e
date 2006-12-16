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

	QL_METRIC_FACTORY
		rename
			metric as ql_metric
		end

	QL_CRITERION_ITERATOR
		export
			{NONE} all
		redefine
			process_intrinsic_domain_criterion,
			process_domain_criterion
		end

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
			create {LINKED_LIST [STRING]} Result.make
		end

feature -- Metric calculation

	value (a_scope: EB_METRIC_DOMAIN): QL_QUANTITY_DOMAIN is
			-- Calcualte current domain using `a_scope'.
		local
			l_cri: like evaluated_criteria
			l_dummy_domain: QL_DOMAIN
			l_metric: QL_METRIC
			l_has_delayed_domain: BOOLEAN
			l_criterion_set: BOOLEAN
		do
			create {QL_TARGET_DOMAIN} l_dummy_domain.make
			last_result_domain := Void
			internal_value := 0.0

			l_metric := metric
			evaluated_criteria_internal := Void
			l_cri := evaluated_criteria
			if l_cri /= Void then
				l_metric.set_criterion (l_cri)
			end
			l_has_delayed_domain := l_metric.has_delayed_domain
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
				if l_has_delayed_domain then
					l_metric := metric
					evaluated_criteria_internal := Void
					l_cri := evaluated_criteria
					if l_cri /= Void then
						l_metric.set_criterion (l_cri)
					end
				end
				a_scope.forth
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
			evaluated_criteria_internal := Void
		ensure
			criteria_set: criteria = a_criteria
			evaluated_criteria_internal_set: evaluated_criteria_internal = Void
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
			Result := ql_metric (unit)
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
			if a_metric.has_delayed_domain then
				a_metric.replace_delayed_domain_by (a_domain)
				internal_value := internal_value + a_metric.value (current_application_target_domain).first.value
			else
				internal_value := internal_value + a_metric.value (a_domain).first.value
			end
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

	evaluated_criteria: QL_CRITERION is
			-- Evaluated query language criterion from `criteria'
		local
			l_scope: QL_SCOPE
			l_cri: QL_CRITERION
		do
			if evaluated_criteria_internal = Void then
				if criteria /= Void then
					evaluated_criteria_internal := criteria.new_criterion (unit.scope)
					if evaluated_criteria_internal /= Void then
						l_scope := evaluated_criteria_internal.scope
						if should_result_be_filtered and then l_scope.is_code_structure_scope then
							l_cri := criterion_factory_table.item (l_scope).criterion_with_name ("is_visible", [])
							if l_cri /= Void then
								evaluated_criteria_internal := evaluated_criteria_internal and l_cri
							end
						end
					end
				end
			end
			Result := evaluated_criteria_internal
		end

	evaluated_criteria_internal: like evaluated_criteria
			-- Implementation of `evaluate_criteria'

feature{NONE} -- Visitor

	real_domain: QL_DOMAIN
			-- Real domain which will replace those delayed domain in given criterion

	process_intrinsic_domain_criterion (a_cri: QL_INTRINSIC_DOMAIN_CRITERION) is
			-- Process `a_cri'.
		do
			process_domain_criterion (a_cri)
		end

	process_domain_criterion (a_cri: QL_DOMAIN_CRITERION) is
			-- Process `a_cri'.
		do
			if a_cri.criterion_domain /= Void and then real_domain /= Void then
				a_cri.set_criterion_domain (real_domain)
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
