indexing

	description:
		"Sorted sets implemented as binary search trees";

	status: "See notice at end of class";
	names: binary_search_tree_set, set, binary_search_tree;
	representation: recursive, array;
	access: membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class
	BINARY_SEARCH_TREE_SET [G -> COMPARABLE]

inherit
	COMPARABLE_SET [G]
		redefine
			min, max, has
		end

creation

	make

feature -- Initialization

	make is
		do
			before := true
		end;

feature -- Access

	has (v: like item): BOOLEAN is
			-- Is there a node with item `v' in tree?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		do
			if tree /= Void then
				if object_comparison then
					tree.compare_objects
				else
					tree.compare_references
				end
				Result := tree.has (v)
			end
		end;

feature -- Measurement

	count: INTEGER is
			-- Number of items in tree
		do
			if tree /= Void then
				Result := tree.count
			end
		end;

	min: like item is
			-- Minimum item in tree
		do
			Result := tree.min
		end;

	max: like item is
			-- Maximum item in tree
		do
			Result := tree.max
		end;

	item: G is
		do
			Result := active_node.item
		end;

feature -- Status report

	is_empty: BOOLEAN is
		do
			Result := tree = Void
		end;

	extendible: BOOLEAN is true;
		-- Can new items be added? (Answer: yes.)

	prunable: BOOLEAN is true;
		-- Can items be removed? (Answer: yes.)

	after: BOOLEAN;
		-- Is there no valid cursor position to the right of cursor?

	before: BOOLEAN;
		-- Is there no valid cursor position to the left of cursor?

feature -- Cursor movement

	start is
		do
			before := false;
			if tree = Void then
				after := true
			else
				after := false;
				active_node := tree.min_node
			end
		end;

	finish is
		do
			after := false;
			if tree = Void then
				before := true
			else
				before := false;
				active_node := tree.max_node
			end;
		end;

	forth is
		local
			new_node, prev_node: like tree;
		do
			if before then
				before := false;
				if is_empty then
					after:= true
				end;
			else
				if active_node.has_right then
					active_node := 	active_node.right_child.min_node
				else
					prev_node := active_node;
					active_node := active_node.parent;
					from
					until
						active_node = Void
						or else prev_node = active_node.left_child
					loop
						prev_node := active_node;
						active_node := active_node.parent
					end;
					if active_node = Void then
						active_node := tree;
						after := true
					end
				end
			end
		end;


	back is
		local
			new_node, prev_node: like tree;
		do
			if after then
				after := false;
				if is_empty then
					before:= true
				end;
			else
				if tree.has_left then
					active_node := 	active_node.left_child.max_node
				else
					prev_node := active_node;
					active_node := active_node.parent;
					from
					until
						active_node = Void
						or else prev_node = active_node.right_child
					loop
						prev_node := active_node;
						active_node := active_node.parent
					end;
					if active_node = Void then
						active_node := tree;
						before := true
					end
				end
			end
		end;

feature -- Comparison

	is_subset (other: like Current): BOOLEAN is
			-- Is current structure a subset of `other'?
		do
			if other.tree /= Void then
				Result := tree = Void or else
					tree.is_subset (other.tree)
			else
				Result := true
			end;
		end;

feature -- Element change

	put, extend (v: like item) is
			-- Put `v' at proper position in set
			-- (unless one already exists).
		require else
			item_exists: v /= Void
		do
			if tree = Void then
				tree := new_tree (v)
			else
				tree.extend (v)
			end
		end;

feature -- Removal

	wipe_out is
			-- Remove all items.
		do
			tree := Void;
		end;

	prune (v: like item) is
		do
			if tree /= Void then
				tree := tree.pruned (v)
			end
		end;

feature -- Duplication

	duplicate (n: INTEGER): BINARY_SEARCH_TREE_SET [G] is
			-- New structure containing min (`n', `count')
			-- items from current structure
		local
			temp_tree: BINARY_SEARCH_TREE [G]
		do
			!!Result.make
			Result.set_tree (tree.duplicate (n))
		end

feature -- Basic operations

	intersect (other: like Current) is
			-- Remove all items not in `other'.
		require else
			set_exists: other /= Void
		local
			m: like tree;
		do
			if other.tree = Void or tree = Void then
				tree := Void
			else
				if tree.has_left then
					tree.left_child.intersect (other.tree)
				end;
				if tree.has_right then
					tree.right_child.intersect (other.tree)
				end;
				if not other.has (tree.item) then
					if not tree.has_left then
						tree := tree.right_child
					elseif not tree.has_right then
						tree := tree.left_child
					else
						m := tree.min_node;
						m.remove_node;
						tree.replace (m.item)
					end
				end
			end
		end;

	subtract (other: like Current) is
			-- Remove all items also in `other'.
		require else
			set_exists: other /= Void
		local
			m: like tree;
		do
			if other.tree /= Void and tree /= Void then
				if tree.has_left then
					tree.left_child.subtract (other.tree)
				end;
				if tree.has_right then
					tree.right_child.subtract (other.tree)
				end;
				if other.has (tree.item) then
					if not tree.has_left then
						tree := tree.right_child
					elseif not tree.has_right then
						tree := tree.left_child
					else
						m := tree.min_node;
						m.remove_node;
						tree.replace (m.item)
					end
				end
			end
		end;


	merge (other: like Current) is
			-- Add all items of `other'.
		do
			if other.tree /= Void then
				if tree = Void then
					tree := new_tree (other.tree.item);
					if other.tree.has_left then
						tree.merge (other.tree.left_child)
					end;
					if other.tree.has_right then
						tree.merge (other.tree.right_child)
					end;
				else
					tree.merge (other.tree)
				end
			end
		end;

feature {BINARY_SEARCH_TREE_SET} -- Implementation

	tree: BINARY_SEARCH_TREE [G];

	active_node: like tree;

	set_tree (t : like tree) is
			-- Set `tree' and `active_node' to `t'
		do
			tree := t
			active_node := t
		end

feature {NONE} -- Implementation

	new_tree (v: like item): like tree is
			-- New allocated node with `item' set to `v'
		do
			!! Result.make (v)
		end;


end -- class BINARY_SEARCH_TREE_SET


--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

