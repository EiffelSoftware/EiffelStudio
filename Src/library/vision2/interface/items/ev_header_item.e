indexing
	description: "Objects that represent EiffelVision2 header items."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_ITEM
	
inherit
	EV_ITEM
		redefine
			implementation,
			is_in_default_state
		end
		
	EV_TEXT_ALIGNABLE
		redefine
			implementation,
			is_in_default_state
		end

create
	default_create, make_with_text

feature -- Access

	width: INTEGER is
			-- `Result' is width of `Current' used
			-- while parented.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.width
		ensure
			Result_non_negative: Result >= 0
		end

feature -- Status setting

	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		require
			not_destroyed: not is_destroyed
			width_non_negative: a_width >= 0
		do
			implementation.set_width (a_width)
		ensure
			width_set: width = a_width
		end
		
	resize_to_content is
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		require
			not_destroyed: not is_destroyed
			parent_not_void: parent /= Void
		do
			implementation.resize_to_content	
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ITEM} and precursor {EV_TEXT_ALIGNABLE}
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_HEADER_ITEM_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_HEADER_ITEM_IMP} implementation.make (Current)
		end

end -- class EV_HEADER_ITEM

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

