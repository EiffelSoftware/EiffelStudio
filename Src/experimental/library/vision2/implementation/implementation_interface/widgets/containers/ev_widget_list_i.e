note
	description:
		"EiffelVision widget list. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_LIST_I

inherit
	EV_CONTAINER_I
		undefine
			interface_item
		redefine
			interface
		end

	EV_DYNAMIC_LIST_I [detachable EV_WIDGET]
		redefine
			interface
		end

feature {EV_ANY_I} -- implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so notify all children.
		local
			loc_cursor: CURSOR
		do
			from
				loc_cursor := cursor
				start
			until
				off
			loop
				interface_item.implementation.update_for_pick_and_drop (starting)
				forth
			end
			go_to (loc_cursor)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WIDGET_LIST note option: stable attribute end;

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




end -- class WIDGET_LIST










