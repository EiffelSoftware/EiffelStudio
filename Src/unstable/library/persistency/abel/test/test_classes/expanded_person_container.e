note
	description: "Summary description for {EXPANDED_PERSON_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXPANDED_PERSON_CONTAINER

create
	set_item

feature

	person: EXPANDED_PERSON

	integer: INTEGER

	item: ANY

	set_item (an_item: ANY)
		do
			item := an_item
		end

end
