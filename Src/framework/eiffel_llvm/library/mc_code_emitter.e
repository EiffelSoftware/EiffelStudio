note
	description: "Summary description for {MC_CODE_EMITTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MC_CODE_EMITTER

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
