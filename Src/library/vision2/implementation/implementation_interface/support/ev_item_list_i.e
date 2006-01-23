indexing
	description:
		"Eiffel Vision item list. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "item, list"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST_I [reference G -> EV_ITEM]

inherit
	EV_DYNAMIC_LIST_I [G]
		redefine
			interface
		end
		
feature -- Access

	item_by_data (data: ANY): like item is
			-- First item with `data'.
		require
			data_not_void: data /= Void
		local
			c: CURSOR
			curr_data: like data
		do
			c := cursor
			from
				interface.start
			until
				interface.after or Result /= Void
			loop
				curr_data := interface.item.data
				if equal (curr_data, data) then
					Result := interface.item
				end
				interface.forth
			end
			go_to (c)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM_LIST [G];
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'

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




end -- class EV_ITEM_LIST_I

