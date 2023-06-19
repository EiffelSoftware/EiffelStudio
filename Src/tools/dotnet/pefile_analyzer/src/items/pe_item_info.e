note
	description: "Summary description for {PE_ITEM_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_ITEM_INFO

create
	make

feature {NONE} -- Initialization

	make (a_representation: READABLE_STRING_GENERAL)
		do
			create representation.make_from_string (a_representation)
		end

feature -- Access

	representation: IMMUTABLE_STRING_32

end
