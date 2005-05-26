indexing
	description: "Objects that represent an EiffelVision header control."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER
	
inherit
	EV_PRIMITIVE
		undefine
			is_in_default_state,
			is_equal
		redefine
			implementation
		end
		
	EV_ITEM_LIST [EV_HEADER_ITEM]
		undefine
			is_in_default_state
		redefine
			implementation
		end
		
	EV_FONTABLE
		undefine
			is_in_default_state,
			is_equal
		redefine
			implementation
		end
		
	EV_ITEM_PIXMAP_SCALER
		undefine
			is_equal,
			is_in_default_state
		redefine
			implementation
		end
		
	EV_HEADER_ACTION_SEQUENCES
		undefine
			is_equal
		redefine
			implementation
		end

feature -- Access

	item_x_offset (an_item: EV_HEADER_ITEM): INTEGER is
			-- `Result' is x position of `an_item' in relation to `Current'.
		require
			not_is_destroyed: not is_destroyed
			has_an_item: has (an_item)
		do
			Result := implementation.item_x_offset (an_item)
		ensure
			result_non_negative: Result >= 0
		end

	pointed_divider_index: INTEGER is
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

	is_parent_recursive (a_list_item: EV_HEADER_ITEM): BOOLEAN is
			-- Is `a_list_item' a parent of `Current'?
		do
			Result := False
		end
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and Precursor {EV_ITEM_LIST} and
				Precursor {EV_FONTABLE} and Precursor {EV_ITEM_PIXMAP_SCALER}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_HEADER_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_HEADER_IMP} implementation.make (Current)
		end

end -- class EV_HEADER

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
