indexing
	description:
		"[
			A tree which displays a check box to left
			hand side of each item contained. MsWindows implementation.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECKABLE_TREE_IMP
	
inherit
	EV_CHECKABLE_TREE_I
		undefine
			initialize,
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

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			Precursor {EV_TREE_IMP} (an_interface)
		end
		
feature -- Status report

	is_item_checked (tree_item: EV_TREE_NODE): BOOLEAN is
			-- is `tree_item' checked?
		do
		end

feature -- Status setting

	check_item (tree_item: EV_TREE_NODE) is
			-- Ensure check associated with `tree_item' is
			-- checked.
		do
		end

	uncheck_item (tree_item: EV_TREE_NODE) is
			-- Ensure check associated with `tree_item' is
			-- checked.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CHECKABLE_TREE;

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




end -- class EV_CHECKABLE_TREE_IMP
