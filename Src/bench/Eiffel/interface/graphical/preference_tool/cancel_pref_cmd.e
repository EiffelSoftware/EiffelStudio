indexing

	description:
		"Command to cancel changes in resources.";
	date: "$Date$";
	revision: "$Revision$"

class CANCEL_PREF_CMD

inherit
	PREFERENCE_COMMAND

creation
	make

feature -- Properties

	name: STRING is "Cancel"

feature {NONE} -- Useless

	symbol: PIXMAP is
		do
			check
				do_not_call: false
			end
		end;

	dark_symbol: PIXMAP is
		do
			check
				do_not_call: false
			end
		end

feature {PREEFERENCE_COMMAND} -- Execution

	execute (argument: ANY) is
			-- Execute Current
		do
			if tool /= Void then
				tool.close
			end
		end

end -- class CANCEL_PREF_CMD
