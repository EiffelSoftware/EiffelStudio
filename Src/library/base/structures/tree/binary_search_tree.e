--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Binary search trees

indexing

	names: binary_search_tree, tree;
	representation: recursive, array;
	access: cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class BINARY_SEARCH_TREE [G -> PART_COMPARABLE] inherit

	BINARY_TREE [G]
		rename
			make as bt_make,
			put as bt_put,
			min as bt_min,
			max as bt_max
		export {BINARY_SEARCH_TREE}
			put_left_child, put_right_child,
			remove_left_child, remove_right_child
		redefine
			parent, has
		end

creation

	make

feature -- Creation

	make (v: like item) is
			-- Create single node with item `v'.
		do
			bt_make (v);
			depth := 0;
			balanced := true
		ensure
			node_item: item = v;
			binary_tree_arity: arity = 2;
			no_child: (left_child = Void) and (right_child = Void)
		end;

feature -- Access

	parent: BINARY_SEARCH_TREE [G];
			-- Parent of `Current'

 	has (v: like item): BOOLEAN is
			-- Is there a node with item `v' in `Current'?
			-- (According to the `='
			-- discrimination rule)
		require else
			item_exists: v /= Void
		do
			if v = item then
                Result := true
            elseif v < item then
                Result := (left_child /= Void) and then
                    left_child.has (v)
            else
                Result := (right_child /= Void) and then
                    right_child.has (v)
            end
   		end;

	min: like item is
			-- Minimum in `Current'
		do
			if has_left then
				Result := left_child.min
			elseif has_right then
				Result := right_child.min
			else
				Result := item
			end
		end;

	max: like item is
			-- Maximum in `Current'
		do
			if has_right then
				Result := right_child.max
			elseif has_left then
				Result := left_child.max
			else
				Result := item
			end
		end;

	median: like item is
			-- Median in `Current'
		do
			Result := item
		end;

feature -- Insertion

	put (v: like item) is
			-- Put `v' at proper position in tree
			-- (unless `v' exists already).
			-- (Comparisons are made according to the
			-- currently adopted discrimination rule)
		require
			new_item_exists: v /= Void
		do
			if v /= item then
                if v < item then
                    if left_child = Void then
                        put_left_child (new_tree (v))
                    else
                        left_child.put (v)
                    end
                else
                    if right_child = Void then
                        put_right_child (new_tree (v))
                    else
                        right_child.put (v)
                    end
                end;
                balanced := false
            end
		ensure
			item_inserted: has (v)
		end;

feature -- Transformation

	sort is
			-- Sort `Current'.
			--| Very dumb implementation: insert all nodes from
			--| a `sequential_representation'.
		local
			seq: SEQUENTIAL [G]
		do
			seq := sequential_representation;
			from
				seq.start;
				wipe_out
			until
				seq.off
			loop
				put (seq.item);
				seq.forth
			end;
			balance
		end;

feature -- Cursor

	node_action (v: like item) is
			-- Operation on node item,
			-- to be defined by descendant classes.
			-- Here it is defined as an empty operation.
			-- Redefine this procedure in descendant classes if useful
			-- operations are to be performed during traversals.
		do
		end;

	preorder is
			-- Apply `node_action' to every node's item
			-- in `Current' using pre-order.
		do
			node_action (item);
			if left_child /= Void then
				left_child.preorder
			end;
			if right_child /= Void then
				right_child.preorder
			end
		end;

	i_infix is
			-- Apply node_action to every node's item
			-- in `Current' using infix order.
		do
			if left_child /= Void then
				left_child.i_infix
			end;
			node_action (item);
			if right_child /= Void then
				right_child.i_infix
			end
		end;

	postorder is
			-- Apply node_action to every node's item
			-- in `Current' using post-order.
		do
			if left_child /= Void then
				left_child.postorder
			end;
			if right_child /= Void then
				right_child.postorder
			end;
			node_action (item)
		end;

feature -- Implementation features

	balanced: BOOLEAN;
			-- Is the node balanced ?
			-- true if depths of children differ by 0 or 1

	balance is
			-- Balance current tree: depths of children will
			-- differ by 0 or 1.
		local
			dd: INTEGER;
		do
			if not balanced then
				from
					dd := depth_difference
				until
					balanced
				loop
					if dd > 1 then
						balance_child_right
					elseif dd < - 1 then
						balance_child_left
					else
						balanced := true;
						if left_child.depth > right_child.depth then
							depth := left_child.depth + 1
						else
							depth := right_child.depth + 1
						end
					end;
					dd := depth_difference
				end
			end
		ensure
			is_balanced: balanced
		end;

feature {BINARY_SEARCH_TREE} -- Number of elements

	depth: INTEGER;
			-- Depth of tree whose root is `Current'.
			-- Meaningful only when balanced is true

feature {BINARY_SEARCH_TREE} -- Implementation features

	set_unbalanced is
			-- Set `balanced' to `false'.
			-- Depth is not meaningful anymore.
		do
			balanced := false
		end;

feature {NONE} -- Secret

	balance_child_left is
			-- Balance on the left side.
		local
			t, ll, lr: like Current
		do
			ll := left_child.left_child;
			lr := left_child.right_child;
			if ll = Void then
				!! t.make (item);
				bt_put (lr.item);
				put_right_child (t);
				left_child.remove_right_child
			elseif lr = Void then
				!! t.make (item);
				bt_put (left_child.item);
				put_right_child (t);
				put_left_child (ll)
			elseif lr.depth > ll.depth then
				!! t.make (item);
				t.set_unbalanced;
				if right_child /= Void then
					t.put_right_child (right_child);
				end;
				if lr.right_child /= Void then
					t.put_left_child (lr.right_child);
				end;
				bt_put (lr.item);
				if lr.left_child /= Void then
					left_child.put_right_child (lr.left_child)
				else
					left_child.remove_right_child
				end;
				left_child.set_unbalanced;
				put_right_child (t)
			else
				!! t.make (item);
				if right_child /= Void then
					t.put_right_child (right_child)
				end;
				t.set_unbalanced;
				t.put_left_child (lr);
				put_right_child (t);
				bt_put (left_child.item);
				put_left_child (ll)
			end
		end;

	balance_child_right is
			-- Balance on the right side.
		local
			t, rl, rr: like Current
		do
			rl := right_child.left_child;
			rr := right_child.right_child;
			if rr = Void then
				!! t.make (item);
				bt_put (rl.item);
				put_left_child (t);
				right_child.remove_left_child
			elseif rl = Void then
				!! t.make (item);
				bt_put (right_child.item);
				put_left_child (t);
				put_right_child (rr)
			elseif rl.depth > rr.depth then
				!! t.make (item);
				t.set_unbalanced;
				if left_child /= Void then
					t.put_left_child (left_child)
				end;
				if rl.left_child /= Void then
					t.put_right_child (rl.left_child)
				end;
				bt_put (rl.item);
				if rl.right_child /= Void then
					right_child.put_left_child (rl.right_child)
				else
					right_child.remove_left_child
				end;
				right_child.set_unbalanced;
				put_left_child (t)
			else
				!! t.make (item);
				if left_child /= Void then
					t.put_left_child (left_child)
				end;
				t.put_right_child (rl);
				t.set_unbalanced;
				put_left_child (t);
				bt_put (right_child.item);
				put_right_child (rr)
			end
		end;

	depth_difference: INTEGER is
			-- Difference in depth between the left
			-- and the right sibling
		do
			if right_child = Void then
				if left_child = Void then
					balanced := true;
					depth := 0;
					Result := 0
				else
					left_child.balance;
					if left_child.depth = 0 then
						balanced := true;
						depth := 1
					end;
					Result := - 1 - left_child.depth
				end
			elseif left_child = Void then
				right_child.balance;
				if right_child.depth = 0 then
					balanced := true;
					depth := 1
				end;
				Result := right_child.depth + 1
			else
				right_child.balance;
				left_child.balance;
				Result := right_child.depth - left_child.depth
			end
		end;

feature {NONE} -- Creation

	new_tree (v: like item): like Current is
			-- Newly allocated node with `tree_item' set to `v'.
		do
			!! Result.make (v)
		ensure
			new_tree_exist: Result /= Void;
			new_tree_item: Result.item = v
		end

feature

   --sorted: BOOLEAN is
         -- Is `Current' sorted?
      --local
         --m: like item
      --do
         --if empty then
            --Result := true
         --else
            --from
               --start;
               --m := item;
               --forth
            ----until
               --exhausted or else (item < m)
            --loop
               --m := item;
               --forth
            --end;
            --Result := exhausted
         --end
      --end

end -- class BINARY_SEARCH_TREE
