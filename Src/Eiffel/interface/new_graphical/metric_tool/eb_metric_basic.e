note
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
			is_basic
		end

	QL_SHARED

create
	make

feature -- Status report

	is_result_domain_available: BOOLEAN
			-- After metric calculation, can we get the last generated domain
			-- for detail display?
		do
			Result := unit.scope /= Void
		end

	is_basic: BOOLEAN = True
			-- Is current a basic metric?

feature -- Metric calculation

	value (a_scope: EB_METRIC_DOMAIN): QL_QUANTITY_DOMAIN
			-- Value of current metric calculated over `a_scope'
		local
			l_dummy_domain: QL_DOMAIN
			l_metric: QL_METRIC
			l_has_delayed_input_domain: BOOLEAN
			l_helper: EB_METRIC_COMPONENT_HELPER
			l_cri: QL_CRITERION
		do
			create {QL_TARGET_DOMAIN} l_dummy_domain.make
			last_result_domain := Void
			internal_value := 0.0

			create l_helper
			l_helper.prepare_for_calculation (Current)
			l_has_delayed_input_domain := l_helper.component_has_delayed_input_domain_item (Current)

			l_metric := metric
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
				l_helper.replace_delayed_input_domain (Current, a_scope)
				l_metric.set_criterion (evaluated_criteria (criteria))
				calculate_domain (l_metric, current_application_target_domain)
				l_helper.replace_delayed_input_domain (Current, Void)
			end
			create Result.make
			Result.extend (create{QL_QUANTITY}.make_with_value (internal_value))
		end

	criteria: EB_METRIC_CRITERION
			-- List of criterion

feature -- Setting

	set_criteria (a_criteria: like criteria)
			-- Set `criteria' with `a_criteria'.
		do
			criteria := a_criteria
		ensure
			criteria_set: criteria = a_criteria
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_basic_metric (Current)
		end

feature{NONE} -- Implementation

	metric: QL_METRIC
			-- Query language metric used to calculation result
		do
			Result := metric_factory.metric (unit)
		ensure
			result_attached: Result /= Void
		end

	internal_value: DOUBLE
			-- Internal value used when current metric is being calculated

	calculate_domain (a_metric: QL_METRIC; a_domain: QL_DOMAIN)
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
			if is_fill_domain_enabled and then a_metric.unit.scope /= Void then
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

	evaluated_criteria (a_criteria: like criteria): QL_CRITERION
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

	current_application_target_domain: QL_TARGET_DOMAIN
			-- Current application target domain
		do
			create Result.make
			Result.extend (create{QL_TARGET}.make (universe.target))
		ensure
			result_attached: Result /= Void
		end

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
