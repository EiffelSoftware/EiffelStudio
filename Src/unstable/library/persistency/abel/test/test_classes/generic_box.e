note
	description: "Summary description for {GENERIC_BOX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GENERIC_BOX [G,H]

inherit
	ANY
	redefine
		default_create
	end

create
	default_create, set_item

feature

	item1: detachable G

	item2: detachable H

	set_item (an_item_1: G; an_item_2: H)
		do
			item1 := an_item_1
			item2 := an_item_2
		end

feature {NONE} -- Initialization

	default_create
		do
			item1 := ({G}).default_detachable_value
			item2 := ({H}).default_detachable_value
		end

end
