indexing

	description:
		"Command to apply changes in resources immediately, %
		%don't save them."
	date: "$Date$"
	revision: "$Revision$"

class EB_APPLY_PREFERENCE_COMMAND

inherit
	EB_PREFERENCE_COMMAND

creation
	make

feature {EB_PREFERENCE_COMMAND} -- Execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current
		do
			tool.validate_all
			if tool.is_all_valid then
				tool.apply_changes
			end
		end

end -- class EB_APPLY_PREFERENCE_COMMAND
