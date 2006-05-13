indexing
	description: "Object to generate quantity domains used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_QUANTITY_DOMAIN_GENERATOR

inherit
	QL_DOMAIN_GENERATOR
		redefine
			criterion,
			domain,
			item_type
		end

feature -- Access

	criterion: QL_QUANTITY_CRITERION
			-- Criterion used when generating new items

	domain: QL_QUANTITY_DOMAIN is
			-- Generated domain
		do
			if internal_domain = Void then
				create internal_domain.make
			end
			Result := internal_domain
		ensure then
			result_set: Result = internal_domain
		end

	scope: QL_SCOPE is
			-- Scope of current generator
		do
			Result := quantity_scope
		ensure then
			good_result: Result = quantity_scope
		end

	metric: QL_METRIC
			-- Metric used to calculate quantity value for every item in `domain'
			-- If `metric' is Void, a 0 will become default value.

feature -- Setting

	set_metric (a_metric: like metric) is
			-- Set `metric' with `a_metric'.
		require
			a_metric_attached: a_metric /= Void
		do
			metric := a_metric
		ensure
			metric_set: metric = a_metric
		end

feature -- Process

	process_target (a_item: QL_TARGET) is
			-- Process `a_item'.
		do
			calculate_item (a_item)
		end

	process_group (a_item: QL_GROUP) is
			-- Process `a_item'.
		do
			calculate_item (a_item)
		end

	process_class (a_item: QL_CLASS) is
			-- Process `a_item'.
		do
			calculate_item (a_item)
		end

	process_feature (a_item: QL_FEATURE) is
			-- Process `a_item'.
		do
			calculate_item (a_item)
		end

	process_real_feature (a_item: QL_REAL_FEATURE) is
			-- Process `a_item'.
		do
			calculate_item (a_item)
		end

	process_invariant (a_item: QL_INVARIANT) is
			-- Process `a_item'.
		do
			calculate_item (a_item)
		end

	process_quantity (a_item: QL_QUANTITY) is
			-- Process `a_item'.
		do
			evaluate_item (a_item)
		end

	process_line (a_item: QL_LINE) is
			-- Process `a_item'.
		do
			calculate_item (a_item)
		end

	process_generic (a_item: QL_GENERIC) is
			-- Process `a_item'.
		do
			calculate_item (a_item)
		end

	process_local (a_item: QL_LOCAL) is
			-- Process `a_item'.
		do
			calculate_item (a_item)
		end

	process_argument (a_item: QL_ARGUMENT) is
			-- Process `a_item'.
		do
			calculate_item (a_item)
		end

	process_assertion (a_item: QL_ASSERTION) is
			-- Process `a_item'.
		do
			calculate_item (a_item)
		end

feature{NONE} -- Implementation

	tautology_criterion: like criterion is
			-- Tautology criterion
		do
			create {QL_QUANTITY_TRUE_CRI}Result
		end

	compiled_criterion: like criterion is
			-- A criterion that only compiled items can satisfy
		do
			create {QL_QUANTITY_IS_COMPILED_CRI}Result
		end

	calculate_item (a_item: QL_ITEM) is
			-- Calculate metric value for `a_item' using `metric',
			-- and then invoke `evaluate_item'.
		do
			if metric /= Void then
				evaluate_item (metric.value (a_item.wrapped_domain).first)
			else
				evaluate_item (create{QL_QUANTITY}.make_with_value (0))
			end
		end

feature{NONE} -- Observable

	item_type: QL_QUANTITY;
			-- Anchor type for items of generated domain

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
