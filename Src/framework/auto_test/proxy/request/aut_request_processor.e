indexing
	description:

		"Request processors"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class AUT_REQUEST_PROCESSOR

inherit
	REFACTORING_HELPER

feature{AUT_REQUEST} -- Status report

	is_request_valid (a_request: AUT_REQUEST): BOOLEAN is
			-- Is `a_request' valid?
		require
			a_request_attached: a_request /= Void
		do
			Result := True
		end

feature{AUT_REQUEST} -- Processing

	process_start_request (a_request: AUT_START_REQUEST) is
			-- Process `a_request'.
		require
			a_request_not_void: a_request /= Void
			a_request_is_valid: is_request_valid (a_request)
		deferred
		end

	process_stop_request (a_request: AUT_STOP_REQUEST) is
			-- Process `a_request'.
		require
			a_request_not_void: a_request /= Void
			a_request_is_valid: is_request_valid (a_request)
		deferred
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST) is
			-- Process `a_request'.
		require
			a_request_not_void: a_request /= Void
			a_request_is_valid: is_request_valid (a_request)
		deferred
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST) is
			-- Process `a_request'.
		require
			a_request_not_void: a_request /= Void
			a_request_is_valid: is_request_valid (a_request)
		deferred
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST) is
			-- Process `a_request'.
		require
			a_request_not_void: a_request /= Void
			a_request_is_valid: is_request_valid (a_request)
		deferred
		end

	process_type_request (a_request: AUT_TYPE_REQUEST) is
			-- Process `a_request'.
		require
			a_request_not_void: a_request /= Void
			a_request_is_valid: is_request_valid (a_request)
		deferred
		end

end
