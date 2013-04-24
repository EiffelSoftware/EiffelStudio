note
	description: "Item of a 2-3-4 tree"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TREE_ITEM

inherit
	ANY

feature -- Access

	tree: detachable B_345_TREE

	key: detachable TREE_KEY [like Current]
		-- Tree Key of Current

	next: detachable like Current
		-- next item
		-- Void if Current is the last item.

	previous: detachable like Current
		-- previous item
		-- Void if Current is the last item.

	index: INTEGER
			-- index of item in tree
		require
			is_valid: is_valid
		local
			l_key: like key
		do
			l_key := key
			check l_key /= Void end -- Implied by precondition
			Result := l_key.number
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is current item valid in the tree?
		do
			Result := tree /= Void and then
					(attached key as l_key and then
					l_key.is_valid)
		end

feature -- Element change

	set_key (k: detachable like key)
			-- Make `k' the value of `key'.
		do
			key := k
		end

	set_tree (t: detachable like tree)
			-- Make `t' the value of `tree'.
		do
			tree := t
		end

	set_next (ti: detachable like Current)
			-- Make `ti' the next item.
		do
			next := ti
		end

	set_previous (ti: detachable like Current)
			-- Make `ti' the previous item.
		do
			previous := ti
		end

feature -- Removal

	delete
			-- Supress Current.
			-- If Current is the only line of `tree', prompt `tree' so.
		require
			key_not_void: key /= Void
		local
			l_key: like key
		do
			l_key := key
			check l_key /= Void end -- Implied by precondition
			l_key.delete
			unlink
		end

	unlink
			-- link `previous' to `next'. used in deletion.
		require
			tree_not_void: tree /= Void
		local
			l_tree: like tree
			l_next: like next
			l_previous: like previous
		do
			l_next := next
			l_previous := previous
			if l_next /= Void then
				l_next.set_previous (l_previous)
			end
			if l_previous /= Void then
				l_previous.set_next (l_next)
			end
			l_tree := tree
			check l_tree /= Void end -- Implied by precondition
			if Current = l_tree.last_data then
				if Current = l_tree.first_data then
					l_tree.wipe_out
				else
					l_tree.set_last_data (l_previous)
				end
			else
				if Current = l_tree.first_data then
					l_tree.set_first_data (l_next)
				end
			end
		end

feature -- Basic Operations

	add_right (other: like Current)
			-- add `other' to the right of Current
		require
			other_not_void: other /= Void
			key_not_void: key /= Void
		local
			ti, l_key: like key
		do
			other.set_tree (tree)
			link_right (other)
			create ti.make (other)
			other.set_key (ti)
			l_key := key
			check l_key_not_void: l_key /= Void end -- Implied by precondition
			l_key.add_right (ti)
		ensure
			other_has_key: other.key /= Void
			other_has_tree: other.tree /= void
		end

	add_left (other: like Current)
			-- add `other' to the left of Current
		require
			other_not_void: other /= Void
			key_not_void: key /= Void
		local
			ti, l_key: like key
		do
			other.set_tree (tree)
			link_left (other)
			create ti.make (other)
			other.set_key (ti)
			l_key := key
			check l_key_not_void: l_key /= Void end -- Implied by precondition
			l_key.add_left (ti)
		ensure
			other_has_key: other.key /= Void
			other_has_tree: other.tree /= void
		end

	link_right (other: like Current)
			-- Add `other' to the right of current.
			-- Change links
		require
			tree_set: tree /= Void
		local
			l_next: like next
			l_tree: like tree
		do
			other.set_next (next)
			other.set_previous (Current)
			l_next := next
			if l_next /= Void then
				l_next.set_previous (other)
			end
				-- Being last tree data is not the same as having no following data.
			l_tree := tree
			check l_tree /= Void end -- Implied by precondition
			if Current = l_tree.last_data then
				l_tree.set_last_data (other)
			end
			set_next (other)
				--| `set_next' is last to not interfere
				--| with "if next /= Void ..." instruction
		end

	link_left (other: like Current)
			-- Add `other' to the left of current.
			-- Change links
		require
			tree_set: tree /= Void
		local
			l_pre: like previous
			l_tree: like tree
		do
			other.set_previous (previous)
			other.set_next (Current)
			l_pre := previous
			if l_pre /= Void then
				l_pre.set_next (other)
			end
				-- Being first tree data is not the same as having no previous data.
			l_tree := tree
			check l_tree /= Void end -- Implied by precondition
			if Current = l_tree.first_data then
				l_tree.set_first_data (other)
			end
			set_previous (other)
				--| `set_previous' is last to not interfere
				--| with "if previous /= Void ..." instruction
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TREE_ITEM
