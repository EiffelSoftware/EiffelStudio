indexing
	description: "[
		Object that observer the capturing of an application state.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CAPTURE_OBSERVER

inherit
	TEST_CAPTURING_STATE
		export
			{TEST_CAPTURER} prepare, prepare_for_objects, clean
		end

feature {TEST_CAPTURER} -- Events

	on_invocation_capture (a_stack_element: !TEST_CAPTURED_STACK_ELEMENT)
			-- Called when new invocation has been captured.
			--
			-- `a_stack_element': Stack element containing information about routine invocation.
		require
			capturing_invocations: is_capturing_invocations
		do
		end

	on_object_capture (a_object: !TEST_CAPTURED_OBJECT)
			-- Called when new object has been captured.
			--
			-- `a_object': Object containing information about captured class instance.
		require
			capturing_objects: is_capturing_objects
		do
		end

end
