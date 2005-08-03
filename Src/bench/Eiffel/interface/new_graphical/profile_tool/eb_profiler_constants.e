indexing
	description: "Objects that provide access to constants used in profiling."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILER_CONSTANTS

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

end
