note
	description: "Eiffel Vision tree item. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_ITEM_IMP

inherit
	EV_TREE_ITEM_I
		redefine
			interface
		end

	EV_TREE_NODE_IMP
		redefine
			interface
		end

create
	make

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TREE_ITEM note option: stable attribute end;

end -- class EV_TREE_ITEM_IMP
