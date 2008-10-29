indexing

	description:

		"[
		  Tests whether a request influences any of a set of variables.
		 ]"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_REQUEST_RELEVANCY_TESTER

inherit

	AUT_REQUEST_PROCESSOR

create

	make

feature {NONE} -- Initialization

	make (a_variables: like variables) is
			-- Create new strategy.
		require
			a_variables_not_void: a_variables /= Void
			no_variable_void: not a_variables.has (Void)
		do
			variables := a_variables
		ensure
			variables_set: variables = a_variables
		end

feature -- Access

	variables: DS_HASH_SET [ITP_VARIABLE]
			-- Set of relevant variables

	is_relevant: BOOLEAN
			-- Was the last request checked relevant?

feature {AUT_REQUEST} -- Processing

	process_start_request (a_request: AUT_START_REQUEST) is
		do
			is_relevant := False
		end

	process_stop_request (a_request: AUT_STOP_REQUEST) is
		do
			is_relevant := False
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST) is
		do
			is_relevant := variables.has (a_request.target)
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST) is
		do
			is_relevant := variables.has (a_request.target) or
							(a_request.receiver /= Void and then variables.has (a_request.receiver))
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST) is
		do
			is_relevant := variables.has (a_request.receiver)
		end

	process_type_request (a_request: AUT_TYPE_REQUEST) is
		do
			is_relevant := variables.has (a_request.variable)
		end

invariant

	variables_not_void: variables /= Void
	no_variable_void: not variables.has (Void)

end
