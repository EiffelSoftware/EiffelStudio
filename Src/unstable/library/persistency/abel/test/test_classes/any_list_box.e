note
	description: "Summary description for {ANY_LIST_BOX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ANY_LIST_BOX

create
	set_items

feature

	items: LINKED_LIST [ANY]

	set_items (an_item: LINKED_LIST [ANY])
		do
			items := an_item
		end


end
