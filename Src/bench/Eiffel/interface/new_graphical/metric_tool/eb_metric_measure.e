indexing
	description: "Representation of metrics composing a composite metric%N%
				%to ease metric calculation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_MEASURE

inherit
	EB_METRIC_VALUE

	EB_CONSTANTS

create
	make

feature -- Initialization

	make (name: STRING; tl: EB_METRIC_TOOL) is
			-- Create en EB_METRIC_VALUE object that can evaluate metric of name `name'.
		require
			name_not_empty: name /= Void and then not name.is_empty
			existing_tool: tl /= Void
		do
			metric_name := name
			requested_metric ?= tl.metric (metric_name)
		ensure
			existing_metric: requested_metric /= Void
		end

feature -- Access

	metric_name: STRING
		-- Name of the metric `Current' must evaluate.

	requested_metric: EB_METRIC
		-- Metric `Current' must evaluate.

feature -- Value

	value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Result of evaluating `requested_metric' over scope `s'
		require else
			scope_not_void: s /= Void
			metric_not_void: requested_metric /= Void
		do
			Result := requested_metric.value (s)
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

end -- class EB_METRIC_MEASURE
