note
	description: "Summary description for {PE_ITEM_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_ITEM_INFO

create
	make,
	make_link

feature {NONE} -- Initialization

	make (a_representation: READABLE_STRING_GENERAL)
		do
			create text.make_from_string (a_representation)
		end

	make_link (a_ref: READABLE_STRING_GENERAL)
		do
			create text.make_from_string (a_ref)
			is_link := True
		end

feature -- Access

	text: IMMUTABLE_STRING_32

	is_link: BOOLEAN

invariant

end
