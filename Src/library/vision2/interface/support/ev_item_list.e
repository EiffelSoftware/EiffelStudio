indexing
	description:
		"Base class for widgets that contain EV_ITEMs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "item, list"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST [reference G -> EV_ITEM]

inherit
	EV_ANY
		export
			{EV_ANY_HANDLER} default_create
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
		obsolete "Use `retrieve_item_by_data (some_data, True)' instead."
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
			l: ARRAYED_LIST [G]
		do
			create l.make (count)
			Result := True
			c := cursor
			from
				start
			until
				after or not Result
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

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_ITEM_LIST_I [G]
			-- Responsible for interaction with native graphics
			-- toolkit.

invariant
	parent_of_items_is_current: is_usable and then not is_empty implies parent_of_items_is_current
	items_unique: is_usable and not is_empty implies items_unique
	
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




end -- class EV_ITEM_LIST

