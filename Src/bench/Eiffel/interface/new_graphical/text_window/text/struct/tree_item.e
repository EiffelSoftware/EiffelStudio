indexing
	description: "Item of a 2-3-4 tree"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TREE_ITEM

inherit
	ANY

feature -- Access

	tree: B_345_TREE [like Current]

	key: TREE_KEY [like Current]
		-- Tree Key of Current

	next: like Current
		-- next item
		-- Void if Current is the last item.

	previous: like Current
		-- previous item
		-- Void if Current is the last item.

	index: INTEGER is
			-- index of item in tree
		do
			Result := key.number
		end

feature -- Status report

feature -- Element change

	set_key (k: like key) is
			-- Make `k' the value of `key'.
		do
			key := k
		end

	set_tree (t: like tree) is
			-- Make `t' the value of `tree'.
		do
			tree := t
		end

	set_next (ti: TREE_ITEM) is
			-- Make `ti' the next item.
		do
			next := ti
		end

	set_previous (ti: TREE_ITEM) is
			-- Make `ti' the previous item.
		do
			previous := ti
		end

feature -- Removal

	delete is
			-- Supress Current.
			-- If Current is the only line of `tree', prompt `tree' so.
		do
			key.delete
			unlink
		end

	unlink is
			-- link `previous' to `next'. used in deletion.
		do
			if next /= Void then
				next.set_previous (previous)
			end
			if previous /= Void then
				previous.set_next (next)
			end
			if Current = tree.last_data then
				if Current = tree.first_data then
					tree.wipe_out
				else
					tree.set_last_data (previous)
				end
			else
				if Current = tree.first_data then
					tree.set_first_data (next)
				end
			end
		end

feature -- Basic Operations

	add_right (other: like Current) is
			-- add `other' to the right of Current
		local
			ti: like key
		do
			other.set_tree (tree)
			link_right (other)
			create ti.make (other)
			other.set_key (ti)
			key.add_right (ti)
		ensure
			other_has_key: other.key /= Void
			other_has_tree: other.tree /= void
		end

	add_left (other: like Current) is
			-- add `other' to the left of Current
		local
			ti: like key
		do
			other.set_tree (tree)
			link_left (other)
			create ti.make (other)
			other.set_key (ti)
			key.add_left (ti)
		ensure
			other_has_key: other.key /= Void
			other_has_tree: other.tree /= void
		end

	link_right (other: like Current) is
			-- Add `other' to the right of current.
			-- Change links
		do
			other.set_next (next)
			other.set_previous (Current)
			if next /= Void then
				next.set_previous (other)
			end
				-- Being last tree data is not the same as having no following data.
			if Current = tree.last_data then
				tree.set_last_data (other)
			end
			set_next (other)
				--| `set_next' is last to not interfere
				--| with "if next /= Void ..." instruction
		end

	link_left (other: like Current) is
			-- Add `other' to the left of current.
			-- Change links
		do
			other.set_previous (previous)
			other.set_next (Current)
			if previous /= Void then
				previous.set_next (other)
			end
				-- Being first tree data is not the same as having no previous data.
			if Current = tree.first_data then
				tree.set_first_data (other)
			end
			set_previous (other)
				--| `set_previous' is last to not interfere
				--| with "if previous /= Void ..." instruction
		end

end -- class TREE_ITEM
