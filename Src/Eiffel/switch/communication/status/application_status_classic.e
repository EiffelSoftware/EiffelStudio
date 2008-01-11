indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_STATUS_CLASSIC

inherit
	APPLICATION_STATUS
		redefine
			current_call_stack,
			switch_to_current_thread_id,
			exception_description,
			thread_name, thread_priority
		end

	IPC_SHARED

create {APPLICATION_EXECUTION}
	make

feature {APPLICATION_STATUS_EXPORTER} -- Initialization

	set (n: STRING; obj: STRING; ot, dt, offs, reas: INTEGER) is
			-- Set the various attributes identifying current
			-- position in source code.
		local
			ccs: EIFFEL_CALL_STACK_CLASSIC
			eclc: EIFFEL_CLASS_C
		do
			object_address := obj
			reason := reas
			if reason /= Pg_new_breakpoint then
					-- Compute class type.
				dynamic_class := Eiffel_system.class_of_dynamic_id (dt, False)

					-- Compute origin class type
				origin_class := Eiffel_system.class_of_dynamic_id (ot, False)

					-- Compute feature (E_FEATURE)
					--|Note: the applicaiton sends us the original name.
				e_feature := origin_class.feature_with_name (n)
				if e_feature = Void then
					eclc ?= dynamic_class
					if eclc /= Void then
						e_feature := eclc.api_inline_agent_of_name (n)
					end
				end
				if e_feature /= Void then
					body_index := e_feature.body_index
				end

					-- Compute break position.
				break_index := offs

					-- create the call stack
				create ccs.make_empty (current_thread_id)
				set_call_stack (current_thread_id, ccs)

--				stack_num := Application.current_execution_stack_number
--				if stack_num > ccs.count then
--					stack_num := ccs.count
--				end
--				Application.set_current_execution_stack (stack_num)
			end
		ensure
			valid_break_index: (break_index > 0) or (break_index = 0 implies (
					reason = Pg_new_breakpoint or reason = Pg_raise or reason = pg_viol or
					(e_feature /= Void and then e_feature.is_external)))
			valid_efeature: e_feature = Void implies (reason = Pg_new_breakpoint)
		end

feature -- Access

	Ipc_request: IPC_REQUEST is
		once
			create Result
		end

	switch_to_current_thread_id	is
			-- Switch debugger context thread id to `current_thread_id'.
		do
			Precursor
				--| At this point the ipc is/must-be initialized
			ipc_request.send_rqst_1 (rqst_change_thread, current_thread_id)
		end

feature {NONE} -- CallStack Impl

	new_callstack_with (a_tid: INTEGER; a_stack_max_depth: INTEGER): like current_call_stack is
			-- Get Eiffel Callstack with a maximum depth of `a_stack_max_depth'
			-- for thread `a_tid'.
		do
			create Result.make (a_stack_max_depth, a_tid)
		end

feature -- Values

	exception_occurred: BOOLEAN is
		do
			Result := exception_code /= 0 or exception_tag /= Void
		end

	exception_message: STRING_32 is
			-- For now, the exception message for classic system is the exception tag.
		do
			Result := exception_tag
		end

	exception_description: STRING_32 is
		local
			e: EXCEPTIONS
			s8: STRING_8
		do
			create Result.make (10)
			Result.append_string ("Code: ")
			Result.append_integer (exception_code)
			Result.append (" (")
			create e
			s8 := e.meaning (exception_code)
			if s8 = Void then
				s8 := "Undefined"
			end
			Result.append (s8.as_string_32)
			Result.append (") ")
			Result.append (Precursor {APPLICATION_STATUS})
		end

	exception_class_name: STRING is
		do
			--| For now, exception are not object on classic Eiffel system
		end

	current_call_stack: EIFFEL_CALL_STACK_CLASSIC

	refresh_current_thread_id is
		do
			-- FIXME jfiat: for now Classic system do not support thread selection
			-- TODO
		end

feature -- Threads related access

	thread_name (id: like current_thread_id): STRING is
		do

		end

	thread_priority (id: like current_thread_id): INTEGER is
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class APPLICATION_STATUS_CLASSIC
