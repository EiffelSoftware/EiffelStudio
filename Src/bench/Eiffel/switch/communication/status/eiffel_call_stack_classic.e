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

	display_stack (st: STRUCTURED_TEXT) is
			-- Display callstack in `st'.
		local
			stack_num, i: INTEGER
			cs: CALL_STACK_ITEM
		do
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: Displaying stack %N"); end
			st.add_new_line;
			st.add_string ("Call stack:");
			st.add_new_line;
			st.add_new_line;
			create cs.do_nothing; -- For padding
			st.add (cs);
			st.add_string ("Object");
			st.add_column_number (14);
			st.add_string ("Class");
			st.add_column_number (26);
			st.add_string ("Routine");
			st.add_new_line;
			create cs.do_nothing; -- For padding
			st.add (cs);
			st.add_string ("------");
			st.add_column_number (14);
			st.add_string ("-----");
			st.add_column_number (26);
			st.add_string ("-------");
			st.add_new_line;

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: getting stack number %N"); end
			stack_num := Application.current_execution_stack_number;

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: processing %N"); end
			from
				start;
				i := 1
			until
				after
			loop
				if i = stack_num then
					create cs.make_selected (i);
				else
					create cs.make (i);
				end;
				st.add (cs)
				item.display_feature (st);
				st.add_new_line;
				forth;
				i := i + 1;
			end;
			st.add_new_line
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: end displaying call stack %N"); end
		end;

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Fill `where' with the `n' first call stack elements.
			-- `where' is left empty if there is an error.
			-- Retrieve the whole call stack if `n' = -1.
		local
			call	: CALL_STACK_ELEMENT_CLASSIC
			level	: INTEGER
		do
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: Creating Eiffel Stack%N"); end
			error_occurred := False
			list_make

			from
				request_dump (n)
				level := 1			-- we start from the top of the call stack.
				create call.make(level)
			until
				call.is_exhausted or call.error
			loop
				extend (call)
				level := level + 1
				create call.make(level)
			end

			if call.error then
				error_occurred := True
				wipe_out
			end

			debug ("DEBUGGER_TRACE");
				io.error.put_string ("%TEIFFEL_CALL_STACK: Finished creating Eiffel Stack%N");
				io.error.put_string ("%TEIFFEL_CALL_STACK: Adopting callstack objects%N");
			end

				-- Now we adopt each object situated on the callstack
			from start until after loop
				item.set_hector_addr_for_current_object
				forth
			end

			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: Finished Adopting callstack objects%N"); end
		end

	dummy_make is
			-- Initialize only the first call stack element.
		do
			debug ("DEBUGGER_TRACE"); io.error.put_string ("%TEIFFEL_CALL_STACK: Creating dummy Eiffel Stack%N"); end
			error_occurred := False
			list_make
		end

feature {NONE} -- Externals

	request_dump (n: INTEGER) is
		external
			"C"
		end

invariant

	empty_if_error: error_occurred implies is_empty

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

end -- class EIFFEL_CALL_STACK
