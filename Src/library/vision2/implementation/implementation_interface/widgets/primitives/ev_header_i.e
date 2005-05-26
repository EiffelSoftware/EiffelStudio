indexing
	description: "Objects that represent an EiffelVision header control. Implementation Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_HEADER_I
	
inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end
		
	EV_ITEM_LIST_I [EV_HEADER_ITEM]
		redefine
			interface
		end
		
	EV_FONTABLE_I
		redefine
			interface
		end
		
	EV_ITEM_PIXMAP_SCALER_I
		redefine
			interface
		end
		
	EV_HEADER_ACTION_SEQUENCES_I
		export
			{NONE} all
		end

feature -- Access

	item_x_offset (an_item: EV_HEADER_ITEM): INTEGER is
			-- `Result' is x position of `an_item' in relation to `Current'.
		require
			has_an_item: has (an_item)
		local
			l_cursor: CURSOR
		do
			l_cursor := cursor
			from
				start
			until
				item = an_item
			loop
				if an_item /= item then
					Result := Result + item.width
				end
				forth
			end
			go_to (l_cursor)
		ensure
			result_non_negative: Result >= 0
			index_not_changed: index = old index
		end
		
	pointed_divider_index: INTEGER is
			-- Index of divider currently beneath the mouse pointer, or
			-- 0 if none.
		deferred
		ensure
			result_non_negative: Result >= 0
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HEADER
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_HEADER_I

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
