indexing

	description:
		"Command to apply and save changes in the resources."
	date: "$Date$"
	revision: "$Revision$"

class EB_OK_PREFERENCE_COMMAND

inherit
	EB_PREFERENCE_COMMAND

creation
	make

feature {NONE} -- Useless

	symbol: PIXMAP is
		do
			check
				do_not_call: false
			end
		end

feature {EB_PREFERENCE_COMMAND} -- Execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current
		do
			tool.validate_all
			if tool.is_all_valid then
				tool.apply_changes
				tool.save_cmd.execute (close_it, data)
-- not availible now!
			end
		end

feature {NONE} -- Execution arguments

	close_it: EV_ARGUMENT1 [ANY] is
		once
			Create Result.make (void)
		end

end -- class EB_OK_PREFERENCE_COMMAND
