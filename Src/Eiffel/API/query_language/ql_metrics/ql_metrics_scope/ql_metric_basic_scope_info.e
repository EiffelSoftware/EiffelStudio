indexing
	description: "Representation of one item in basic scope of a metric"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_METRIC_BASIC_SCOPE_INFO

inherit
	QL_SHARED_SCOPES

feature -- Access

	metric: QL_METRIC_BASIC
			-- Metric to which current basic scope belongs

	scope: QL_SCOPE is
			-- Scope
		deferred
		ensure
			result_attached: Result /= Void
		end

	calculate_function: FUNCTION [ANY, TUPLE [QL_ITEM], DOUBLE]
			-- Function to calculate metric

	domain_generator: QL_DOMAIN_GENERATOR
			-- Domain generator used to calculate metric

feature -- Status report

	is_registered_to_metric: BOOLEAN is
			-- Is current basic scope definition registered in a metric?
		do
			Result := metric /= Void
		ensure
			good_result: Result implies (metric /= Void) and (not Result implies (metric = Void))
		end

feature -- Metric registration

	set_metric (a_metric: like metric) is
			-- Set `metric' with `a_metric'.
		require
			current_not_registered: not is_registered_to_metric
		do
			metric := a_metric
		ensure
			metric_set: metric = a_metric
		end

feature{NONE} -- Implementation

	evaluate_item (a_item: QL_ITEM) is
			-- Call `calculate_function' to evaluate `a_item'.
		require
			metric_attached: metric /= Void
		deferred
		end

invariant
	scope_attached: scope /= Void
	domain_generator_attached: domain_generator /= Void
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
