indexing

	description:

		"[
		  Updates set of relevant variables for a request, so that the 
		  set includes all variables that the request reads from and
		  does not include those variables that the request writes to.
		 ]"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_RELEVANT_VARIABLES_UPDATER

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

feature {AUT_REQUEST} -- Processing

	process_start_request (a_request: AUT_START_REQUEST) is
		do
			variables.wipe_out
		end

	process_stop_request (a_request: AUT_STOP_REQUEST) is
		do
			-- Do nothing.
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST) is
		do
			variables.remove (a_request.target)
			if a_request.argument_list /= Void then
				process_argument_list (a_request.argument_list)
			end
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST) is
		do
			if a_request.is_feature_query then
				variables.remove (a_request.receiver)
			end
			variables.force (a_request.target)
			if a_request.argument_list /= Void then
				process_argument_list (a_request.argument_list)
			end
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST) is
		local
			variable: ITP_VARIABLE
		do
			variables.remove (a_request.receiver)
			variable ?= a_request.expression
			if variable /= Void then
				variables.force (variable)
			end
		end

	process_type_request (a_request: AUT_TYPE_REQUEST) is
		do
			-- Do nothing.
		end

	process_argument_list (an_argument_list: DS_LINEAR [ITP_EXPRESSION]) is
			-- Add variables in `an_argument_list' to `variables'.
		require
			an_argument_list_not_void: an_argument_list /= Void
			no_argument_void: not an_argument_list.has (Void)
		local
			cs: DS_LINEAR_CURSOR [ITP_EXPRESSION]
			variable: ITP_VARIABLE
		do
			from
				cs := an_argument_list.new_cursor
				cs.start
			until
				cs.off
			loop
				variable ?= cs.item
				if variable /= Void then
					variables.force (variable)
				end
				cs.forth
			end
		end

invariant

	variables_not_void: variables /= Void
	no_variable_void: not variables.has (Void)

end
