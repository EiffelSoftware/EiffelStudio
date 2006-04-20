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
		end;
	SHARED_APPLICATION_EXECUTION
		undefine
			is_equal, copy
		end

create {APPLICATION_STATUS_CLASSIC}
	make, dummy_make

create {EIFFEL_CALL_STACK_CLASSIC}
	list_make, make_sublist

feature -- Properties

	stack_depth: INTEGER is
			-- FIXME jfiat: this is count for now .. but fix this !!
		do
			Result := count
		end

	error_occurred: BOOLEAN;
			-- Did an error occurred when retrieving the eiffel stack?

feature -- Output

	display_stack (text_formatter: TEXT_FORMATTER) is
			-- Display callstack in `text_formatter'.
		local
			stack_num, i: INTEGER
		do
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": Displaying stack %N"); end
			text_formatter.add_new_line;
			text_formatter.add_string ("Call stack:");
			text_formatter.add_new_line;
			text_formatter.add_new_line;
			text_formatter.process_call_stack_item (0, false) -- For padding
			text_formatter.add_string ("Object");
			text_formatter.add_column_number (14);
			text_formatter.add_string ("Class");
			text_formatter.add_column_number (26);
			text_formatter.add_string ("Routine");
			text_formatter.add_new_line;
			text_formatter.process_call_stack_item (0, false) -- For padding
			text_formatter.add_string ("------");
			text_formatter.add_column_number (14);
			text_formatter.add_string ("-----");
			text_formatter.add_column_number (26);
			text_formatter.add_string ("-------");
			text_formatter.add_new_line;

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": getting stack number %N"); end
			stack_num := Application.current_execution_stack_number;

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": processing %N"); end
			from
				start;
				i := 1
			until
				after
			loop
				if i = stack_num then
					text_formatter.process_call_stack_item (i, true)
				else
					text_formatter.process_call_stack_item (i, false)
				end;
				item.display_feature (text_formatter);
				text_formatter.add_new_line;
				forth;
				i := i + 1;
			end;
			text_formatter.add_new_line
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": end displaying call stack %N"); end
		end;

feature {NONE} -- Initialization

	make (n: INTEGER; tid: INTEGER) is
			-- Fill `where' with the `n' first call stack elements.
			-- `where' is left empty if there is an error.
			-- Retrieve the whole call stack if `n' = -1.
		local
			call	: CALL_STACK_ELEMENT_CLASSIC
			level	: INTEGER
		do
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": Creating Eiffel Stack%N"); end
			error_occurred := False
			list_make

			from
				send_dump_stack_request (n, tid)
				level := 1			-- we start from the top of the call stack.
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

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": Finished Adopting callstack objects%N"); end
		end

	dummy_make is
			-- Initialize only the first call stack element.
		do
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%T" + generator + ": Creating dummy Eiffel Stack%N"); end
			error_occurred := False
			list_make
		end

feature {NONE} -- Externals

	send_dump_stack_request (n: INTEGER; tid: INTEGER) is
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
