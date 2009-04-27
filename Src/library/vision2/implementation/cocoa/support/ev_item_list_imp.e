indexing
	description:
		"Eiffel Vision item list. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


deferred class
	EV_ITEM_LIST_IMP [reference G -> EV_ITEM, reference G_IMP -> EV_ITEM_IMP]

inherit
	EV_ITEM_LIST_I [G]
		redefine
			interface,
			insert_i_th
		end

	EV_DYNAMIC_LIST_IMP [G, G_IMP]
		redefine
			insert_i_th,
			remove_i_th,
			interface
		end

	DISPOSABLE

feature {NONE} -- Implementation


	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			v_imp: G_IMP
		do
			Precursor {EV_DYNAMIC_LIST_IMP} (v, i)

			v_imp ?= v.implementation

			v_imp.set_parent_imp (Current)
		end

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		local
			v_imp: G_IMP
		do
			v_imp ?= i_th (i).implementation
			v_imp.set_parent_imp (Void)

			Precursor {EV_DYNAMIC_LIST_IMP} (i)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM_LIST [G];
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_ITEM_LIST_IMP

