indexing
	description:

		"Abstract ancestor to all interpreter requests"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class AUT_REQUEST

feature {NONE} -- Initialization

	make (a_system: like system) is
			-- Create new request.
		require
			a_system_not_void: a_system /= Void
		do
			system := a_system
		ensure
			system_set: system = a_system
		end

feature -- Status report

	has_response: BOOLEAN is
			-- Does this request have a corresponding response
			-- from the interpreter?
		do
			Result := response /= Void
		ensure
			definition: Result = (response /= Void)
		end

	is_type_request: BOOLEAN is
			-- Is Current a type request?
		do
		end

feature -- Access

	response: AUT_RESPONSE
			-- Interpreter's response to current request;
			-- Void if request is without response.

	system: SYSTEM_I
			-- system

feature -- Change

	set_response (a_response: like response) is
			-- Set `response' to `a_response'.
		require
			a_response_not_void: a_response /= Void
		do
			response := a_response
		ensure
			response_set: response = a_response
		end

	remove_response is
			-- Set `response' to Void.
		do
			response := Void
		ensure
			response_set: response = Void
		end

feature -- Processing

	process (a_processor: AUT_REQUEST_PROCESSOR) is
			-- Process current request.
		require
			a_processor_not_void: a_processor /= Void
		deferred
		end

feature -- Duplication

	fresh_twin: like Current is
			-- New request equal to `Current', but no response.
			-- Ready to be used for testing again.
		do
			Result := twin
			Result.remove_response
		ensure
			fresh_twin_not_void: Result /= Void
		end

invariant

	system_not_void: system /= Void

end
