indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_TOOLTIP_CMD

inherit
	MEL_COMMAND

feature -- execution

	execute (arg: ANY) is
		local
			cbs:MEL_TEXT_VERIFY_CALLBACK_STRUCT
		do	
			cbs ?= callback_struct
			if cbs /= Void then
				if cbs.event = Void then
					cbs.unset_do_it
				end
			end
		end

end -- class DEBUG_TOOLTIP_CMD
