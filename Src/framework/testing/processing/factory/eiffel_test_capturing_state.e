indexing
	description: "[
		Objects that contain a capturing state.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_CAPTURING_STATE

feature {NONE} -- Access

	status: NATURAL
			-- Code describing status of `Current'

	idle_status_code: NATURAL = 0
	invocation_status_code: NATURAL = 1
	object_status_code: NATURAL = 2
			-- Status codes

feature -- Status report

	is_ready: BOOLEAN
			-- Is `Current' ready to retrieve application state?
		do
			Result := not is_capturing
		ensure
			result_implies_not_capturing: Result implies not is_capturing
		end

	is_capturing: BOOLEAN
			-- Is `Current' expecting any further invocations or objects?
		do
			Result := is_capturing_invocations or is_capturing_objects
		ensure
			result_implies_one_of: Result implies (is_capturing_invocations or is_capturing_objects)
		end

	is_capturing_invocations: BOOLEAN
			-- Is `Current' expecting routine invocations?
		do
			Result := status = invocation_status_code
		ensure
			result_implies_not_other: Result implies not is_capturing_objects
		end

	is_capturing_objects: BOOLEAN
			-- Is `Current' expecting further objects?
		do
			Result := status = object_status_code
		ensure
			result_implies_not_other: Result implies not is_capturing_invocations
		end

feature {NONE} -- Status setting

	frozen prepare
			-- Prepare for retrieving routine invocations.
		require
			ready: is_ready
		do
			status := invocation_status_code
			if is_capturing_invocations then
				on_prepare
			end
		end

	frozen prepare_for_objects
			-- Prepare for retrieving objects.
		require
			capturing_invocations: is_capturing_invocations
		do
			status := object_status_code
			if is_capturing_objects then
				on_prepare_for_objects
			end
		end

	frozen clean
			-- Terminate capturing and clean up any used resources.
		require
			capturing: is_capturing_objects
		do
			status := idle_status_code
			if not is_capturing then
				on_clean
			end
		end

feature {NONE} -- Events

	on_prepare
			-- Called immediatly before `prepare' returns.
		require
			capturing_invocations: is_capturing_invocations
		do
		end

	on_prepare_for_objects
			-- Called immediatly before `prepare_for_objects' returns.
		require
			capturing_objects: is_capturing_objects
		do
		end

	on_clean
			-- Called immediatly before `clean' returns.
		require
			not_capturing: not is_capturing
		do
		end

end
