--| FIXME NOT_REVIEWED this file has not been reviewed
indexing	
	description: "Eiffel Vision list item list. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_LIST_ITEM_LIST_IMP

inherit
	EV_ITEM_LIST_IMP [EV_LIST_ITEM]

feature {EV_LIST_ITEM_IMP} -- Implementation

	index_of_item_imp (li_imp: EV_LIST_ITEM_IMP): INTEGER is
			-- Index of `li_imp' in `ev_children'.
		require
			li_imp_not_void: li_imp /= Void
			ev_children_has_li_imp: ev_children.has (li_imp)
		do
			Result := ev_children.index_of (li_imp, 1)
		ensure
			Result_within_bounds:
				Result > 0 and then Result <= ev_children.count
			correct_index:
				(ev_children @ Result) = li_imp
		end

	is_item_imp_selected (li_imp: EV_LIST_ITEM_IMP): BOOLEAN is
			-- Is `li_imp' selected?
		require
			li_imp_not_void: li_imp /= Void
			ev_children_has_li_imp: ev_children.has (li_imp)
		deferred
		end

	select_item_imp (li_imp: EV_LIST_ITEM_IMP) is
			-- Set `li_imp' selected.
		require
			li_imp_not_void: li_imp /= Void
			ev_children_has_li_imp: ev_children.has (li_imp)
		deferred
		ensure
			li_imp_selected: li_imp.is_selected
		end

	deselect_item_imp (li_imp: EV_LIST_ITEM_IMP) is
			-- Set `li_imp' deselected.
		require
			li_imp_not_void: li_imp /= Void
			ev_children_has_li_imp: ev_children.has (li_imp)
		deferred
		ensure
			li_imp_deselected: not li_imp.is_selected
		end

	set_item_imp_text (li_imp: EV_LIST_ITEM_IMP; a_text: STRING) is
			-- Set `li_imp'.`text' to `a_text'.
		require
			li_imp_not_void: li_imp /= Void
			ev_children_has_li_imp: ev_children.has (li_imp)
			a_text_not_void: a_text /= Void
		deferred
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	set_pointer_style (c: EV_CURSOR) is
			-- Assign `c' to `parent_imp' pointer style.
		deferred
		end

	top_index: INTEGER is
			-- Index of item at displayed at top of list.
		deferred
		end

	item_height: INTEGER is
			-- Height in pixels of each list item.
		deferred
		end

	internal_copy_list is
			-- Take an empty list and initialize all the children with
			-- the contents of `ev_children'.
		local
			original_index: INTEGER
			li_imp: EV_LIST_ITEM_IMP
		do
			original_index := ev_children.index
			from
				ev_children.start
			until
				ev_children.after
			loop
				li_imp ?= ev_children.item
				add_string (li_imp.wel_text)
				ev_children.forth
			end
			ev_children.go_i_th (original_index)
		ensure
			index_not_changed: index = old index
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; an_index: INTEGER) is
			-- Insert `item_imp' at `an_index'.
		do
		--	ev_children.go_i_th (an_index - 1)
		--	ev_children.put_right (item_imp)
			insert_string_at (item_imp.wel_text, an_index - 1)
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Remove `item_imp'.
		local
			pos: INTEGER
		do
			pos := index_of_item_imp (item_imp)
			delete_string (pos - 1)
		--	ev_children.go_i_th (pos)
		--	ev_children.remove
		end

feature {NONE} -- Implementation

	insert_string_at (a_string: STRING; an_index: INTEGER) is
			-- Add `a_string' at the zero-based `index'.
		deferred
		end

	delete_string (an_index: INTEGER) is
			-- Delete the zero-based `index' item.
		deferred
		end

	add_string (a_string: STRING) is
			-- Add `a_string' in the list box.
			-- If the list box does not have the
			-- `Lbs_sort' style, `a_string' is added
			-- to the end of the list otherwise it is
			-- inserted into the list and the list is
			-- sorted.
		deferred
		end

end -- class EV_LIST_ITEM_LIST_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2000/04/05 21:16:11  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.2.2.1  2000/04/05 19:53:31  brendel
--| Removed calls to ev_children by graphical insert/remove features.
--|
--| Revision 1.2  2000/03/30 18:10:32  brendel
--| Added deferred features `top_index', `item_height' and
--| `set_pointer_style'.
--|
--| Revision 1.1  2000/03/30 17:31:58  brendel
--| New class as common list ancestor for EV_LIST_IMP and EV_COMBO_BOX_IMP.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

