indexing

	description:
		"Command to apply changes in resources immediately, %
		%don't save them.";
	date: "$Date$";
	revision: "$Revision$"

class APPLY_PREF_CMD

inherit
	PREFERENCE_COMMAND

create
	make

feature {PREFERENCE_COMMAND} -- Execution

	execute (argument: ANY) is
			-- Execute Current
		do
			tool.validate_all;
			if tool.is_valid then
				tool.apply_changes
			end
		end

end -- class APPLY_PREF_CMD
