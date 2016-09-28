note
	description:
		"[
			Base class for all items that may be held in EV_ITEM_LISTs.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "item"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM

inherit
	EV_PICK_AND_DROPABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_PIXMAPABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_CONTAINABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_ITEM_ACTION_SEQUENCES

feature -- Access

	parent: detachable EV_ITEM_LIST [EV_ITEM]
			-- Item list containing `Current'.
		do
			Result := implementation.parent
		ensure then
			bridge_ok: Result = implementation.parent
		end

	attached_parent: attached like parent
			-- Attached `parent'.
		require
			parent /= Void
		local
			l_parent: like parent
		do
			l_parent := parent
			check l_parent /= Void then end
			Result := l_parent
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CONTAINABLE} and Precursor {EV_PIXMAPABLE} and
				Precursor {EV_PICK_AND_DROPABLE}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_ITEM_I;
			-- Responsible for interaction with native graphics toolkit.

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_ITEM











