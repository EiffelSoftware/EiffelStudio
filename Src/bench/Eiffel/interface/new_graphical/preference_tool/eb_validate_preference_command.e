indexing
	description	: "Command to validate all changes made to resources."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_VALIDATE_PREFERENCE_COMMAND

inherit
	EB_PREFERENCE_COMMAND

creation
	make

feature {EB_PREFERENCE_COMMAND} -- Execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current
		local
			pl: LINKED_LIST [EB_ENTRY_PANEL]
		do
			if tool /= Void then
				pl := tool.panel_list
				from
					pl.start
				until
					pl.after
				loop
					pl.item.validate
					pl.forth
				end
			end
		end

end -- class EB_VALIDATE_PREFERENCE_COMMAND
