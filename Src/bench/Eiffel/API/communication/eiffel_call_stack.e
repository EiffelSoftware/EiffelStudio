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
	SHARED_RESOURCES
		export
			{NONE} all
		end

creation {RUN_INFO, APPLICATION_STATUS}

	make

feature -- Properties

	error_occurred: BOOLEAN;
			-- Did an error occurred when retrieving the eiffel stack?

feature -- Output

	display_stack (ow: OUTPUT_WINDOW) is
			-- Display callstack in `ow'.
		do
			ow.put_string ("%NCall stack:%N%N");
			ow.put_string
				("Object		  Class		  Routine%N");
			ow.put_string
				("------		  -----		  -------%N");
			from
				start
			until
				after
			loop
				item.display_feature (ow);
				ow.new_line;
				forth
			end;
			ow.new_line
		end;

feature {NONE}

	make is
			-- Fill where with the calls stack
			-- where is left empty if there is an error
		local
			call: CALL_STACK_ELEMENT
		do
if enabled_debug_trace then
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
				start
			until
				after
			loop
				item.set_hector_addr;
				forth
			end
if enabled_debug_trace then
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
