indexing
   description:"Cursor class for flexible iteration through%
   %DS_LINKED_TREE objects."
   status:		"See notice at end of class."
   author:		"Andreas Leitner"

class
   DS_LINKED_TREE_CURSOR [G]

inherit
   DS_CURSOR [G]

creation
   make

feature -- Initialization
feature {NONE} -- Initialization

   make (tree: like container) is
	 -- Create a new cursor for `tree'.
      require
	 list_not_void: tree /= void
      do
	 container := tree
	 before_root := True
      ensure
	 container_set: container = tree;
	 before_root: before_root
      end;

feature -- Access

   container: DS_LINKED_TREE [G]

feature -- Status report

   is_root: BOOLEAN is
	 -- Is cursor on root item?
      require
	 not_off: not off
      do
	 Result := (not off) and then (container.root_cell = current_cell)
      end

   depth: INTEGER is
      require
	 not_off: not off
      do
	 Result := current_cell.depth
      end


   is_leaf: BOOLEAN is
      require
	 not_off: not off
      do
	 Result := current_cell.is_leaf
      end

   is_valid: BOOLEAN is
	 -- Is cursor valid?
	 -- (A cursor might become invalid if `container'
	 -- has been modified during traversal.)
	 -- (from DS_CURSOR)
	 --
	 -- Note: `is_valid' is now obsolte with GOBO 1.5 (check out what 
	 -- needs to be changed).
      local
	 a_cell: like current_cell
      do
	 -- TODO: !!!
	 --check False end
	 Result := True
		
      end
		
   same_position (other: like Current): BOOLEAN is
	 -- Is internal cursor at same position as `a_cursor'?
      do
	 Result := current_cell = other.current_cell and
		   before_root = other.before_root and after_leaf = other.after_leaf	 
      end   
   

   before_root: BOOLEAN
   after_leaf: BOOLEAN

feature -- Cursor movement

   to_root is
	 -- move cursor to the root cell of `container`.
      do
	 before_root := False
	 current_cell := container.root_cell
	 after_leaf := current_cell = Void
	 update_children_cursor
      end;

   down is
      require
	 no_leaf: not is_leaf
	 current_child_not_off: not child_off
      do
	 if
	    before_root
	  then
	    current_cell := container.root_cell
	 else
	    current_cell := children_cursor.current_cell
	 end
	 after_leaf := current_cell = Void
	 update_children_cursor
      end

   up is
      local
	 p: like current_cell
      do
	 p := current_cell
	 if after_leaf then
	    -- TODO: !!!
	    check False end
	 else
	    current_cell := current_cell.parent
	 end
	 update_children_cursor
	 children_cursor.go_to_cell (p)

      end


   off: BOOLEAN is
	 -- Is there no item at cursor position?
      do
	 Result := current_cell = Void
      end

   item: G is
	 -- Item at cursor position
      do
	 Result := current_cell.item
      end;

   has (v: like item): BOOLEAN is
	 -- Has the subtree item v?
	 -- (comparsion by reference)
      local
	 cs: like Current
      do
	 if
	    v = item
	  then
	    Result := True
	 else
	    if
	       not is_leaf
	     then
	       from
		  cs := clone (Current)
		  cs.update_children_cursor
		  cs.child_start
	       until
		  cs.child_off or Result = True
	       loop
		  cs.down
		  if
		     cs.has (v) = True
		   then
		     Result := True
		  end
		  cs.up
		  cs.child_forth
	       end
	    end
	 end
      end


feature {DS_LINKED_TREE_CURSOR, DS_LINKED_TREE} -- Implementation
   current_cell: DS_LINKED_TREE_CELL [G]

   children_cursor: DS_LINKED_TREE_CHILDREN_CURSOR [G]
	 -- cursor to children.
	 -- if you store a reference to this `children_cursor'
	 -- be aware that it does not automatically update
	 -- when you traverse up or down in the tree

   children: DS_LINKED_TREE_CHILDREN_LIST [G] is
      do
	 Result := current_cell.children
      end


feature -- {NONE}
   update_children_cursor is
      do
	 if
	    off
	  then
	    children_cursor := Void
	 else
	    children_cursor := current_cell.children.new_cursor
	 end
      end

feature -- Children Cursor
   child_index: INTEGER is
	 -- Index of current position
      do
	 Result := children_cursor.index
      end

   child_item: G is
	 -- Item at cursor position
      do
	 Result := children_cursor.item
      end
	
feature -- Status report

   child_after: BOOLEAN is
	 -- Is there invalid position to right of cursor?
      do
	 Result := children_cursor.after
      end

   child_before: BOOLEAN is
	 -- Is there no valid position to left of cursor?
      do
	 Result := children_cursor.before
      end

   is_first_child: BOOLEAN is
	 -- Is cursor on the first item?
      do
	 Result := children_cursor.is_first
      end

   is_last_child: BOOLEAN is
	 -- Is cursor on the last child_item?
      do
	 Result := children_cursor.is_last
      end

   is_valid_child: BOOLEAN is
	 -- Is cursor valid?
      do
	 Result := children_cursor.is_valid
      end

   child_off: BOOLEAN is
	 -- Is there no child_item at cursor position?
      do
	 Result := children_cursor.off
      end

   valid_child_index (i: INTEGER): BOOLEAN is
	 -- Is `i' a valid index value?
      do
	 Result := children_cursor.valid_index (i)
      end
	
feature -- Cursor movement

   child_back is
	 -- Move cursor to previous position.
      do
	 children_cursor.back
      end

   child_finish is
	 -- Move cursor to last position.
      do
	 children_cursor.finish
      end

   child_forth is
	 -- Move cursor to next position.
      do
	 children_cursor.forth
      end

   child_go_to (i: INTEGER) is
	 -- Move cursor to `i'-th position.
      do
	 children_cursor.go_to (i)
      end

   child_search_back (v: G) is
	 -- Move to first position at or before current
	 -- position where `child_item' and `v' are equal.
	 -- (Use `searcher''s comparison criterion from `children_cursor.container'.)
	 -- Move `before' if not found.
      do
	 children_cursor.search_back (v)
      end

   child_search_forth (v: G) is
	 -- Move to first position at or after current
	 -- position where `child_item' and `v' are equal.
	 -- (Use `searcher''s comparison criterion from `children_cursor.container'.)
	 -- Move `after' if not found.
      do
	 children_cursor.search_forth (v)
      end

   child_start is
	 -- Move cursor to first position.
      do
	 children_cursor.start
      end
	
feature -- Element change

   child_put (v: G) is
	 -- Replace child_item at cursor position by `v'.
      do
	 children_cursor.put (v)
      end

end -- class DS_LINKED_TREE_CURSOR

--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Arndtgasse 1/3/5
--| 8010 Graz
--| Austria
--| email: andreas.leitner@chello.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------












