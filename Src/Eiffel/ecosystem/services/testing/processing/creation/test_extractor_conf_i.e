indexing
	description: "Summary description for {TEST_EXTRACTOR_CONF_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_EXTRACTOR_CONF_I

inherit
	TEST_CREATOR_CONF_I

feature -- Access

	call_stack_elements: !DS_LINEAR [INTEGER]
			-- Indices of call stack elements to be captured
			--
			-- Note: Since debugger classes can currently not be referenced in the ecosystem framework, we
			--       use indices here instead of the actual {EIFFEL_CALL_STACK_ELEMENT} instances.
		deferred
		end

end
