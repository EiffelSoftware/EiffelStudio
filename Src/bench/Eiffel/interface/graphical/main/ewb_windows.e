indexing

	description: 
		"Root cluster for eiffelbench under Windows.";
	date: "$Date$";
	revision: "$Revision $"

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

	init_toolkit: MS_WINDOWS is
		once
			!!Result.make ("ebench")
		end;

	create_handler is
		do
print ("toto%N")
			win_ioh_make_client ($call_back, Current)
print ("toto2%N")
		end;

	call_back is
			-- Call the command.
		do
print ("toto3%N")
			execute (Current)	
print ("toto4%N")
		end

feature {NONE} -- Externals

	win_ioh_make_client (cb: POINTER; obj: like Current) is
			-- Make the io handler function
		external
			"C"
		end

end -- class EWB_WINDOWS
