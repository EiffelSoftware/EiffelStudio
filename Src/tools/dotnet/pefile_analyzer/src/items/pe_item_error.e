note
	description: "Summary description for {PE_ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_ITEM_ERROR

inherit
	PE_ERROR
		rename
			make as make_error
		redefine
			to_string
		end

create
	make

feature -- Initialization

	make (m: STRING; a_item: PE_ITEM)
		do
			pe_item := a_item
			make_error (m)
		end

feature -- Access

	pe_item: PE_ITEM

	to_string: READABLE_STRING_8
		do
			Result := "/" + pe_item.label + "/: " + Precursor
		end

end
