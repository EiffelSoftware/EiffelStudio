indexing

	description:
		"Command to cancel changes in resources.";
	date: "$Date$";
	revision: "$Revision$"

class CANCEL_PREF_CMD

inherit
	PREFERENCE_COMMAND

create
	make

feature {PREEFERENCE_COMMAND} -- Execution

	execute (argument: ANY) is
			-- Execute Current
		do
			if tool /= Void then
				tool.close
			end
		end

end -- class CANCEL_PREF_CMD
