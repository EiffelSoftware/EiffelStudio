indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SINGLE_ARRAY_ITEM_GRAPHICAL_RESOURCE_TYPE

inherit
	SINGLE_ARRAY_ITEM_RESOURCE_TYPE
		select
			xml_name
		end

	GRAPHICAL_RESOURCE_TYPE

create
	make

feature -- Access

	edition_box (caller: PREFERENCE_WINDOW): SINGLE_TEXT_SELECTION_BOX is
			-- Widget that lets the user edit resources.
		do
			create Result.make (caller)
		end

end -- class BOOLEAN_GRAPHICAL_RESOURCE_TYPE
