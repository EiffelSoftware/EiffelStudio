indexing
	description: "Trees implemented using a linked_list representation"
	names: tree;
	access: fixed, cursor;
	representation: recursive, linked

class SAMPLE_FILE [T] export
	
	repeat TREE,
	child_item,
	child_put_right, child_put_left,
	put_between,
	right_sibling, duplicate, 
	first_child, last_child,
	remove_child_left, remove_child_right,
	wipe_out,
	index_of_child,
	merge_tree_after, merge_tree_before,
	put_child_left, put_child_right

inherit

	TREE [T]
		redefine
			parent
		define
			put, item,
			put_child, remove_child,
			first_child, is_leaf, arity, child_position,
			child_off, child_offright,
			child_offleft, child_start, child_finish, child_go, child,
			child_forth, child_back, child_isfirst, child_islast;

	LINKABLE [T]
		rename
			right as right_sibling,
			put_between as linkable_put_between,
			put_right as linkable_put_right,
			Create as linkable_Create
		redefine
			put_between;

	LINKED_LIST [T]	
		rename
			put as linked_put,
			put_right as child_put_right,
			put_left as child_put_left,
			item as child_item,
			empty as is_leaf,
			count as arity,
			go as child_go,
			start as child_start,
			finish as child_finish,
			forth as child_forth,
			back as child_back,
			position as child_position,
			off as child_off,
			offright as child_offright,
			offleft as child_offleft,
			isfirst as child_isfirst,
			islast as child_islast,
			mark as child_mark,
			return as child_return,
			update_after_insertion as linked_list_update,
			active as child,
			put_linkable_right as put_child_right,
			put_linkable_left as put_child_left,
			first_element as first_child,
			merge_right as linked_list_merge_right,
			merge_left as linked_list_merge_left,
			remove as remove_child,
			remove_right as remove_child_right,
			remove_left as remove_child_left
		redefine
			first_child,
			update_after_insertion,
			duplicate,
			merge_right, merge_left

feature

	Create (v: like item) is
			-- Create single node with item `v'.
		do
			linkable_Create (v)
		end; -- Create

	parent: LINKED_TREE [T];
			-- Parent of current node

	first_child: like parent;
			-- First child of current node

	child_put (v: like item) is
			-- Put item `v' at active child position.
		require
			not_child_off: (not child_off)
		local
			node: like parent
		do
			child.put (v)
		ensure
			child_item = v
		end; -- child_put

	last_child: like first_child is
			-- Last child of current node
		do
			child_mark;
			child_finish;
			Result := child;
			child_return
		end; -- last_child

	index_of_child (n: like first_child): INTEGER is
			-- Index of `n' as child of current node;
			-- zero if not a child of current node
		require
			arguments_not_void: not n.Void
		do
			child_mark;
			search_child (n, 1);
			if not child_off then
				Result := child_position
			end; -- if
			child_return;
		end; -- index_of_child

	merge_tree_after (subtree: like first_child) is
			-- Merge `subtree' in current node after  
			-- cursor position.
		require
			not_child_off: not child_off;
			correct_argument: not subtree.Void
				and then subtree.arity > 0
		do
			change_all_parent (subtree);
			merge_right (subtree);
			subtree.wipe_out
		end; -- merge_tree_after

	merge_tree_before (subtree: like first_child) is
			-- Merge `subtree' in current tree before 
			-- cursor position.
		require
			not_child_off: not child_off;
			correct_argument: not subtree.Void
				and then subtree.arity > 0
		do
			change_all_parent (subtree);
			merge_left (subtree);
			subtree.wipe_out
		end; -- merge_tree_after

	put_between (before: like first_child, after: like first_child) is
			-- Put current node between `before' and `after'.
		require
			correct_arguments: not (before.Void or after .Void)
								implies (before.parent = after.parent)
		do
			linkable_put_between (before, after);
			if not before.Void then
				attach_to_parent (before.parent)
			elsif not after.Void then
				attach_to_parent (after.parent)
			end -- if
		end; -- put_between

	duplicate (n: INTEGER): like first_child is
			-- Copy of the sub-tree with children
			-- beginning at cursor position,
			-- and comprising `n' children (or as many as the
			-- number of children at or after cursor
			-- position, if fewer than `n').
		require
			not_child_off: not child_off;
			valid_sublist: n >= 0
		do
			from
				Result.Create (item);
				child_mark
			until
				(not child_offright) implies
					(child_position = backup.child_position + n)
			loop
				Result.put_child_left (child);
				child_forth
			end;
			child_return
		end; -- duplicate

	search_child (sought: like first_child; i: INTEGER) is
			-- Move cursor under `i'-th occurence of `sought' if
			-- exists among children; go child_offright if none.
		require
			arguments_not_void: not sought.Void
		local
			j: INTEGER
		do
			child_mark;
			from
				go_offleft
			invariant
				child_position >= 0
			variant
				arity - child_position
			until
				child_offright or else (j = i)
			loop
				child_forth;
				if (sought = child) then
					j := j + 1
				end -- if
			end;
		end; -- search_child

	put_child (n: like parent) is
			-- Put node `n' at current child position.
		require
			not_child_off: not child_off
		do
			put_child_right (n);
			check
				n.parent = Current
			end;
			remove_child
		ensure
			child = n
		end; -- put_child

-- secret features

	merge_right (subtree: like first_child) is
			-- Just to change the type of `subtree'.
			-- Secret.
		do
			linked_list_merge_right (subtree)
		end; -- merge_right
	
	merge_left (subtree: like first_child) is
			-- Just to change the type of `subtree'.
			-- Secret.
		do
			linked_list_merge_left (subtree)
		end; -- merge_left

	update_after_insertion (new: like first_child; index: INTEGER) is
			-- Redefined from LINKED_LIST.
			-- Case of the first inserted child.
			-- Secret.
		do
			linked_list_update (new, index);
			if index = 1 then
				first_child.attach_to_parent (Current)
			end -- if
		end; -- update_after_insertion

	change_all_parent (subtree: like first_child) is
			-- The parent of all the offsprings of `subtree'
			-- becomes current node.
			-- Secret.
		require
			argument_not_void: not subtree.Void
		do
			from
				subtree.child_start
			until
				subtree.child_offright
			loop
				subtree.child.attach_to_parent (Current);
				subtree.child_forth
			end
		end; -- change_all_parent 

invariant

	child.Void implies child_off

end -- LINKED_TREE [T]

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

