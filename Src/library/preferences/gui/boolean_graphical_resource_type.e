indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOOLEAN_GRAPHICAL_RESOURCE_TYPE

inherit
	BOOLEAN_RESOURCE_TYPE

	GRAPHICAL_RESOURCE_TYPE

create
	make

feature -- Access

	edition_box (caller: PREFERENCE_WINDOW): BOOLEAN_SELECTION_BOX is
			-- Widget that lets the user edit resources.
		do
			create Result.make (caller)
		end


end -- class BOOLEAN_GRAPHICAL_RESOURCE_TYPE
