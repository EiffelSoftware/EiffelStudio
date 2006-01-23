indexing
	description:
		"Abstraction for objects that may be parented."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "parentable, containable, child"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_CONTAINABLE

inherit
	EV_ANY
	
feature -- Status report

	parent: EV_ANY is
			-- The parent that `Current' is contained within, if any.
		require
			not_destroyed: not is_destroyed
		deferred
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




end -- class EV_CONTAINABLE

