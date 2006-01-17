indexing
	description: "Objects that provide access to constants used in profiling."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	E_PROFILER_CONSTANTS

feature -- Access

	profiler_and: STRING is "and"
	
	profiler_or: STRING is "or"
	
	profiler_feature_name: STRING is "featurename"
	
	profiler_calls: STRING is "calls"
	
	profiler_self: STRING is "self"
	
	profiler_descendants: STRING is "descendants"
	
	profiler_total: STRING is "total"
	
	profiler_percentage : STRING is "percentage"
	
	profiler_c_functions: STRING is "C Functions"
	
	profiler_cyclic_functions: STRING is "Cyclic Functions"
	
	profiler_eiffel_features: STRING is "Eiffel Features"
	
	profiler_expand_all: STRING is "Expand All"
	
	profiler_collapse_all: STRING is "Collapse All"
	
	profiler_end_of_query: STRING is "EOQ"
	
	profiler_in: STRING is "in"
	
	profiler_less_than_or_equal: STRING is "<="
	
	profiler_greater_than_or_equal: STRING is ">="
	
	profiler_not_equal: STRING is "/="
	
	profiler_min: STRING is "min"
	
	profiler_max: STRING is "max"
	
	profiler_avg: STRING is "avg"
	
	profiler_spaced_and: STRING is " and "
	
	profiler_spaced_or: STRING is " or "
	
	profiler_eiffel: STRING is "eiffel"
	
	profiler_c: STRING is "c"
	
	profiler_cycle: STRING is "cycle";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
