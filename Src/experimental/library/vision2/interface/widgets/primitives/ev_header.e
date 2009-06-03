note
	description: "Objects that represent an EiffelVision header control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER

inherit
	EV_PRIMITIVE
		undefine
			is_equal
		redefine
			is_in_default_state,
			is_in_default_state_for_tabs,
			implementation
		end

	EV_ITEM_LIST [EV_HEADER_ITEM]
		redefine
			is_in_default_state,
			implementation
		end

	EV_FONTABLE
		undefine
			is_equal
		redefine
			is_in_default_state,
			implementation
		end

	EV_ITEM_PIXMAP_SCALER
		undefine
			is_equal
		redefine
			is_in_default_state,
			implementation
		end

	EV_HEADER_ACTION_SEQUENCES
		undefine
			is_equal
		redefine
			implementation
		end

feature -- Access

	item_x_offset (an_item: EV_HEADER_ITEM): INTEGER
			-- `Result' is x position of `an_item' in relation to `Current'.
		require
			not_is_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			Result := implementation.item_x_offset (an_item)
		ensure
			result_non_negative: Result >= 0
		end

	pointed_divider_index: INTEGER
			-- Index of divider currently beneath the mouse pointer, or
			-- 0 if none.
		require
			not_is_destroyed: not is_destroyed
		do
			Result := implementation.pointed_divider_index
		ensure
			result_non_negative: Result >= 0
		end

feature -- Contract support

	is_parent_recursive (a_list_item: EV_HEADER_ITEM): BOOLEAN
			-- Is `a_list_item' a parent of `Current'?
		do
			Result := False
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and Precursor {EV_ITEM_LIST} and
				Precursor {EV_FONTABLE} and Precursor {EV_ITEM_PIXMAP_SCALER}
		end

	is_in_default_state_for_tabs: BOOLEAN
		do
			Result := not is_tabable_from and not is_tabable_to
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_HEADER_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_HEADER_IMP} implementation.make (Current)
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




end -- class EV_HEADER

