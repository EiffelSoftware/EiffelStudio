indexing
	description: "3-4-5 Balanced Tree"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	B_345_TREE [G->TREE_ITEM]

inherit
	ANY

create
	make

feature -- Initialization

	make is
		do
			create root_node.make
		end

feature -- Access

	count: INTEGER is
		do
			Result := root_node.keys_plus_one - 1
		end

	first_data: G

	last_data: like first_data

	item (i: INTEGER): like first_data is
		do
			Result := root_node.item (i).data
		end

feature -- Element Change

	set_first_data (tl: like first_data) is
		do
			first_data := tl
		end

	set_last_data (tl: like first_data) is
		do
			last_data := tl
		end

	prepend_data (tl: like first_data) is
			-- add tl at the beginning of the tree.
		require
			tl_not_linked: tl.next = Void and then tl.previous = Void
		local
			ti: TREE_KEY [like first_data]
		do
			tl.set_tree (Current)
			create ti.make (tl)
			tl.set_key (ti)
			if first_data = Void then
				set_last_data (tl)
				root_node.insert_first (ti)
			else
				tl.set_next (first_data)
				first_data.set_previous (tl)
				first_data.key.add_left (ti)
			end
			set_first_data (tl)
		ensure
			tl_linked: tl /= last_data implies
				(tl.next /= Void and then tl.next.previous = tl)
			tl_has_key: tl.key /= Void
			tl_has_tree: tl.tree /= Void
		end

	append_data (tl: like first_data) is
			-- add tl at the end of the tree.
		require
			tl_not_linked: tl.next = Void and then tl.previous = Void
		local
			ti: TREE_KEY [like first_data]
		do
			tl.set_tree (Current)
			create ti.make (tl)
			tl.set_key (ti)
			if last_data = Void then
				set_first_data (tl)
				root_node.insert_last (ti)
			else
				tl.set_previous (last_data)
				last_data.set_next (tl)
				last_data.key.add_right (ti)
			end
			set_last_data (tl)
		ensure
			tl_linked: tl /= first_data implies
				(tl.previous /= Void and then tl.previous.next = tl)
			tl_has_key: tl.key /= Void
			tl_has_tree: tl.tree /= Void
		end

feature -- Removal

		wipe_out is
				-- Erase data.
			do
				set_first_data (Void)
				set_last_data (Void)
				create root_node.make
			end
			

feature {NONE} -- Implementation

	root_node: TREE_NODE [like first_data]

end -- B_345_TREE
