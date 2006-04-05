indexing
	description: "Object that represents a tree node in a resultset from an EQL query"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_TREE_NODE [G -> EQL_ITERABLE_ITEM]

inherit
	EQL_TREE_NODE_LIST [G]
		rename
			make as node_list_make
		redefine
			is_equal
		end

	CELL [G]
		rename
			item as data,
			put as put_data,
			replace as replace_data
		undefine
			copy,
			is_equal
		end

	EQL_ITERABLE [G]
		undefine
			is_equal,
			copy
		redefine
			itr,
			distinct_itr
		end

create
	make,
	make_with_data

feature{NONE} -- Initialization

	make (a_root: like root_node) is
			-- Initialize `root_node' with `a_root'.
		require
			a_root_not_void: a_root /= Void
		do
			node_list_make
			root_node := a_root
		ensure
			current_is_empty: is_empty
		end

	make_with_data (a_root: like root_node; a_data: like data) is
			-- Initialize `root_node' with `a_root' and `data' with `a_data'.
		require
			a_root_not_void: a_root /= Void
		do
			make (a_root)
			put_data (a_data)
		ensure
			current_is_empty: is_empty
			data_set: data = a_data
		end

feature -- Iterator

	itr: EQL_TREE_ITERATOR [G] is
			-- Iterator for current
		do
			create Result.make (Current)
		end

	distinct_itr: EQL_DISTINCT_TREE_ITERATOR [G] is
			-- Distinct iterator
		do
			create Result.make (Current)
		end

feature -- Equality

	is_equal (other: like Current): BOOLEAN is
			-- Does `other' contain the same elements?
		do
			Result := Precursor{EQL_TREE_NODE_LIST} (other)
			if Result then
				Result := (modification_count = other.modification_count) and then
						 equal (data, other.data) and then
						 equal (root_node, other.root_node)
			end
		end

feature{EQL_ITERATOR, EQL_TREE_NODE} -- Modification count

	modification_count: NATURAL_64 is
			-- Count of modification, used by fail fast iterators
		do
			Result := root_node.modification_count
		end

feature{EQL_TREE_NODE} -- Implementation

	increase_modification_count is
			-- Increase `modification_count' in current tree by `1'.
			-- If `modification_count' reaches its `max_value', reset it to 0.
		do
			root_node.increase_modification_count
		end

feature{EQL_ITERATOR, EQL_TREE_NODE} -- Implementation

	root_node: like Current
			-- Root node

invariant
	root_node_not_void: root_node /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
