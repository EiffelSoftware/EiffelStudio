indexing
	description: "EiffelVision list-item container. %
				% Ms windows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_LIST_ITEM_HOLDER_IMP

inherit
	EV_ITEM_HOLDER_IMP
--		redefine
--			on_draw
--		end

feature -- Access

	ev_children: ARRAYED_LIST [EV_LIST_ITEM_IMP] is
			-- List of the children
			-- Deferred because it will be implemented in
			-- the _I classes.
		deferred
		end

	background_brush: WEL_BRUSH is
			-- Brush used to clear the list
		require
			exitst: not destroyed
		do
			!! Result.make_solid (background_color_imp)
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	add_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Add `item_imp' to the list.
		do
			insert_item (item_imp, count + 1)
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; index: INTEGER) is
			-- Insert `item_imp' at the `index' position.
		do
			ev_children.go_i_th (index - 1)
			ev_children.put_right (item_imp)
			graphical_insert_item (item_imp, index - 1)
		end

	move_item (item_imp: EV_LIST_ITEM_IMP; index: INTEGER) is
			-- Move `item_imp' to the `index' position.
		local
			bool: BOOLEAN
		do
			bool := item_imp.is_selected
			remove_item (item_imp)
			insert_item (item_imp, index)
			if bool then
				item_imp.set_selected (True)
			end
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Remove `itemm' from the list.
		local
			id: INTEGER
		do
			-- First, we remove the child from the graphical list
			id := ev_children.index_of (item_imp, 1)
			delete_string (id - 1)

			-- Then, we update ev_children.
			ev_children.go_i_th (id)
			ev_children.remove
		end

	clear_items is
			-- Remove all the elements of the combo-box.
		do
			reset_content
			clear_ev_children
		end

feature -- Basic operations

	internal_copy_list is
			-- Take an empty list and initialize all the children with
			-- the contents of `ev_children'.
		local
			list: ARRAYED_LIST [EV_LIST_ITEM_IMP]
		do
			if not ev_children.empty then
				from
					list := ev_children
					list.start
				until
					list.after
				loop
					graphical_insert_item (list.item, list.index - 1)
					list.forth
				end
			end
		end

	internal_select_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Make `item_imp' selected.
		local
			id: INTEGER
		do
			id := ev_children.index_of (item_imp, 1)
			select_item (id)
		end

	internal_deselect_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Make `item_imp' unselected.
		local
			id: INTEGER
		do
			id := ev_children.index_of (item_imp, 1)
			deselect_item (id)
		end

	internal_is_selected (item_imp: EV_LIST_ITEM_IMP): BOOLEAN is
			-- Is `item_imp' selected?
		local
			id: INTEGER
		do
			id := ev_children.index_of (item_imp, 1) - 1
			Result := is_selected (id)
		end

	internal_get_text (item_imp: EV_LIST_ITEM_IMP): STRING is
			-- Return the text of `item_imp'.
		local
			id: INTEGER
		do
			id := ev_children.index_of (item_imp, 1) - 1
			Result := i_th_text (id)
		end

	internal_set_text (item_imp: EV_LIST_ITEM_IMP; txt: STRING) is
			-- Make `txt' the text of `item_imp'.
		local
			id: INTEGER
		do
			id := ev_children.index_of (item_imp, 1) - 1
			delete_string (id)
			graphical_insert_item (item_imp, id)
		end

	internal_get_index (item_imp: EV_LIST_ITEM_IMP): INTEGER is
			-- Return the index of `item_imp' in the list.
		do
			Result := ev_children.index_of (item_imp, 1)
		end

feature {NONE} -- Implementation

	on_draw (struct: WEL_DRAW_ITEM_STRUCT) is
			-- All the items containers contain items which are
			-- pixmap container, then, we need this feature to
			-- call the `on_draw' feature of the items.
			-- In some cases, windows return -1, then we have to
			-- check before to call the paint message of the
			-- children.
		local
			id: INTEGER
		do
--			id := count
--			id := struct.item_id
--			if (id /= -1) then
--				(ev_children @ (struct.item_id + 1)).on_draw (struct)
--			end
		end

feature {EV_LIST_ITEM_IMP} -- Deferred features

	graphical_insert_item (item_imp: EV_LIST_ITEM_IMP; index: INTEGER) is
				-- Add the item to the graphical list.
		deferred
		end

	delete_string (id: INTEGER) is
		deferred
		end

	reset_content is
		deferred
		end

	select_item (id: INTEGER) is
		deferred
		end

	deselect_item (id: INTEGER) is
		deferred
		end

	is_selected (id: INTEGER): BOOLEAN is
		deferred
		end

	i_th_text (id: INTEGER): STRING is
		deferred
		end

	background_color_imp: EV_COLOR_IMP is
		deferred
		end

	foreground_color_imp: EV_COLOR_IMP is
		deferred
		end

	count: INTEGER is
		deferred
		end

	clear_ev_children is
		deferred
		end

end -- class EV_LIST_ITEM_HOLDER_IMP

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
