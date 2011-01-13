note
	description:
		"Common ancestor for EV_LIST and EV_COMBO_BOX."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "list, list_item"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_LIST_ITEM_LIST

inherit
	EV_PRIMITIVE
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_ITEM_LIST [EV_LIST_ITEM]
		redefine
			implementation,
			is_in_default_state
		end

	EV_ITEM_PIXMAP_SCALER
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_LIST_ITEM_LIST_ACTION_SEQUENCES
		undefine
			is_equal
		redefine
			implementation
		end

feature {NONE} -- Initialization

	make_with_strings (a_string_array: INDEXABLE [READABLE_STRING_GENERAL, INTEGER])
			-- Create with an item for each of `a_string_array'.
		do
			default_create
			set_strings (a_string_array)
		ensure
			items_created: count = strings.count
		end

feature -- Access

	selected_item: detachable EV_LIST_ITEM
			-- Currently selected item.
			-- Topmost selected item if multiple items are selected.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_item
		ensure
			bridge_ok: Result = implementation.selected_item
		end

	strings: LINKED_LIST [STRING_32]
			-- Representation of `Current'.
		require
			not_destroyed: not is_destroyed
		local
			c: CURSOR
		do
			create Result.make
			c := cursor
			from start until after loop
				Result.extend (item.text.twin)
				forth
			end
			go_to (c)
		ensure
			not_void: Result /= Void
			same_size: Result.count = count
		end

	strings_8: ARRAYED_LIST [STRING]
			-- Representation of `Current' as STRING_8.
			-- Conversion is done using `as_string_8', thus some data
			-- might be lost.
		require
			not_destroyed: not is_destroyed
		local
			c: CURSOR
		do
			create Result.make (count)
			c := cursor
			from start until after loop
				Result.extend (item.text.twin.as_string_8)
				forth
			end
			go_to (c)
		ensure
			not_void: Result /= Void
			same_size: Result.count = count
		end

feature -- Status setting

	remove_selection
			-- Ensure there is no `selected_item'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.clear_selection
		ensure
			not_selected: selected_item = Void
		end

	set_strings (a_string_array: INDEXABLE [READABLE_STRING_GENERAL, INTEGER])
			-- Wipe out and re-initialize with an item
			-- for each of `a_string_array'.
		require
			not_destroyed: not is_destroyed
			a_string_array_not_void: a_string_array /= Void
		local
			i, nb: INTEGER
			l_set: INTEGER_INTERVAL
			li: EV_LIST_ITEM
		do
			wipe_out
			l_set := a_string_array.index_set
			from
				i := l_set.lower
				nb := l_set.upper
			until
				i > nb
			loop
				create li.make_with_text (a_string_array.item (i))
				extend (li)
				i := i + 1
			end

		ensure
			items_created: count = strings.count
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and Precursor {EV_ITEM_LIST}
		end

feature -- Contract support

	is_parent_recursive (a_list_item: EV_LIST_ITEM): BOOLEAN
			-- Is `a_list_item' a parent of `Current'?
		do
				-- As we cannot insert a EV_LIST or EV_COMBO_BOX into
				-- an EV_LIST_ITEM, it cannot be True.
			Result := False
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_LIST_ITEM_LIST_I;
			-- Responsible for interaction with native graphics toolkit.

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




end -- class EV_LIST_ITEM_LIST











