indexing

	description:
		"Callback routines to handle events from WARNER_W.";
	date: "$Date$";
	revision: "$Revision$"

deferred class WARNER_CALLBACKS

feature -- Callbacks

	execute_warner_help is
		deferred
		end;

	execute_warner_ok (argument: ANY) is
		deferred
		end;

end -- class WARNER_CALLBACKS
