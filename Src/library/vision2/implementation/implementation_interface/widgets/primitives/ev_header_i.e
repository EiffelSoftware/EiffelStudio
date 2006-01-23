indexing
	description: "Objects that represent an EiffelVision header control. Implementation Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	interface: EV_HEADER;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

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




end -- class EV_HEADER_I

