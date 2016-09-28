note
	description: "EiffelVision item, Cocoa implementation"
	author: "Daniel Furrer"
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_ITEM_IMP

inherit
	EV_ITEM_I
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_IMP
		undefine
			set_pointer_style
		redefine
			interface,
			destroy
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

feature -- Status settings

	destroy
			-- Destroy the current item.
		do
			if attached parent_imp as p_imp and attached interface then
				p_imp.prune (interface)
			end
			set_is_destroyed (True)
		end

	set_parent_imp (a_parent_imp: detachable like parent_imp)
			-- Assign `a_parent_imp' to `parent_imp'.
		do
			parent_imp := a_parent_imp
		ensure
			assigned: parent_imp = a_parent_imp
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

	parent_imp: detachable EV_ITEM_LIST_IMP [EV_ITEM, EV_ITEM_IMP]

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Redefined by descendents.
		end

	cocoa_view: detachable NS_VIEW
			-- The visual representation for the view

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_ITEM note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_ITEM_IMP
