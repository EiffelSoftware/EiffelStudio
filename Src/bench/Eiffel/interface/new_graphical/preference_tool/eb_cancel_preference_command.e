indexing

	description:
		"Command to cancel changes in resources."
	date: "$Date$"
	revision: "$Revision$"

class EB_CANCEL_PREFERENCE_COMMAND

inherit
	EB_PREFERENCE_COMMAND
		redefine
			execute
		end

creation
	make

feature {EB_PREFERENCE_COMMAND} -- Execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current
		do
			if tool /= Void then
				tool.destroy
			end
		end

end -- class EB_CANCEL_PREFERENCE_COMMAND
