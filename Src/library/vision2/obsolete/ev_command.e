deferred class
	EV_COMMAND 

feature -- Basic operations

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is deferred end

feature {EV_EVENT_HANDLER_IMP, EV_TIMEOUT_IMP} -- Implementation

	execute_address: POINTER is do end

	routine_address (routine: POINTER): POINTER is do end

end -- class EV_COMMAND
