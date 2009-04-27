indexing
	description: "EiffelVision item, Cocoa implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
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
		redefine
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

feature

	parent_imp: EV_ITEM_LIST_IMP [EV_ITEM, EV_ITEM_IMP]

	set_parent_imp (a_parent_imp: like parent_imp)
			-- Assign `a_parent_imp' to `parent_imp'.
		do
			parent_imp := a_parent_imp
		ensure
			assigned: parent_imp = a_parent_imp
		end

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
		end

feature {EV_ANY_I} -- Implementation

	destroy
		do

		end

	interface: EV_ITEM;

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_ITEM_IMP

