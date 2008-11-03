indexing
	description: "[
		Interface of an registrar for test processors
		
		Processors can be registrared or unregistered based on their type. Clients can then query for a
		certain processor providing a type.
		
		Add and remove events are observable so clients can be notified when a new item is available or
		beeing disposed.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_PROCESSOR_REGISTRAR_I

inherit
	USABLE_I

feature -- Access

	processor_instances (a_test_suite: !EIFFEL_TEST_SUITE_S): !DS_LINEAR [!EIFFEL_TEST_PROCESSOR_I]
			-- Registered processors for `a_test_suite'.
		require
			usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = processor_instances (a_test_suite)
			processors_valid: Result.for_all (agent (a_p: !EIFFEL_TEST_PROCESSOR_I; a_ts: !EIFFEL_TEST_SUITE_S): BOOLEAN
				do
					if a_p.is_interface_usable then
						Result := a_p.test_suite = a_ts
					end
				end (?, a_test_suite))
		end

feature -- Status report

	is_registered (a_processor: !EIFFEL_TEST_PROCESSOR_I): BOOLEAN
			-- Is processor registered?
			--
			-- `a_processor': Eiffel test processor instance.
			-- `Result': True if processor is registered, False otherwise.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_implies_processors_has_a_processor: Result implies
				processor_instances (a_processor.test_suite).has (a_processor)
		end

feature -- Query

	is_valid_type (a_type: !TYPE [EIFFEL_TEST_PROCESSOR_I]; a_test_suite: !EIFFEL_TEST_SUITE_S): BOOLEAN
			-- Is processor for `a_type' available?
		require
			usable: is_interface_usable
		deferred
		end

	processor (a_type: !TYPE [EIFFEL_TEST_PROCESSOR_I]; a_test_suite: !EIFFEL_TEST_SUITE_S): !EIFFEL_TEST_PROCESSOR_I
			-- Processor registered for type.
			--
			-- `a_type': Type requested processor conforms to.
			-- `Result': Conforming processor registered under `a_type'.
		require
			is_interface_usable: is_interface_usable
			a_type_is_registered: is_valid_type (a_type, a_test_suite)
		deferred
		ensure
			result_usable: Result.is_interface_usable
			result_conforms: a_type.attempt (Result) /= Void
			result_consistent: Result = processor (a_type, a_test_suite)
			instances_has_result: processor_instances (Result.test_suite).has (Result)
		end

	is_valid_processor (a_processor: !EIFFEL_TEST_PROCESSOR_I): BOOLEAN
			-- Can processor be registered?
			--
			-- `a_processor': Processor to be registered.
			-- `Result': True if `a_processor' can be registered, False otherwise.
		require
			usable: is_interface_usable
		deferred
		end

feature -- Element change

	register (a_processor: !EIFFEL_TEST_PROCESSOR_I) is
			-- Register processor associated with type.
			--
			-- `a_processor': Processor to be registered.
			-- `a_type': Type under which processor shall be registered and conforms to.
		require
			is_interface_usable: is_interface_usable
			a_processor_valid: is_valid_processor (a_processor)
			a_processor_not_registered: not is_registered (a_processor)
		deferred
		ensure
			is_registered: is_registered (a_processor)
		end

	unregister (a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- Unregister processor associated with type.
			--
			-- `a_type': Type processor is registered with.
		require
			is_interface_usable: is_interface_usable
			is_registered: is_registered (a_processor)
			a_processor_not_running: not a_processor.is_running
		deferred
		ensure
			not_is_registered: not is_registered (a_processor)
		end

end
