indexing

	description:
		"Cursor trees with a recursive structure";

	copyright: "See notice at end of class";
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

	arity: INTEGER is
			-- Number of children of active node; if cursor is `above',
			-- 0 if tree is empty, 1 otherwise. 
		do
			Result := active.arity
		end;

	cursor: CURSOR is
			-- Current cursor position
		local
			temp: like cursor_anchor
		do
			!! temp.make (active, active_parent, after, before, below);
			Result := temp
		end;

feature -- Measurement


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

feature -- Status report

	empty: BOOLEAN is
			-- Is the tree empty?
		do
			Result := (above_node.arity = 0)
		end;

	after: BOOLEAN;
			-- Is there no valid cursor position to the right of cursor?

	before: BOOLEAN;
			-- Is there no valid cursor position to the left of cursor?

	above: BOOLEAN is
			-- Is there no valid cursor position above cursor?
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

feature -- Cursor movement

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
			-- Move cursor one level upward to parent,
			-- or `above' if `is_root' holds.
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

feature -- Element change

	replace (v: G) is
			-- Replace current item by `v'.
		do
			active.replace (v)
		end;

feature -- Removal

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
			-- Remove all elements.
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

feature {NONE} -- Implementation

	active: DYNAMIC_TREE [G];
			-- Current node

	active_parent: like active;
			-- Parent of current node

	above_node: like active;
			-- Node above root; physical root of tree

	cursor_anchor: RECURSIVE_TREE_CURSOR [G];
			-- Anchor for definitions concerning cursors

	corresponding_child is
			-- Make `active' the current child of `active_parent'.
		do
			if active_parent /= Void then
				active_parent.child_go_i_th (1);	
				--active_parent.search (active);
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

end -- class RECURSIVE_CURSOR_TREE


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
