indexing

	description:

		"Plays back lists of requests on the interpreter"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_REQUEST_PLAYER

inherit

	AUT_STRATEGY
		rename
			make as make_strategy
		redefine
			start
		end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	AUT_REQUEST_PROCESSOR

	ERL_CONSTANTS

create

	make

feature {NONE} -- Initialization

	make (a_a_system: like system; an_interpreter: like interpreter) is
			-- Create new strategy.
		require
			a_a_system_not_void: a_a_system /= Void
			a_interpreter_not_void: an_interpreter /= Void
			an_interpreter_in_replay_mode: an_interpreter.is_in_replay_mode
		do
			make_strategy (a_a_system, an_interpreter)
			create {DS_ARRAYED_LIST [AUT_REQUEST]} request_list.make (0)
			request_list_cursor := request_list.new_cursor
			is_interpreter_started_by_default := True
		ensure
			system_set: system = a_a_system
			interpreter_set: interpreter = an_interpreter
			interpreter_started_by_default: is_interpreter_started_by_default
		end

feature -- Status

	has_next_step: BOOLEAN is
		do
			Result := not request_list_cursor.off and (interpreter.is_running implies interpreter.is_ready)
		end

	has_error: BOOLEAN
			-- Has an error occurred during last playback?

feature -- Access

	request_list: DS_LINEAR [AUT_REQUEST]
			-- List of requests to play back

feature -- Status report

	is_interpreter_started_by_default: BOOLEAN
			-- Should interpreter be started when Current strategy is started?
			-- Default: True

feature -- Setting

	set_request_list (a_request_list: like request_list) is
			-- Set `request_list' to `a_request_list'.
		require
			a_request_list_not_void: a_request_list /= Void
			no_request_void: not a_request_list.has (Void)
		do
			request_list := a_request_list
			request_list_cursor := a_request_list.new_cursor
		ensure
			request_list_set: request_list = a_request_list
		end

	set_is_interpreter_started_by_default (b: BOOLEAN) is
			-- Set `is_interpreter_started_by_default' with `b'.
		do
			is_interpreter_started_by_default := b
		ensure
			is_interpreter_started_by_default_set: is_interpreter_started_by_default = b
		end


feature -- Execution

	start is
		do
			if interpreter.is_running then
				interpreter.stop
			end
			if is_interpreter_started_by_default then
				interpreter.start
			end
			request_list_cursor.start
			has_error := False
		end

	step is
		do
--			if not interpreter.is_running then
--				interpreter.start
----				assign_void
--			end
			request_list_cursor.item.process (Current)
			request_list_cursor.forth
		end

feature {AUT_REQUEST} -- Processing

	process_start_request (a_request: AUT_START_REQUEST) is
		do
			interpreter.start
			a_request.set_response (interpreter.last_request.response)
		end

	process_stop_request (a_request: AUT_STOP_REQUEST) is
		do
			interpreter.stop
			a_request.set_response (interpreter.last_request.response)
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST) is
		do
			if a_request.argument_list /= Void and then interpreter.variable_table.are_expressions_valid (a_request.argument_list) then
				interpreter.create_object (a_request.target, a_request.target_type, a_request.creation_procedure, a_request.argument_list)
				a_request.set_response (interpreter.last_request.response)
			else
				has_error := True
			end
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST) is
		local
			l_variable_table: AUT_VARIABLE_TABLE
		do
			l_variable_table := interpreter.variable_table
			a_request.set_target_type (l_variable_table.variable_type (a_request.target))
			if
				l_variable_table.is_variable_defined (a_request.target) and then
				l_variable_table.are_expressions_valid (a_request.argument_list) and then
				interpreter.has_feature (l_variable_table.variable_type (a_request.target).associated_class, a_request.feature_to_call) and then
				not l_variable_table.variable_type (a_request.target).associated_class.name.is_equal (none_type_name)
			 then
			 	if a_request.is_feature_query then
					interpreter.invoke_and_assign_feature (a_request.receiver, a_request.target_type, a_request.feature_to_call, a_request.target, a_request.argument_list)
					a_request.set_response (interpreter.last_request.response)
				else
					interpreter.invoke_feature (a_request.target_type, a_request.feature_to_call, a_request.target, a_request.argument_list)
					a_request.set_response (interpreter.last_request.response)
				end
			else
				has_error := True
			end
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST) is
		local
			variable: ITP_VARIABLE
		do
			variable ?= a_request.expression
			if variable /= Void and then not interpreter.variable_table.is_variable_defined (variable) then
				has_error := True
			else
				interpreter.assign_expression (a_request.receiver, a_request.expression)
				a_request.set_response (interpreter.last_request.response)
			end
		end

	process_type_request (a_request: AUT_TYPE_REQUEST) is
		do
			interpreter.retrieve_type_of_variable (a_request.variable)
			a_request.set_response (interpreter.last_request.response)
		end

feature {NONE} -- Implementation

	request_list_cursor: DS_LINEAR_CURSOR [AUT_REQUEST]
			-- Cursor indicating next request to play

invariant

	request_list_not_void: request_list /= Void
	request_list_cursor_not_void: request_list_cursor /= Void
	no_request_void: not request_list.has (Void)
	request_list_cursor_valid: request_list_cursor.container = request_list
	interpreter_in_replay_mode: interpreter.is_in_replay_mode
end
