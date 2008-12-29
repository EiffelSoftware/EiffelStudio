note
	description: "Visitor to rename metrics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_RENAME_VISITOR

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

	make (a_old_name, a_new_name: STRING)
			-- Initialize `old_metric_name' with `a_old_name' and
			-- `new_metric_name' with `a_new_name'.
		require
			a_old_name_attached: a_old_name /= Void
			a_new_name_attached: a_new_name /= Void
		do
			old_metric_name := a_old_name.twin
			new_metric_name := a_new_name.twin
		ensure
			old_metric_name_set: old_metric_name /= Void and then old_metric_name.is_equal (a_old_name)
			new_metric_name_set: new_metric_name /= Void and then new_metric_name.is_equal (a_new_name)
		end

feature -- Process

	process_metric (a_metric: EB_METRIC)
			-- Process `a_metric'.
		require
			a_metric_attached: a_metric /= Void
		do
			replace_name (a_metric.name, agent a_metric.set_name)
			a_metric.process (Current)
		end

feature -- Access

	old_metric_name: STRING
			-- Old metric name

	new_metric_name: STRING
			-- New metric name

feature{NONE} -- Process

	process_linear_metric (a_linear_metric: EB_METRIC_LINEAR)
			-- Process `a_linear_metric'.
		local
			l_variable_metric: LIST [STRING]
			l_cursor: CURSOR
		do
			l_variable_metric := a_linear_metric.variable_metric
			if not l_variable_metric.is_empty then
				l_cursor := l_variable_metric.cursor
				from
					l_variable_metric.start
				until
					l_variable_metric.after
				loop
					replace_name (l_variable_metric.item, agent l_variable_metric.replace)
					l_variable_metric.forth
				end
				l_variable_metric.go_to (l_cursor)
			end
		end

	process_ratio_metric (a_ratio_metric: EB_METRIC_RATIO)
			-- Process `a_ratio_metric'.
		do
			replace_name (a_ratio_metric.numerator_metric_name, agent a_ratio_metric.set_numerator_metric_name)
			replace_name (a_ratio_metric.denominator_metric_name, agent a_ratio_metric.set_denominator_metric_name)
		end

	process_value_criterion (a_criterion: EB_METRIC_VALUE_CRITERION)
			-- Process `a_criterion'.
		do
			replace_name (a_criterion.metric_name, agent a_criterion.set_metric_name)
		end

	process_metric_value_retriever (a_item: EB_METRIC_METRIC_VALUE_RETRIEVER)
			-- Process `a_item'.
		do
			replace_name (a_item.metric_name, agent a_item.set_metric_name)
		end

feature{NONE} -- Implementation

	replace_name (a_old_name: STRING; a_name_setter: PROCEDURE [ANY, TUPLE [STRING]])
			-- If `a_old_name' is considered to be the same as `old_metric_name',
			-- invoke `a_name_setter' to set `new_metric_name'.
		require
			a_old_name_attached: a_old_name /= Void
			a_name_setter_attached: a_name_setter /= Void
		do
			if a_old_name.is_case_insensitive_equal (old_metric_name) then
				a_name_setter.call ([new_metric_name.twin])
			end
		end

invariant
	old_metric_name_attached: old_metric_name /= Void
	new_metric_name_attached: new_metric_name /= Void

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
