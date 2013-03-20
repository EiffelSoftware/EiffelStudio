note
	description: "Cursors for two-way trees"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	names: two_way_tree, cursor;
	contents: generic;
	date: "$Date$"
	revision: "$Revision$"

class TWO_WAY_TREE_CURSOR [G]

inherit
	TWO_WAY_LIST_CURSOR [G]
		redefine
			active
		end

create
	make

feature {TWO_WAY_TREE} -- Access

	active: detachable TWO_WAY_TREE [G];
			-- Current node

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class TWO_WAY_TREE_CURSOR



