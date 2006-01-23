indexing	
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

	EV_ITEM_ACTION_SEQUENCES_IMP

feature -- Status setting

	destroy is
			-- Destroy the current item.
		do
			if parent_imp /= Void then
				parent_imp.prune (interface)
			end
			set_is_destroyed (True)
		end

	set_parent_imp (a_parent_imp: like parent_imp) is
			-- Assign `a_parent_imp' to `parent_imp'.
		deferred
		ensure
			assigned: parent_imp = a_parent_imp
		end

feature {EV_PICK_AND_DROPABLE_I} -- Status report

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
			-- Widget currently under the pointer.
		do
			check
				to_be_implemented: False
			end
		end

feature {EV_ITEM_LIST_I} -- Implementation

	on_parented is
			-- `Current' has just been put into a container.
		do
			-- Does nothing by default.
		end

	on_orphaned is
			-- `Current' has just been removed from its container.
		do
			-- Does nothing by default.
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM;

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




end -- class EV_ITEM_IMP

