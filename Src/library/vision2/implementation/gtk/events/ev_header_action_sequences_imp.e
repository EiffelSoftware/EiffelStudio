indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_ACTION_SEQUENCES_IMP

inherit
	EV_HEADER_ACTION_SEQUENCES_I

feature -- Access

	create_item_resize_actions: EV_HEADER_ITEM_ACTION_SEQUENCE is
			-- Create an item resize actions.
		do
			create Result
		end
		
	create_item_resize_start_actions: EV_HEADER_ITEM_ACTION_SEQUENCE is
			-- Create an item resize start actions.
		do
			create Result
		end
		
	create_item_resize_end_actions: EV_HEADER_ITEM_ACTION_SEQUENCE is
			-- Create an item resize end actions.
		do
			create Result
		end

invariant
	invariant_clause: True -- Your invariant here

end
