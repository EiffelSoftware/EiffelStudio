indexing

	description:
		"Command to apply and save changes in the resources.";
	date: "$Date$";
	revision: "$Revision$"

class OK_PREF_CMD

inherit
	PREFERENCE_COMMAND

creation
	make

feature -- Properties

	name: STRING is "Ok"

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

feature {NONE} -- Execution

	execute (argument: ANY) is
			-- Execute Current
		do
			tool.validate_all;
			if tool.is_valid then
				tool.apply_changes;
				tool.save_holder.execute (close_it)
			end
		end

feature {NONE} -- Execution arguments

	close_it: ANY is
		once
			!! Result
		end

end -- class OK_PREF_CMD
