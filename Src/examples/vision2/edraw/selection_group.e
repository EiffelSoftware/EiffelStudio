indexing
	description: "Objects that contains a selected item."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SELECTION_GROUP

inherit
	EV_MODEL_GROUP
	
feature -- Access

	selected_item: EV_MODEL
			-- The selected figure itself.

feature -- Element change

	set_selected_item (a_selected_item: like selected_item) is
			-- Set `selected_item' to `a_selected_item'.
		require
			a_selected_item_not_Void: a_selected_item /= Void
		do
			wipe_out
			selected_item := a_selected_item
			extend (selected_item)
			select_item
		ensure
			selected_item_assigned: selected_item = a_selected_item
		end
		
feature {NONE} -- Implementation

	select_item is
			-- Add the graphics indicating that `handle' is selected.
		local
			bbox: EV_RECTANGLE
			manip: MANIPULATION_HANDLER
		do
			bbox := bounding_box
			
			create manip.make (selected_item)
			manip.set_point_position (selected_item.x, selected_item.y)
			extend (manip)
		ensure
			first_not_moved: first = old first
		end

end -- class SELECTION_GROUP
