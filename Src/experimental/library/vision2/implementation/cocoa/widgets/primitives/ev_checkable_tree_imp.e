note
	description:
		"[
			A tree which displays a check box to left
			hand side of each item contained. Cocoa implementation.
		]"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECKABLE_TREE_IMP

inherit
	EV_CHECKABLE_TREE_I
		undefine
			make,
			call_pebble_function,
			wipe_out,
			append
		redefine
			interface
		end

	EV_TREE_IMP
		redefine
			interface,
			make
		end

	EV_CHECKABLE_TREE_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make
			-- Setup `Current'
		do
			Precursor {EV_TREE_IMP}
		end

	boolean_tree_model_column: INTEGER = 2

	on_tree_path_toggle (a_tree_path_str: POINTER)
			--
		do
		end

	initialize_model
			-- Create our data model for `Current'
		do
		end

feature -- Access

	is_item_checked (list_item: EV_TREE_NODE): BOOLEAN
			--
		do
		end

feature -- Status setting

	check_item (tree_item: EV_TREE_NODE)
			-- Ensure check associated with `tree_item' is
			-- checked.
		do
		end

	uncheck_item (tree_item: EV_TREE_NODE)
			-- Ensure check associated with `tree_item' is
			-- unchecked.
		do
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_CHECKABLE_TREE;

end -- class EV_CHECKABLE_TREE_IMP
