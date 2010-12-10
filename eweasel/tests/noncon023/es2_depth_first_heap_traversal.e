note
	description: "Summary description for {ES2_DEPTH_FIRST_OBJECT_GRAPH_TRAVERSAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES2_DEPTH_FIRST_HEAP_TRAVERSAL

inherit
	ES2_HEAD_TRAVERSAL_STRATEGY

create
	make

feature {NONE} -- Factory

	new_dispenser: ARRAYED_STACK [ANY]
			-- <Precursor>
		do
			create Result.make (default_dispenser_size)
		end

end
