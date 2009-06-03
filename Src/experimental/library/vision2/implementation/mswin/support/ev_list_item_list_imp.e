note
	description: "Eiffel Vision list item list. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_LIST_ITEM_LIST_IMP

inherit
	EV_LIST_ITEM_LIST_I
		redefine
			interface,
			pixmaps_size_changed
		end

	EV_ITEM_LIST_IMP [EV_LIST_ITEM, EV_LIST_ITEM_IMP]
		redefine
			interface
		end

	EV_LIST_ITEM_LIST_ACTION_SEQUENCES_IMP

feature {EV_ANY_I} -- Access

	ev_children: ARRAYED_LIST [EV_LIST_ITEM_IMP]
			-- List of the children.

feature {EV_LIST_ITEM_IMP} -- Implementation

	image_list: EV_IMAGE_LIST_IMP
			-- Image list to store all images required by items.

	setup_image_list
			-- Create the image list and associate it
			-- to `Current' if not already associated.
		deferred
		end

	remove_image_list
			-- disassociate `image_list' from `Current'.
		deferred
		end

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		local
			pixmap: EV_PIXMAP
			cur: CURSOR
		do
				-- We only do this if there are images associated with
				-- `Current'.
			if image_list /= Void then

					-- Rebuild the image list.
				remove_image_list
				setup_image_list

					-- Save cursor position
				cur := ev_children.cursor

					-- Insert the image of each list item
					-- back into the image list.
				from
					ev_children.start
				until
					ev_children.after
				loop
					pixmap := ev_children.item.pixmap
					if pixmap /= Void then
						ev_children.item.set_pixmap_in_parent
					end
					ev_children.forth
				end
					-- Restore saved_position
				ev_children.go_to (cur)
			end
		ensure then
			child_index_consistent: old ev_children.index = ev_children.index
		end

	internal_is_selected (item_imp: EV_LIST_ITEM_IMP): BOOLEAN
			-- Is `item_imp' selected in the list?
		deferred
		end

	internal_deselect_item (item_imp: EV_LIST_ITEM_IMP)
			-- Deselect `item_imp' in the list.
		deferred
		end

	internal_select_item (item_imp: EV_LIST_ITEM_IMP)
			-- Select `item_imp' in the list.
		deferred
		end

	internal_get_index (item_imp: EV_LIST_ITEM_IMP): INTEGER
			-- `Result' is index of `item_imp' in the list.
		require
			item_imp_not_void: item_imp /= Void
			ev_children_has_item: ev_children.has (item_imp)
		deferred
		ensure
			Result_within_bounds:
				Result > 0 and then Result <= ev_children.count
			correct_index:
				(ev_children @ Result) = item_imp
		end

   	get_item_position (an_index: INTEGER): WEL_POINT
   			-- Retrieves the position of the zero-based `an_index'-th item.
   		deferred
   		end

feature {EV_ANY_I} -- Implementation

	set_pixmap_of_child (an_item: EV_LIST_ITEM_IMP; position, image_index: INTEGER)
			-- Set pixmap of `an_item' at position `position' in `Current'
			-- to the `image_index'th image in `image_list'.
		deferred
		end

	remove_pixmap_of_child (an_item: EV_LIST_ITEM_IMP; position: INTEGER)
			-- Remove pixmap of `an_item' located at position `position' in
			-- `Current'.
		deferred
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	top_index: INTEGER
			-- Index of item displayed at the top of `Current'.
		deferred
		end

	visible_count: INTEGER
   			-- Number of items that can be displayed at once.
		deferred
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; an_index: INTEGER)
			-- Insert `item_imp' at `an_index' position.
		deferred
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP)
			-- Remove `item_imp'.
		deferred
		end

	refresh_item (item_imp: EV_LIST_ITEM_IMP)
			-- Refresh current so that it take into account
			-- changes made in `item_imp'
		deferred
		end

feature {EV_LIST_ITEM_IMP} -- Pick & Drop

	set_pointer_style (c: EV_POINTER_STYLE)
			-- Assign `c' to `parent_imp' pointer style.
		deferred
		end

	set_capture
			-- Grab user input.
		deferred
		end

	release_capture
			-- Release user input.
		deferred
		end

	set_heavy_capture
			-- Grab user input.
		deferred
		end

	release_heavy_capture
			-- Release user input.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_LIST_ITEM_LIST;

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




end -- class EV_LIST_ITEM_LIST_IMP

