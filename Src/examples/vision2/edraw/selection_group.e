note
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

create
	default_create
create {EV_MODEL_GROUP}
	list_make

feature -- Access

	selected_item: detachable EV_MODEL
			-- The selected figure itself.

feature -- Element change

	set_selected_item (a_selected_item: EV_MODEL)
			-- Set `selected_item' to `a_selected_item'.
		do
			wipe_out
			selected_item := a_selected_item
			extend (a_selected_item)
			select_item
		ensure
			selected_item_assigned: selected_item = a_selected_item
		end

feature {NONE} -- Implementation

	select_item
			-- Add the graphics indicating that `handle' is selected.
		local
			bbox: EV_RECTANGLE
			manip: MANIPULATION_HANDLER
			l_item: like selected_item
		do
			bbox := bounding_box

			l_item := selected_item
			check l_item /= Void end
			create manip.make (l_item)
			manip.set_point_position (l_item.x, l_item.y)
			extend (manip)
		ensure
			first_not_moved: first = old first
		end

note
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
