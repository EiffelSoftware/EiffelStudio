indexing

	description: 
		"Root cluster for eiffelbench under motif.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_MOTIF

inherit
	EWB
		redefine
			init_toolkit
		end;
	MEL_COMMAND;
	EB_CONSTANTS
	
creation
	make

feature {NONE} -- Initialization

	init_toolkit: TOOLKIT_IMP is
		once
			!!Result.make (Interface_names.n_X_resource_name)
		end;

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
			app_context.set_input_read_callback (listen_to, Current, Void)
        end;

end -- class EWB_MOTIF
