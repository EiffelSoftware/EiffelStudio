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
		redefine
			on_draw
		end

feature -- Access

	ev_children: LINKED_LIST [EV_LIST_ITEM_IMP] is
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
			-- Add `item_imp' to the list
		do
			ev_children.extend (item_imp)
			add_string (item_imp.text)
			item_imp.set_id (ev_children.count - 1)
		end

	remove_item (an_id: INTEGER) is
			-- Remove the child whose id is `id'.
		do
			delete_string (an_id)
			ev_children.go_i_th (an_id + 1)
			ev_children.remove
			from
			until
				ev_children.after
			loop
				ev_children.item.set_id (ev_children.index - 1)
				ev_children.forth
			end
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
			id := count
			id := struct.item_id
			if (id /= -1) then
				(ev_children @ (struct.item_id + 1)).on_draw (struct)
			end
		end

feature {EV_LIST_ITEM_IMP} -- Deferred features

	add_string (str: STRING) is
		deferred
		end

	insert_string_at (str: STRING; id: INTEGER) is
		deferred
		end

	delete_string (id: INTEGER) is
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
