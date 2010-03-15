note
	description: "Eiffel Vision tree item. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_ITEM;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TREE_ITEM_IMP

