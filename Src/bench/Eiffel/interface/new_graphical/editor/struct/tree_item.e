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
			-- Make `k' the next item
		do
			key := k
		end

	set_next (ti: TREE_ITEM) is
			-- Make `ti' the next item
		do
			next := ti
		end

	set_previous (ti: TREE_ITEM) is
			-- Make `ti' the previous item
		do
			previous := ti
		end

feature -- Removal

	delete is
			-- Supress Current
		do
			key.delete
			unlink
		end

	unlink is
			-- link `previous' to `next'. used in deletion.
		do
			if next /= Void then
				next.set_previous (previous)
			else
				tree.set_last_data (previous)
			end
			if previous /= Void then
				previous.set_next (next)
			else
				tree.set_first_data (next)
			end
		end

feature -- Basic Operations

	add_right (other: like Current) is
			-- add `other' to the right of Current
		local
			ti: like key
		do
			link_right (other)
			create ti.make (other)
			key.add_right (ti)
		end

	add_left (other: like Current) is
			-- add `other' to the left of Current
		local
			ti: like key
		do
			link_left (other)
			create ti.make (other)
			key.add_left (ti)
		end

	link_right (other: like Current) is
			-- Add `other' to the right of current.
			-- Change links
		do
			other.set_next (next)
			other.set_previous (Current)
			if next /= Void then
				next.set_previous (other)
			else
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
			else
				tree.set_first_data (other)
			end
			set_previous (other)
				--| `set_previous' is last to not interfere
				--| with "if previous /= Void ..." instruction
		end

end -- class TREE_ITEM
