note
	description: "Summary description for {ES2_BREADTH_FIRST_HEAP_TRAVERSAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES2_BREADTH_FIRST_HEAP_TRAVERSAL

inherit
	ES2_HEAD_TRAVERSAL_STRATEGY

create
	make

feature {NONE} -- Factory

	frozen new_dispenser: ARRAYED_QUEUE [ANY]
			-- <Precursor>
		do
			create Result.make (default_dispenser_size)
		end

end
