indexing
	description: "AutoTest request processor"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_REQUEST_PROCESSORS

inherit
	AUT_REQUEST_PROCESSOR
		undefine
			is_equal,
			copy
		end

	LINKED_LIST [AUT_REQUEST_PROCESSOR]

create
	make

feature {AUT_REQUEST} -- Processing

	process_start_request (a_request: AUT_START_REQUEST) is
			-- Process `a_request'.
		do
			do_all (agent a_request.process (?))
		end

	process_stop_request (a_request: AUT_STOP_REQUEST) is
			-- Process `a_request'.
		do
			do_all (agent a_request.process (?))
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST) is
			-- Process `a_request'.
		do
			do_all (agent a_request.process (?))
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST) is
			-- Process `a_request'.
		do
			do_all (agent a_request.process (?))
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST) is
			-- Process `a_request'.
		do
			do_all (agent a_request.process (?))
		end

	process_type_request (a_request: AUT_TYPE_REQUEST) is
			-- Process `a_request'.
		do
			do_all (agent a_request.process (?))
		end

end
