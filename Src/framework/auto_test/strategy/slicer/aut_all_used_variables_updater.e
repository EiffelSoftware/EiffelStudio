indexing
	description: "Processor that keeps track of all variables used in a minimized slice"
	copyright: "Copyright (c) 2008, Ilinca Ciupa and others"
	license: "Eiffel Forum License v2 (see forum.txt)"

class AUT_ALL_USED_VARIABLES_UPDATER

inherit

	AUT_REQUEST_PROCESSOR

	REFACTORING_HELPER

	AUT_SHARED_TYPE_FORMATTER

	AUT_SHARED_TYPE_FORMATTER

	AUT_SHARED_INTERPRETER_INFO

create

	make

feature {NONE} -- Initialization

	make (a_system: like system) is
			-- Initialize.
		require
			a_system_attached: a_system /= Void
		do
			system := a_system
			create variables.make_default
			variables.set_key_equality_tester (create {AUT_VARIABLE_EQUALITY_TESTER}.make)
		end

feature -- Access

	variables: DS_HASH_TABLE [TUPLE [type: ?TYPE_A; name: ?STRING; check_dyn_type: BOOLEAN], ITP_VARIABLE]
			-- Set of used variables: keys are variables, items are tuples of static type of variable
			-- and a boolean flag showing if the static type should be checked against dynamic type
			-- (is only the case for variables returned as results of function calls and those whose type
			-- is left Void)

	system: SYSTEM_I
			-- System

feature{AUT_REQUEST} -- Processing

	process_start_request (a_request: AUT_START_REQUEST) is
		do
			variables.wipe_out
		end

	process_stop_request (a_request: AUT_STOP_REQUEST) is
		do
			-- Do nothing.
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST) is
		local
			l_type: TYPE_A
			l_name: STRING
		do
			if not variables.has (a_request.target) then
				l_type := a_request.target_type
				l_name := type_name_with_context (l_type, interpreter_root_class, Void)
				variables.force ([l_type, l_name, False], a_request.target.deep_twin)
			end
			if a_request.argument_list /= Void then
				process_argument_list (a_request.argument_list)
			end
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST) is
		local
			l_type: TYPE_A
			l_name: STRING
		do
			if a_request.receiver /= Void and then not variables.has (a_request.receiver) then
				l_type := a_request.feature_to_call.type.actual_type.instantiation_in (a_request.target_type, a_request.feature_to_call.written_in)
				l_name := type_name_with_context (l_type, interpreter_root_class, Void)
				variables.force ([l_type, l_name, True], a_request.receiver.deep_twin)
			end
			l_type := a_request.target_type
			l_name := type_name_with_context (l_type, interpreter_root_class, Void)
			variables.force ([l_type, l_name, False], a_request.target.deep_twin)
			process_argument_list (a_request.argument_list)
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST) is
		local
			variable: ITP_VARIABLE
		do
			if not variables.has (a_request.receiver) then
				variables.force ([Void, Void, True], a_request.receiver.deep_twin)
			end
			variable ?= a_request.expression
			if variable /= Void then
				variables.force ([Void, Void, True], variable.deep_twin)
			end
		end

	process_type_request (a_request: AUT_TYPE_REQUEST) is
		local
			norm_response: AUT_NORMAL_RESPONSE
			l_name: STRING
		do
			-- Do nothing.
			if variables.has (a_request.variable) then
				norm_response ?= a_request.response
				if norm_response /= Void then
					l_name := norm_response.text.twin
					l_name.right_adjust
					l_name.left_adjust
					variables.force ([Void, l_name, False], a_request.variable)
				end
			end
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
				if variable /= Void and then not variables.has (variable) then
					variables.force ([Void, Void, True], variable.deep_twin)
				end
				cs.forth
			end
		end

invariant

	variables_not_void: variables /= Void
	no_variable_void: not variables.has (Void)

end
