indexing
	description: "[
		Creates tests from a current application state
		
		This will be the CDD part of the testing service.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_EXTRACTOR_I

inherit
	EIFFEL_TEST_FACTORY_I [!EIFFEL_TEST_EXTRACTOR_CONFIGURATION_I]
	
feature -- Query

	is_valid_call_stack_element (a_index: INTEGER): BOOLEAN
			-- Is call stack element valid for extraction?
			--
			--| Note: currently no debugger code can be referenced in ecosystem classes, so this design
			--| is quite loose.
		require
			usable: is_interface_usable
		deferred
		end

	is_valid_typed_argument (a_arg: like configuration; a_test_suite: like test_suite): BOOLEAN
			-- <Precursor>
		deferred
		ensure then
			result_implies_valid_elements: Result implies
				a_arg.call_stack_elements.for_all (agent is_valid_call_stack_element)
		end

end
