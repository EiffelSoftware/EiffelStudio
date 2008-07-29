indexing
	description: "Eiffel call stack for the stopped application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class EIFFEL_CALL_STACK_CLASSIC

inherit
	EIFFEL_CALL_STACK
		undefine
			is_equal, copy
		end

	DEBUG_EXT
		undefine
			is_equal, copy
		end

	IPC_SHARED
		undefine
			is_equal, copy
		end

	TWO_WAY_LIST [CALL_STACK_ELEMENT_CLASSIC]
		rename
			make as list_make
		export
			{NONE} list_make
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		undefine
			is_equal, copy
		end

create {APPLICATION_STATUS_CLASSIC}
	make, make_empty

create {EIFFEL_CALL_STACK_CLASSIC}
	list_make

create {TWO_WAY_LIST}
	make_sublist

feature -- Properties

	stack_depth: INTEGER
			-- Current call stack depth

	error_occurred: BOOLEAN;
			-- Did an error occurred when retrieving the eiffel stack?

feature {NONE} -- Initialization

	make (n: INTEGER; tid: like thread_id) is
			-- Fill `where' with the `n' first call stack elements.
			-- `where' is left empty if there is an error.
			-- Retrieve the whole call stack if `n' = -1.
		do
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": Creating Eiffel Stack%N"); end
			make_empty (tid)
			reload (n)
		end

	make_empty (tid: like thread_id) is
			-- Initialize only the first call stack element.
		do
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": Creating Empty Eiffel Stack%N"); end
			thread_id := tid
			error_occurred := False
			list_make
		end

feature {APPLICATION_STATUS} -- Restricted Access

	reload (n: INTEGER) is
		local
			tid: like thread_id
			call: CALL_STACK_ELEMENT_CLASSIC
			level: INTEGER
		do
			wipe_out
			from
				tid :=  thread_id
				send_dump_stack_request (n, tid)

					--| Read callstack depth
				stack_depth := to_integer_32 (c_tread)

					--| we start from the top of the call stack.
				level := 1
				create call.make(level, tid)
			until
				call.is_exhausted or call.error
			loop
				extend (call)
				level := level + 1
				create call.make (level, tid)
			end

			if call.error then
				error_occurred := True
				wipe_out
			end

			debug ("DEBUGGER_TRACE");
				io.error.put_string ("%T" + generator + " : Finished creating Eiffel Stack%N");
				io.error.put_string ("%T" + generator + ": Adopting callstack objects%N");
			end

				-- Now we adopt each object situated on the callstack
			from start until after loop
				item.set_hector_addr_for_current_object
				forth
			end

			is_loaded := True

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": Finished Adopting callstack objects%N"); end
		end

feature -- Properties

	thread_id: POINTER

feature {NONE} -- Externals

	send_dump_stack_request (n: INTEGER; tid: like thread_id) is
		do
			send_rqst_1 (rqst_dump_stack, n)
		end

invariant

	empty_if_error: error_occurred implies is_empty

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

end -- class EIFFEL_CALL_STACK
