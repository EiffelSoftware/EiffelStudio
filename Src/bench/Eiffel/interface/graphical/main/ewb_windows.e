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

	IO_HANDLER
		rename
			make as io_handler_create
		export
			{NONE} all
		redefine
			init_toolkit
		end
	COMMAND

creation
	make

feature {NONE}

	init_toolkit: MS_WINDOWS is
		once
			!!Result.make ("ebench")
		end;

feature 

	create_handler is
		do
			io_handler_create
			set_read_call_back (Void, Current, Current)
		end;

end
