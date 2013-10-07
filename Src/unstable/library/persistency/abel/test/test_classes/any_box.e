note
	description: "Summary description for {ANY_BOX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ANY_BOX
create
	set_item

feature

	item: ANY

	set_item (an_item: ANY)
		do
			item := an_item
		end

end
