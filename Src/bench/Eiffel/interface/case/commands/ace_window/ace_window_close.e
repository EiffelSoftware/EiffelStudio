indexing

	description: "Close the Ace Window";
	date: "$Date$";
	revision: "$Revision$"

class ACE_WINDOW_CLOSE

inherit
	EV_COMMAND

	ONCES

creation
	make


feature -- Creation

	make (a: like ace_window) is
		do
			ace_window := a
		end


feature -- Properties

	ace_window: EC_ACE_WINDOW


feature -- execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		-- execution command
	do
		ace_window.destroy
	end
		
end -- class ACE_WINDOW_CLOSE
