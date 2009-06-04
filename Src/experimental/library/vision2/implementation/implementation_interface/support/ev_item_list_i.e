note
	description:
		"Eiffel Vision item list. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "item, list"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST_I [G -> detachable EV_ITEM]

inherit
	EV_DYNAMIC_LIST_I [G]
		redefine
			interface
		end

feature -- Access

	item_by_data (data: ANY): detachable like item
			-- First item with `data'.
		require
			data_not_void: data /= Void
		local
			c: CURSOR
			curr_data: detachable like data
		do
			c := cursor
			from
				attached_interface.start
			until
				attached_interface.after or Result /= Void
			loop
				curr_data := attached_interface.item.data
				if equal (curr_data, data) then
					Result := attached_interface.item
				end
				attached_interface.forth
			end
			go_to (c)
		end

feature {EV_ANY_I, EV_ITEM_I} -- Implementation

	interface: detachable EV_ITEM_LIST [G] note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'

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




end -- class EV_ITEM_LIST_I










