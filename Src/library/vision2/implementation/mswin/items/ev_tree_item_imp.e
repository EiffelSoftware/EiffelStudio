indexing
	description: "Eiffel Vision tree item. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_ITEM_IMP

inherit
	EV_TREE_ITEM_I
		undefine
			copy, is_equal
		redefine
			interface
		end

	EV_TREE_NODE_IMP
		undefine
			parent
		redefine
			interface,
			set_tooltip
		end

create
	make

feature {NONE} -- Implementation

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `internal_tooltip_string'.
		do
			internal_tooltip_string := a_tooltip.twin
		end


feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_TREE_ITEM;

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




end -- class EV_TREE_ITEM_IMP

