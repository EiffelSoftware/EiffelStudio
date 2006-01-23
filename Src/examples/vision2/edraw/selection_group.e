indexing
	description: "Objects that contains a selected item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SELECTION_GROUP
