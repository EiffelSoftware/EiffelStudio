indexing
	description: "Command used to create an editor when %
				% control-right-clicking."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CREATE_EDITOR 

inherit

	COMMAND

	SHARED_MODE
		rename
			current_mode as editing_or_executing_mode
		end

	MODE_CONSTANTS

feature {NONE}

	execute (argument: ANY) is
		local
			ds: DRAG_SOURCE
			ed: EDITABLE
		do
			if editing_or_executing_mode = Editing_mode then
				ds ?= argument
				if ds.stone /= Void then
					ed ?= ds.stone.data
					if ed /= Void then
						ed.create_editor
					end
				end
			end
		end

end
