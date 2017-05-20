note
	description: "Eiffel Vision item. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_IMP

inherit
	EV_ITEM_I
		redefine
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_ITEM_IMP
		redefine
			interface
		end

feature -- Status setting

	destroy
			-- Destroy the current item.
		do
			if attached parent_imp as l_parent_imp and then attached interface then
				l_parent_imp.prune (interface)
			end
			set_is_destroyed (True)
		end

	set_parent_imp (a_parent_imp: like parent_imp)
			-- Assign `a_parent_imp' to `parent_imp'.
		deferred
		ensure
			assigned: parent_imp = a_parent_imp
		end

feature {EV_PICK_AND_DROPABLE_I} -- Status report

	cursor_on_widget: detachable CELL [detachable EV_WIDGET_IMP]
			-- Widget currently under the pointer.
		do
			check
				to_be_implemented: False
			end
		end

feature {EV_ITEM_LIST_I} -- Implementation

	on_parented
			-- `Current' has just been put into a container.
		do
			-- Does nothing by default.
		end

	on_orphaned
			-- `Current' has just been removed from its container.
		do
			-- Does nothing by default.
		end

feature {EV_ANY_I} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Redefined by descendents.
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_ITEM note option: stable attribute end;

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




end -- class EV_ITEM_IMP











