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
			make,
			is_basic
		end

	QL_METRIC_FACTORY
		rename
			metric as ql_metric
		end

create
	make

feature{NONE} -- Initialization

	make (a_name: STRING; a_unit: like unit) is
			-- Initialize `name' with `a_name', `unit' with `a_unit'.
		do
			Precursor (a_name, a_unit)
		end

feature -- Status report

	is_result_domain_available: BOOLEAN is
			-- After metric calculation, can we get the last generated domain
			-- for detail display?
		do
			Result := unit.scope /= Void
		end

	is_basic: BOOLEAN is True
			-- Is current a basic metric?

feature -- Metric calculation

	value (a_scope: EB_METRIC_DOMAIN): QL_QUANTITY_DOMAIN is
			-- Calcualte current domain using `a_scope'.
		local
			l_cri: like evaluated_criteria
			l_dummy_domain: QL_DOMAIN
		do
			create {QL_TARGET_DOMAIN} l_dummy_domain.make
			last_result_domain := Void
			internal_value := 0.0
			metric.remove_criteria
			l_cri := evaluated_criteria
			if l_cri /= Void then
				metric.set_criterion (l_cri)
			end
			from
				a_scope.start
			until
				a_scope.after
			loop
				if unit.scope /= Void then
					calculate_domain (a_scope.item_domain (unit.scope))
				else
					calculate_domain (l_dummy_domain)
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
			if metric_internal = Void then
				metric_internal := ql_metric (unit)
			end
			Result := metric_internal
		ensure
			result_attached: Result /= Void
		end

	metric_internal: like metric
			-- Implementation of `metric'

	internal_value: DOUBLE
			-- Internal value used when current metric is being calculated

	calculate_domain (a_domain: QL_DOMAIN) is
			-- Calculate metric value for `a_domain'.
			-- Added calculated value into `internal_value'.
			-- If `is_fill_domain_enabled' store generated domain into `last_result_domain'.
		require
			a_domain_attached: a_domain /= Void
		do
			if is_fill_domain_enabled then
				metric.enable_fill_domain
			else
				metric.disable_fill_domain
			end
			internal_value := internal_value + metric.value (a_domain).first.value
			if is_fill_domain_enabled then
				check
					metric.last_domain /= Void
				end
				if last_result_domain = Void then
					last_result_domain := metric.last_domain.twin
				else
					last_result_domain := last_result_domain.union (metric.last_domain)
				end
			end
		end

	evaluated_criteria: QL_CRITERION is
			-- Evaluated query language criterion from `criteria'
		do
			if evaluated_criteria_internal = Void then
				if criteria /= Void then
					evaluated_criteria_internal := criteria.new_criterion (unit.scope)
				end
			end
			Result := evaluated_criteria_internal
		end

	evaluated_criteria_internal: like evaluated_criteria
			-- Implementation of `evaluate_criteria'

invariant
	metric_attached: metric /= Void

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
