indexing
	description:
		"Base class for widgets that contain EV_ITEMs"
	status: "See notice at end of class."
	keywords: "item, list"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST [G -> EV_ITEM]

inherit
	EV_ANY
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_DYNAMIC_LIST [G]
		redefine
			implementation,
			is_in_default_state
		end

feature -- Access

	item_by_data (some_data: ANY): like item is
			-- First item with `some_data'.
		require
			not_destroyed: not is_destroyed
			data_not_void: some_data /= Void
		do
			Result := implementation.item_by_data (some_data)
		ensure
			bridge_ok: Result = implementation.item_by_data (some_data)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_DYNAMIC_LIST}
		end

feature {NONE} -- Contract support

	parent_of_items_is_current: BOOLEAN is
			-- Do all items have parent `Current'?
		require
			not_destroyed: not is_destroyed
		local
			c: CURSOR
			item_par: EV_ITEM_LIST [G]
		do
			Result := True
			c := cursor
			from
				start
			until
				after or Result = False
			loop
				item_par ?= item.parent
				if item_par /= Current then
					Result := False
				end
				forth
			end
			go_to (c)
		end

	items_unique: BOOLEAN is
			-- Are all items unique?
			-- (ie Are there no duplicates?)
		require
			not_destroyed: not is_destroyed
		local
			c: CURSOR
			l: LINKED_LIST [G]
		do
			create l.make
			Result := True
			c := cursor
			from
				start
			until
				after or Result = False
			loop
				if l.has (item) then
					Result := False
				end
				l.extend (item)
				forth
			end
			go_to (c)
		end

	lists_equal (list1, list2: DYNAMIC_LIST [G]): BOOLEAN is
			-- Are elements in `list1' equal to those in `list2'.
		require
			not_destroyed: not is_destroyed
			list1_not_void: list1 /= Void
			list2_not_void: list2 /= Void
		local
			cur1, cur2: CURSOR
		do
			if list1 = list2 then
				Result := True
			else
				if list1.count = list2.count then
					from
						cur1 := list1.cursor
						cur2 := list2.cursor
						list1.start
						list2.start
						Result := True
					until
						list1.after or else Result = False
					loop
						Result := list1.item = list2.item
						list1.forth
						list2.forth
					end
					list1.go_to (cur1)
					list2.go_to (cur2)
				end
			end
		end

feature -- Implementation

	changeable_comparison_criterion: BOOLEAN is False
			-- May `object_comparison' be changed?
			-- (Answer: no by default.

feature {EV_ANY_I} -- Implementation

	implementation: EV_ITEM_LIST_I [G]
			-- Responsible for interaction with native graphics
			-- toolkit.

invariant
	parent_of_items_is_current: is_usable implies parent_of_items_is_current
	items_unique: is_usable implies items_unique
	
end -- class EV_ITEM_LIST

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------
