note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_STATUS_CLASSIC

inherit
	APPLICATION_STATUS
		redefine
			current_call_stack,
			switch_to_current_thread_id,
			thread_name, thread_priority
		end

	IPC_SHARED

create {APPLICATION_EXECUTION}
	make

feature {APPLICATION_STATUS_EXPORTER} -- Initialization

	set (n: STRING; add: DBG_ADDRESS; scp_pid: NATURAL_16; ot, dt, offs, nested, reas: INTEGER)
			-- Set the various attributes identifying current
			-- position in source code.
		require
			n_not_empty: not n.is_empty
			add_attached: add /= Void
		local
			ccs: EIFFEL_CALL_STACK_CLASSIC

			f: E_FEATURE
		do
			object_address := add
			reason := reas
			if reason /= Pg_update_breakpoint then
					-- Compute class type.
				dynamic_type := Eiffel_system.type_of_dynamic_id (dt, False)
				if dynamic_type /= Void then
					dynamic_class := dynamic_type.associated_class
				else
					dynamic_class := Eiffel_system.class_of_dynamic_id (dt, False)
				end

					-- Compute origin class type
				origin_class := Eiffel_system.class_of_dynamic_id (ot, False)

					-- Compute feature (E_FEATURE)
					--|Note: the application sends us the original name.

				if origin_class /= Void then
					f := feature_from_runtime_data (dynamic_class, origin_class, n)
					if f /= Void then
						body_index := f.body_index
					end
				end
				e_feature := f

					-- Compute break position.
				break_index := offs
				break_nested_index := nested

					-- create the call stack
				create ccs.make_empty (current_thread_id, scp_pid)
				set_call_stack (current_thread_id, ccs)

--				stack_num := Application.current_execution_stack_number
--				if stack_num > ccs.count then
--					stack_num := ccs.count
--				end
--				Application.set_current_execution_stack (stack_num)
			end
		ensure
			valid_break_index: (break_index > 0) or
						(break_index = 0 implies (
							reason = Pg_update_breakpoint or
							reason = Pg_raise or
							reason = pg_viol or
							reason = Pg_catcall or
							(e_feature /= Void and then e_feature.is_external))
						)
			valid_efeature: e_feature = Void implies (reason = Pg_update_breakpoint)
		end

feature -- Access

	Ipc_request: IPC_REQUEST
		once
			create Result
		end

	switch_to_current_thread_id
			-- Switch debugger context thread id to `current_thread_id'.
		do
			Precursor
				--| At this point the ipc is/must-be initialized
			ipc_request.send_rqst_3 (rqst_change_thread, 0, 0, current_thread_id)
		end

feature {NONE} -- CallStack Impl

	new_callstack_with (a_tid: like current_thread_id; a_stack_max_depth: INTEGER): like current_call_stack
			-- Get Eiffel Callstack with a maximum depth of `a_stack_max_depth'
			-- for thread `a_tid'.
		do
			create Result.make (a_stack_max_depth, a_tid, scoop_processor_id (a_tid))
		end

feature -- Query

	dummy_call_stack_element: CALL_STACK_ELEMENT_CLASSIC
		do
			create Result.dummy_make (e_feature, 1, True, break_index, break_nested_index,
					object_address, active_thread_id, dynamic_type, dynamic_class, origin_class)
		end

feature -- Values

	current_call_stack: EIFFEL_CALL_STACK_CLASSIC
			-- Current Eiffel call stack

	refresh_current_thread_id
			-- Refresh current thread id
		do
			-- FIXME jfiat: for now Classic system do not support thread selection
			-- TODO
		end

feature -- Threads related access

	thread_name (id: like current_thread_id): STRING_32
			-- Thread name.
		do
			--| Classic does not provide feature for that purpose
		end

	thread_priority (id: like current_thread_id): INTEGER
			-- Thread priority.
		do
			--| Classic does not provide feature for that purpose			
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
