note
	description: "Summary description for {TARGET_ASM_BACKEND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_ASM_BACKEND

create

	make_from_pointer

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

feature

	item: POINTER
end
