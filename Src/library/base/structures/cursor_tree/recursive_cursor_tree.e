--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.		--
--|    270 Storke Road, Suite 7 Goleta, California 93117		--
--|                   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Recursive cursor trees,
-- implemented trough the usage of general facilities of
-- class TREE for various implementations of cursor trees

indexing

	names: recursive_cursor_tree, cursor_tree, tree;
	access: cursor, membership;
	representation: recursive;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class RECURSIVE_CURSOR_TREE [G] inherit

	CURSOR_TREE [G]
		redefine
			empty
		end

feature -- Access

	item: G is
			-- Item at cursor position
		require else
			not_off: not off
		do
			Result := active.item
		end;

feature -- Insertion

	replace (v: G) is
			-- Replace current item by `v'.
		do
			active.replace (v)
		end;

feature -- Deletion

	remove is
			-- Remove node at cursor position
			-- (and consequently the corresponding
			-- subtree). Cursor moved up one level.
		do
			corresponding_child;
			active := active_parent;
			active_parent := active_parent.parent;
			active.remove_child
		ensure then
			not_off_unless_empty: empty or else not off
		end;

	wipe_out is
			-- Empty `Current'.
		do
			if not empty then
				above_node.child_start;
				above_node.remove_child;
			end;
			active := above_node;
			active_parent := Void;
			after := false;
			before := false;
			below := false
		ensure then
			cursor_above: above;
		end;

feature -- Number of elements

	empty: BOOLEAN is
			-- Is the tree empty?
		do
			Result := (above_node.arity = 0)
		end;

	count: INTEGER is
			-- Number of items in the tree
		local
			pos: like cursor_anchor
		do
			pos ?= cursor;
			from
				start
			until
				off
			loop
				Result := Result + 1;
				preorder_forth
			end;
			go_to (pos);
			corresponding_child;
		end;

	arity: INTEGER is
			-- Number of children of active node.
			-- This function may be called when
			-- the cursor is above the tree in
			-- which case it returns 0 for an
			-- empty tree and 1 for a non empty
			-- one
		do
			Result := active.arity
		end;

feature -- Cursor

	back is
			-- Move cursor one position backward.
		do
			if below then
				after := false;
				before := true
			elseif after then
				after := false
			elseif isfirst then
				before := true
			else
				active_parent.child_back;
				active := active_parent.child
			end
		end;

	forth is
			-- Move cursor one position forward.
		do
			if below then
				before := false;
				after := true
			elseif before then
				before := false
			elseif islast then
				after := true
			else
				active_parent.child_forth;
				active := active_parent.child
			end
		end;

	up is
			-- Move cursor one level upward:
			-- to parent of `Current',
			-- or `above' if `Current.is_root'
		local
			old_active: like active;
		do
			if below then
				below := false
			else
				active := active_parent;
				active_parent := active_parent.parent;
				corresponding_child;
			end;
			after := false;
			before := false
		end;

	down (i: INTEGER) is
			-- Move cursor one level downward:
			-- to `i'-th child if there is one,
			-- or `after' if `i' = `arity' + 1,
			-- or `before' if `i' = 0.
		do
			if i = 0 then
				if arity = 0 then
					below := true;
				else
					active_parent := active;
					active.child_go_i_th (1);
					active := active.child;
				end;
				before := true;
			elseif i = arity + 1 then
				if arity = 0 then
					below := true;
				else
					active_parent := active;
					active.child_go_i_th (arity);
					active := active.child;
				end;
				after := true;
			else
				active_parent := active;
				active.child_go_i_th (i);
				active := active.child
			end
		end;

	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		local
			temp: like cursor_anchor
		do
			temp ?= p;
				check
					temp /= Void
				end;
			unchecked_go (temp)
		end;

	cursor: CURSOR is
			-- Current cursor position
		local
			temp: like cursor_anchor
		do
			!! temp.make (active, active_parent, after, before, below);
			Result := temp
		end;

	after: BOOLEAN;
			-- Is there no position to the right of the cursor?

	before: BOOLEAN;
			-- Is there no position to the left of the cursor?

	above: BOOLEAN is
			-- Is there no position above the cursor?
		do
			if not below then
				Result := (active_parent = Void)
			end
		end;

	isfirst: BOOLEAN is
			-- Is cursor on first sibling?
		do
			if not off then
				Result := active_parent.child_isfirst;
			end
		end;

	islast: BOOLEAN is
			-- Is cursor on last sibling?
		do
			if not off then
				Result := active_parent.child_islast;
			end
		end;

	is_root: BOOLEAN is
			-- Is cursor on tree root?
		do
			if not off then
				Result := (active_parent = above_node);
			end
		end;

feature {NONE} -- Cursor

	cursor_anchor: RECURSIVE_TREE_CURSOR [G];
			-- Anchor for definitions concerning cursors

	corresponding_child is
			-- Make `active' the current child of `active_parent'.
		do
			if active_parent /= Void then
				active_parent.child_go_i_th (1);	
				active_parent.search_child (active);
			end;
		end;

	unchecked_go (p: like cursor_anchor) is
			-- Make an attempt to move cursor
			-- to position `p', without checking
			-- whether `p' is a valid cursor position
			-- or not.
		do
			active_parent := p.active_parent;
			active := p.active;
			corresponding_child;
			after := p.after;
			before := p.before;
			below := p.below
		end;

feature -- Assertion check

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
		local
			temp: like cursor_anchor;
			pos: CURSOR
		do
			temp ?= p;
			if temp /= Void then
				if temp.active = above_node or temp.before or
					temp.after or temp.below
				then
					Result := true
				else
					pos := cursor;
					from
						start
					until
						active = temp.active or else off
					loop
						preorder_forth
					end;
					Result := not off;
					go_to (pos)
				end
			end
		end;

feature {NONE} -- Representation

	active: TREE [G];
			-- Current node

	active_parent: like active;
			-- Parent of current node

	above_node: like active;
			-- Node above root; physical root of tree

end
