indexing

	description: 
		"Eiffel call stack for the stopped application.";
	date: "$Date$";
	revision: "$Revision $"

class EIFFEL_CALL_STACK

inherit

	TWO_WAY_LIST [CALL_STACK_ELEMENT]
		rename
			make as list_make
		end;
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

creation {RUN_INFO, APPLICATION_STATUS}

	make

feature -- Properties

	error_occurred: BOOLEAN;
			-- Did an error occurred when retrieving the eiffel stack?

feature -- Output

	display_stack (st: STRUCTURED_TEXT) is
			-- Display callstack in `st'.
		local
			stack_num, i: INTEGER;
			cs: CALL_STACK_ITEM
		do
			st.add_new_line;
			st.add_string ("Call stack:");
			st.add_new_line;
			st.add_new_line;
			!! cs.do_nothing; -- For padding
			st.add (cs);
			st.add_string ("Object");
			st.add_column_number (14);
			st.add_string ("Class");
			st.add_column_number (26);
			st.add_string ("Routine");
			st.add_new_line;
			!! cs.do_nothing; -- For padding
			st.add (cs);
			st.add_string ("------");
			st.add_column_number (14);
			st.add_string ("-----");
			st.add_column_number (26);
			st.add_string ("-------");
			st.add_new_line;
			stack_num := Application.current_execution_stack_number;
			from
				start;
				i := 1
			until
				after
			loop
				if i = stack_num then
					!! cs.make_selected (i);
				else
					!! cs.make (i);
				end;
				st.add (cs)
				item.display_feature (st);
				st.add_new_line;
				forth;
				i := i + 1;
			end;
			st.add_new_line
		end;

feature {NONE} -- Initialization

	make is
			-- Fill where with the calls stack
			-- where is left empty if there is an error
		local
			call: CALL_STACK_ELEMENT
		do
debug ("DEBUGGER_TRACE")
	io.error.putstring ("%TCreating Eiffel Stack (EIFFEL_CALL_STACK)%N")
end
			error_occurred := False;
			list_make;
			from
				request_dump;
				!! call.make;
			until
				call.is_exhausted or call.error
			loop
				extend (call);
				!! call.make;
			end;
			if call.error then
				error_occurred := True;
				wipe_out;
			end;
			call := void;
				-- Convert the physical addresses received from
				-- application to hector addresses.
			from
				start;
			until
				after
			loop
				item.set_hector_addr;
				forth
			end;
debug ("DEBUGGER_TRACE")
	io.error.putstring ("%TFinished creating Eiffel Stack:%N")
end
		end;

feature {NONE} -- Externals

	request_dump is
		external 
			"C"
		end

invariant

	empty_if_error: error_occurred implies empty

end -- class EIFFEL_CALL_STACK
