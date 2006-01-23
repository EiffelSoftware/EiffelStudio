indexing
	description: "List of actions managers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ACTIONS_MANAGER_LIST_WINDOWS

inherit
	LINKED_LIST [ACTIONS_MANAGER]

create
	make

feature -- Removal

	deregister (widget: WIDGET_IMP) is
			-- Remove `widget' from all action managers in list
		do
			from
				start
			until
				after
			loop
				item.delete (widget)
				forth
			end
		end

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




end -- class ACTIONS_MANAGER_LIST_WINDOWS

