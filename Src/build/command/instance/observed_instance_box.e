indexing
	description: "A box to list observed instances of a command instance."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	OBSERVED_INSTANCE_BOX

inherit
	OBSERVER_BOX
		redefine
			new_icon
		end

creation
	make

feature {NONE}

	new_icon: OBSERVED_INSTANCE_ICON

end -- class OBSERVED_INSTANCE_BOX
