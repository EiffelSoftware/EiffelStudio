indexing

	description: 	
		"Updates the currently pointed workarea.";
	date: "$Date$";
	revision: "$Revision $"

class SET_POINTED_WORKAREA_COM

inherit

	EC_COMMAND;
	ONCES

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the pointed workarea.
		local
			workarea: WORKAREA
		do
		--	workarea ?= arg;
		--	Windows.screen.set_pointed_workarea (workarea)
		end

end -- class SET_POINTED_WORKAREA_COM
