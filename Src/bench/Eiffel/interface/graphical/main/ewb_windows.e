indexing

	description: 
		"Root cluster for eiffelbench under Windows.";
	date: "$Date$";
	revision: "$Revision$"

class EWB_WINDOWS

inherit
	EWB
		redefine
			init_toolkit
		end;

	COMMAND

creation
	make

feature {NONE}

	init_toolkit: EBENCH_MS_WINDOWS is
		once
			!!Result.make ("ISE EiffelBench")
		end;

	create_handler is
		local
			delay: INTEGER
		do
			delay := Configure_resources.get_pos_integer 
						(r_Windows_timer_delay, 10)
			if delay < 5 or else delay > 200 then	
				delay := 10
			end;
				-- FIXME need to pass delay as a extra argument
			win_ioh_make_client ($call_back, Current, delay) 
		end;

	call_back is
			-- Call the command.
		do
			execute (Current)	
		end

feature {NONE} -- Externals

	win_ioh_make_client (cb: POINTER; obj: like Current; delay: INTEGER) is
			-- Make the io handler function
		external
			"C"
		end

end -- class EWB_WINDOWS
