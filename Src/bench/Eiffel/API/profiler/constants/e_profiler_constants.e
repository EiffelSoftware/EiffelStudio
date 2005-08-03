indexing
	description: "Objects that provide access to constants used in profiling."
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
	
	profiler_cycle: STRING is "cycle"

end
