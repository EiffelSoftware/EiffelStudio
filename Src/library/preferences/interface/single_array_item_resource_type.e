indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SINGLE_ARRAY_ITEM_RESOURCE_TYPE

inherit
	ARRAY_RESOURCE_TYPE
		redefine
			xml_name
		end

create
	make

feature -- Access

	xml_name: STRING is "LIST_SELECTED_STRING"
			
end -- class SINGLE_ARRAY_ITEM_RESOURCE_TYPE
