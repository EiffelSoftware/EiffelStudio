note

	description:

		"Plays back lists of requests on the interpreter"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_REQUEST_PLAYER

inherit

	AUT_STRATEGY
		redefine
			make,
			start
		end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	AUT_REQUEST_PROCESSOR

	ERL_CONSTANTS

create

	make

feature {NONE} -- Initialization

	make (a_interpreter: like interpreter; a_system: like system; a_error_handler: like error_handler)
			-- Create new strategy.
		do
			Precursor (a_interpreter, a_system, a_error_handler)
			create {DS_ARRAYED_LIST [AUT_REQUEST]} request_list.make (0)
			request_list_cursor := request_list.new_cursor
			is_interpreter_started_by_default := True
		ensure then
			interpreter_started_by_default: is_interpreter_started_by_default
		end

feature -- Status

	has_next_step: BOOLEAN
		do
			Result := not has_error and then not request_list_cursor.off
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

	set_request_list (a_request_list: like request_list)
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

	set_is_interpreter_started_by_default (b: BOOLEAN)
			-- Set `is_interpreter_started_by_default' with `b'.
		do
			is_interpreter_started_by_default := b
		ensure
			is_interpreter_started_by_default_set: is_interpreter_started_by_default = b
		end

feature -- Execution

	start
			-- <Precursor>
		local
			l_itp: like interpreter
		do
			l_itp := interpreter
			l_itp.set_is_in_replay_mode (True)
			l_itp.set_is_logging_enabled (False)
			if is_interpreter_started_by_default then
				Precursor
				has_error := not interpreter.is_ready
			elseif l_itp.is_running then
				l_itp.stop
			end
			if has_error then
				request_list_cursor.go_after
			else
				request_list_cursor.start
			end
		end

	step
		do
--			if not interpreter.is_running then
--				interpreter.start
--				assign_void
--			end
			has_error := interpreter.is_launched and then not interpreter.is_ready
			if not has_error then
				request_list_cursor.item.process (Current)
				request_list_cursor.forth
			end
		end

feature {AUT_REQUEST} -- Processing

	process_start_request (a_request: AUT_START_REQUEST)
		do
			interpreter.start
			a_request.set_response (interpreter.last_request.response)
		end

	process_stop_request (a_request: AUT_STOP_REQUEST)
		do
			interpreter.stop
			a_request.set_response (interpreter.last_request.response)
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST)
		do
			if a_request.argument_list /= Void and then interpreter.variable_table.are_expressions_valid (a_request.argument_list) then
				interpreter.create_object (a_request.target, a_request.target_type, a_request.creation_procedure, a_request.argument_list)
				a_request.set_response (interpreter.last_request.response)
			else
				has_error := True
			end
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST)
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

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST)
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

	process_type_request (a_request: AUT_TYPE_REQUEST)
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
	interpreter_in_replay_mode: interpreter.is_replaying
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
