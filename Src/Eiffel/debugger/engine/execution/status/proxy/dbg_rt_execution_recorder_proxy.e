note
	description: "Summary description for {DBG_RT_EXECUTION_RECORDER_PROXY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_RT_EXECUTION_RECORDER_PROXY

inherit
	DBG_RT_PROXY

create
	make

feature {NONE} -- Initialization

	make (a_dump_value: DUMP_VALUE; a_app: APPLICATION_EXECUTION) is
			-- Initialize `Current'.
		require
			a_value_attached: a_dump_value /= Void
			a_app_attached: a_app /= Void
		do
			dump_value := a_dump_value
			dynamic_class := a_dump_value.dynamic_class
			set_associated_application (a_app)

			if
				attached a_dump_value.address as add and then
				not add.is_void
			then
				a_app.status.keep_object (add)
			end
		end

feature -- Status report

	is_void: BOOLEAN
		do
			Result := dump_value.is_void
		end

	replay_activated: BOOLEAN
		do
			Result := associated_application.status.replay_activated
		end

feature -- Remote Invocation: Record and Replay

	activate_replay (b: BOOLEAN)
			-- Remotely Activate replay
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			status: APPLICATION_STATUS
		do
			if not is_void then
				status := associated_status
				create params.make (1)
				params.extend (dump_value_factory.new_boolean_value (b, compiler_data.boolean_class_c))
				if
					command_evaluation_on ("activate_replay", params) and then
					attached current_replayed_call as rcse
				 then
					status.set_current_replayed_call (rcse)
				else
					status.set_current_replayed_call (Void)
				end
			end
		end

	replay (direction: INTEGER): BOOLEAN
			-- Replay execution in `direction'
			-- and return True if operation succeed.
		require
			replay_activated: replay_activated
		local
			prev_d, d: INTEGER
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
			i32cl: CLASS_C
			dir, nb: INTEGER
			status: APPLICATION_STATUS
		do
			if not is_void then
				status := associated_status
				dir := direction
				prev_d := status.replayed_depth

				nb := 1

				dv_fact := dump_value_factory
				i32cl := compiler_data.integer_32_class_c
				create params.make (2)
				params.extend (dv_fact.new_integer_32_value (dir, i32cl))
				params.extend (dv_fact.new_integer_32_value (nb, i32cl))

				if attached status.current_call_stack as ccs then
					ccs.reset_call_stack_depth (prev_d)
					Result := command_evaluation_on ("replay", params)
					if Result then
						if attached current_replayed_call as rcse then
							status.set_current_replayed_call (rcse)
						else
							check should_not_occur: False end
						end
					else
						--| Error, so keep current data
						--| Note: or maybe ... popup error message, and exit debugging ..?
--						status.set_current_replayed_call (Void)
					end
					d := status.replayed_depth
					if d > 0 then
						ccs.reset_call_stack_depth (d)
					end
					debugger_manager.incremente_debugging_operation_id
				end
			end
		end

	replay_to_point (a_id: STRING): BOOLEAN
			-- Replay to point identified by `a_id'
		local
			status: APPLICATION_STATUS
			params: ARRAYED_LIST [DUMP_VALUE]
			prev_d,d1,d2: INTEGER
		do
			if not is_void then
				status := associated_status
				prev_d := status.replayed_depth

				create params.make (1)
				params.extend (dump_value_factory.new_manifest_string_value (a_id, compiler_data.string_8_class_c))
				Result := command_evaluation_on ("replay_to_point", params)
				if Result then
					if attached current_replayed_call as rcse then
						status.set_current_replayed_call (rcse)
					else
						check should_not_occur: False end
					end
				else
					--| Error, so keep current data
					--| Note: or maybe ... popup error message, and exit debugging ..?
--						status.set_current_replayed_call (Void)
				end
				if attached status.current_call_stack as ccs then
					from
						d2 := status.replayed_depth
						if d2 > prev_d then
							d1 := prev_d
						else
							d1 := d2
							d2 := prev_d
						end
					until
						d1 > d2
					loop
						ccs.reset_call_stack_depth (d1)
						d1 := d1 + 1
					end
				end
				debugger_manager.incremente_debugging_operation_id
			end
		end

	query_replay_status (direction: INTEGER): INTEGER
			-- Query exec replay status for direction `direction'
			-- Return the number of available steps.
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			dv: DUMP_VALUE
		do
			if not is_void then
				create params.make (1)
				params.extend (dump_value_factory.new_integer_32_value (direction, compiler_data.integer_32_class_c))
				dv := query_evaluation_on ("replay_query", params)
				if dv = Void then
					check dv_attached: False end
					--| FIXME: 2009-09-25: Handle this unprobable error.
				elseif dv.is_basic then
					Result := dv.as_dump_value_basic.value_integer_32
				end
			end
		end

	current_replayed_call: detachable REPLAYED_CALL_STACK_ELEMENT
			-- Current replayed call representation
		local
			dv: DUMP_VALUE
		do
			if not is_void then
				dv := query_evaluation_on ("replayed_call_details", Void)
				if dv /= Void and then not dv.is_void then
					if attached dv.string_representation as s32 and then s32.count > 0 then
						create Result.make_from_string ("" , s32)
					end
				end
			end
		end

	replay_callstack_details (a_id: STRING; nb: INTEGER): detachable REPLAYED_CALL_STACK_ELEMENT
			-- Details related to replayed callstack identified by `a_id'
			-- get the information for `nb' levels
		local
			params: ARRAYED_LIST [DUMP_VALUE]
			dv_fact: DUMP_VALUE_FACTORY
			dv: DUMP_VALUE
		do
			if not is_void then
				dv_fact := dump_value_factory
				create params.make (2)
				params.extend (dv_fact.new_manifest_string_value (a_id, compiler_data.string_8_class_c))
				params.extend (dv_fact.new_integer_32_value (nb, compiler_data.integer_32_class_c))
				dv := query_evaluation_on ("callstack_record_details", params)
				if dv /= Void and then not dv.is_void then
					if
						attached dv.string_representation as s32 and then
						s32.count > 0
					then
						create Result.make_from_string (a_id , s32)
					end
				end
			end
		end

feature -- Access

	dump_value: DUMP_VALUE
			-- Handle on the remote {RT_EXTENSION} object

	dynamic_class: CLASS_C
			-- Dynamic class	

feature {NONE} -- Implementation

	query_evaluation_on (fname: STRING_8; params: LIST [DUMP_VALUE]): detachable DUMP_VALUE
			-- method `{cl}.fname' evaluation on `edv'
			-- using `params' as argument if any
		do
			Result := associated_application.query_evaluation_on (Void, dump_value, dynamic_class, fname, params)
		end

	command_evaluation_on (fname: STRING_8; params: LIST [DUMP_VALUE]): BOOLEAN
			-- Evaluation's result for `a_expr' in current context
			-- (note: Result = Void implies an error occurred)		
		do
			Result := associated_application.command_evaluation_on (Void, dump_value, dynamic_class, fname, params)
		end

invariant
	dump_value_attached: dump_value /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
