note
	description:
		"Eiffel Vision item list. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


deferred class
	EV_ITEM_LIST_IMP [reference G -> EV_ITEM]

inherit
	EV_ITEM_LIST_I [G]
		redefine
			interface
		end

	EV_DYNAMIC_LIST_IMP [G]
		redefine
			interface
		end

	DISPOSABLE

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_ITEM_LIST [G] note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_ITEM_LIST_IMP
