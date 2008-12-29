note
	description: "Visitor used to find referenced metrics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_REFERENCED_METRIC_VISITOR

inherit
	EB_METRIC_ITERATOR
		redefine
			process_linear_metric,
			process_ratio_metric,
			process_value_criterion,
			process_metric_value_retriever
		end

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize.
		do
			create {LINKED_LIST [STRING]} referenced_metric_name.make
			referenced_metric_name.compare_objects
		end

feature -- Referenced metric searching

	search_referenced_metric (a_item: EB_METRIC_VISITABLE)
			-- Search `a_item' for referenced metrics and
			-- store names of found referenced metrics in `referenced_metric_names'.
		require
			a_item_attached: a_item /= Void
		do
			referenced_metric_name.wipe_out
		end

feature -- Access

	referenced_metric_name: LIST [STRING]
			-- List of found referenced metric name

feature -- Process

	process_linear_metric (a_linear_metric: EB_METRIC_LINEAR)
			-- Process `a_linear_metric'.
		local
			l_var_metrics: LIST [STRING]
		do
			l_var_metrics := a_linear_metric.variable_metric
			from
				l_var_metrics.start
			until
				l_var_metrics.after
			loop
				insert_referenced_metric (l_var_metrics.item)
				l_var_metrics.forth
			end
		end

	process_ratio_metric (a_ratio_metric: EB_METRIC_RATIO)
			-- Process `a_ratio_metric'.
		do
			insert_referenced_metric (a_ratio_metric.numerator_metric_name)
			insert_referenced_metric (a_ratio_metric.denominator_metric_name)
		end

	process_value_criterion (a_criterion: EB_METRIC_VALUE_CRITERION)
			-- Process `a_criterion'.
		do
			insert_referenced_metric (a_criterion.metric_name)
			a_criterion.value_tester.process (Current)
		end

	process_metric_value_retriever (a_item: EB_METRIC_METRIC_VALUE_RETRIEVER)
			-- Process `a_item'.
		do
			insert_referenced_metric (a_item.metric_name)
		end

	insert_referenced_metric (a_metric_name: STRING)
			-- Insert `a_metric_name' into `referenced_metric_name'
			-- if `a_metric_name' is not contained in `reference_metric_name'.
		require
			a_metric_name_attached: a_metric_name /= Void
		do
			if not referenced_metric_name.has (a_metric_name) then
				referenced_metric_name.extend (a_metric_name)
			end
		end

invariant
	referenced_metric_name_attached: referenced_metric_name /= Void

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
