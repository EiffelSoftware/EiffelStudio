note
	description: "Summary description for {TEST_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HANDLER

inherit
	STRING_TRACING_HANDLER

feature

	trace (a_type: TYPE [detachable ANY]; a_class_name, a_feature_name: detachable STRING; a_depth: INTEGER; a_is_entering: BOOLEAN)
			-- Trigger a trace operation from a feature represented by `a_feature_name' defined in
			-- class `a_class_name' and applied to an object of type `a_type' at a call depth `a_depth'.
			-- If `a_is_entering' we are entering the routine, otherwise we are exiting it.	
		local
			l_mem: MEMORY
		do
			create l_mem
			l_mem.collect
		end

end
