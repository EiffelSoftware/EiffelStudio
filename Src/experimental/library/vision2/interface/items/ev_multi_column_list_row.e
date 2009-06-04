note
	description:
		"[
			Row item for use in EV_MULTI_COLUMN_LIST
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "multi column list, row, item, select"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW

inherit
	EV_ITEM
		undefine
			copy, is_equal
		redefine
			implementation,
			is_in_default_state
		select
			default_create
		end

	INTERACTIVE_LIST [STRING_32]
		rename
			default_create as interactive_list_make
		redefine
			on_item_added_at,
			on_item_removed_at,
			make_filled, array_make
		end

	EV_DESELECTABLE
		undefine
			initialize, copy, is_equal
		redefine
			implementation,
			is_in_default_state
		end

	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES
		undefine
			copy, is_equal
		redefine
			implementation
		end

create
	default_create

create {EV_MULTI_COLUMN_LIST_ROW}
	make_filled

feature {NONE} -- Initialization

	make_filled (n: INTEGER_32)
			-- <Precursor>
		do
			default_create
			Precursor (n)
		end

	array_make (min_index, max_index: INTEGER_32)
			-- <Precursor>
		do
			default_create
			Precursor (min_index, max_index)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ITEM} and Precursor {EV_DESELECTABLE}
		end

feature -- Element change

	fill_with_strings_8 (other: CONTAINER [STRING])
			-- Fill with as many items of `other' as possible.
			-- The representations of `other' and current structure
			-- need not be the same.
		local
			lin_rep: LINEAR [STRING]
			l_cursor: CURSOR
		do
			lin_rep := other.linear_representation
			from
				l_cursor := cursor
				lin_rep.start
			until
				not extendible or else lin_rep.off
			loop
				extend (lin_rep.item)
				finish
				lin_rep.forth
			end
			go_to (l_cursor)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_MULTI_COLUMN_LIST_ROW_I
			-- Responsible for interaction with native graphics toolkit.

feature {EV_ANY_I} -- Implementation

	on_item_added_at (an_item: like item; item_index: INTEGER)
			-- `an_item' is about to be added.
		do
			implementation.on_item_added_at (an_item, item_index)
		end

	on_item_removed_at (an_item: like item; item_index: INTEGER)
			-- `an_item' is about to be removed.
		do
			implementation.on_item_removed_at (an_item, item_index)
		end

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make
			interactive_list_make
		end

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
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




end -- class EV_MULTI_COLUMN_LIST_ROW








