note
	description:
		"Eiffel Vision item. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "item"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_I

inherit
	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_PIXMAPABLE_I
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_I

feature -- Access

	parent: detachable EV_ITEM_LIST [EV_ITEM]
			-- Item list containing `Current'.
		do
			if attached parent_imp as l_parent_imp then
				Result ?= l_parent_imp.interface
				check
					parent_not_void: Result /= Void
				end
			end
		end

	parent_imp: detachable EV_ITEM_LIST_I [detachable EV_ITEM]
			-- The parent of the Current widget
			-- Can be void.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		deferred
		end

	interface: detachable EV_ITEM note option: stable attribute end;
			-- Provides a common user interface to platform dependent
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




end -- class EV_ITEM_I











