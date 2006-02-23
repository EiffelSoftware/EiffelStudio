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
			switch_to_current_thread_id
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
		do
			object_address := obj
			reason := reas
			if (reason /= Pg_new_breakpoint) then
					-- Compute class type.
				dynamic_class := Eiffel_system.class_of_dynamic_id (dt)

					-- Compute origin class type
				origin_class := Eiffel_system.class_of_dynamic_id (ot)

					-- Compute feature (E_FEATURE)
					--|Note: the applicaiton sends us the original name.
				e_feature := origin_class.feature_with_name (n)
				body_index := e_feature.body_index

					-- Compute break position.
				break_index := offs

					-- create the call stack
				create ccs.dummy_make
				set_call_stack (current_thread_id, ccs)

--				stack_num := Application.current_execution_stack_number
--				if stack_num > ccs.count then
--					stack_num := ccs.count
--				end
--				Application.set_current_execution_stack (stack_num)
			else
				-- application has stopped to take into account the
				-- new breakpoints. So let's send the new breakpoints
				-- to the application and resume it.
				Application.continue_ignoring_kept_objects
			end
		ensure
			valid_break_index: (break_index = 0 implies (reason = Pg_new_breakpoint or reason = Pg_raise)) or (break_index > 0)
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

	new_current_callstack_with (a_stack_max_depth: INTEGER): like current_call_stack is
			-- Create Eiffel Callstack with a maximum depth of `a_stack_max_depth'
		do
			create Result.make (a_stack_max_depth, current_thread_id)
		end

feature -- Values

	exception_occurred: BOOLEAN is
		do
			Result := exception_code /= 0 or exception_tag /= Void
		end

	exception_message: STRING is
			-- For now, the exception message for classic system is the exception tag.
		do
			Result := exception_tag
		end

	current_call_stack: EIFFEL_CALL_STACK_CLASSIC

	refresh_current_thread_id is
		do
			-- FIXME jfiat: for now Classic system do not support thread selection
			-- TODO
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
