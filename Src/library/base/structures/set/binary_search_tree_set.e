indexing

	description:
		"Sorted sets implemented as binary search trees";

	copyright: "See notice at end of class";
	names: binary_search_tree_set, set, binary_search_tree;
	representation: recursive, array;
	access: membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class BINARY_SEARCH_TREE_SET [G -> COMPARABLE] inherit

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
			-- Is there a node with item `v' in subtree?
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
			-- Number of elements in subtree.
		do
			if tree /= Void then
				Result := tree.count
			end
		end;

	empty: BOOLEAN is
		do
			Result := tree = Void
		end;


	min: like item is
			-- Minimum element in subtree
		do
			Result := tree.min
		end;

	max: like item is
			-- Maximum element in subtree
		do
			Result := tree.max
		end;

	item: G is
		do
			Result := active_node.item
		end;

feature -- Status report

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
				if empty then
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
				if empty then
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
				Result := tree /= Void and then
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
			-- Remove all elements.
		do
			tree := Void;
		end;

	prune (v: like item) is
		do
			if tree /= Void then
				tree := tree.pruned (v)
			end
		end;
	

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
			-- Add all elements of other to Current
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

feature {NONE} -- Implementation

	new_tree (v: like item): like tree is
			-- New allocated node with `item' set to `v'
		do
			!! Result.make (v)
		end;


end -- class BINARY_SEARCH_TREE_SET


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
