indexing
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
			interface,
			insert_i_th
		end

	EV_DYNAMIC_LIST_IMP [G]
		redefine
			insert_i_th,
			interface
		end

	DISPOSABLE

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		deferred
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




end -- class EV_ITEM_LIST_IMP

