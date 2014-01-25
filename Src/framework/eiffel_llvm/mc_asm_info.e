note
	description: "Summary description for {MC_ASM_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MC_ASM_INFO

create

	make_from_pointer

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

feature

	item: POINTER

feature {NONE}

	
end
