indexing

	description: 
		"Root cluster for eiffelbench under motif.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_MOTIF

inherit
	EWB_UNIX
		redefine
			init_toolkit
		end;
	MEL_CALLBACK;
	INTERFACE_W
	
creation
	make

feature {NONE} -- Initialization

	init_toolkit: MOTIF is once !!Result.make (l_X_resourse_name) end;

feature -- Communications

    listen_to: RAW_FILE;
			-- File used to listen 

    create_handler is
		local
			app_context: MEL_APPLICATION_CONTEXT
        do
                -- Associate the file descriptor corresponding
                -- to the pipe on which reading is done
                -- with `listen_to'.
            !!listen_to.make ("toto");
            listen_to.fd_open_read (Listen_to_const);
			app_context := init_toolkit.application_context;
                -- Add an IO handler which
                -- listens to the appropriate
                -- pipe.
                -- Set `Current' as callback to be called
                -- when there is something new to read on
                -- the `Listen_to_const' pipe.
			app_context.add_input_read_callback (listen_to, Current, Void)
        end;

end -- class EWB_MOTIF
