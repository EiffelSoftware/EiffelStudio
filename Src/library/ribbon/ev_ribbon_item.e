note
	description: "Abstract representation of an item of a ribbon."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_ITEM

feature -- Query

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current
		deferred
		end
		
end
