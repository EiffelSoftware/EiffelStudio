indexing
   description:"A linked tree based on the GOBO data structure library"
   status:		"See notice at end of class."
   author:		"Andreas Leitner"

class
   DS_LINKED_TREE [G]

inherit
   DS_TRAVERSABLE [G]
      redefine
	 is_empty
      end

creation
   make
feature
   make is
      do
	 internal_cursor := new_cursor
      end

   new_cursor: DS_LINKED_TREE_CURSOR [G] is
	 -- New cursor for traversal
	 -- (from DS_BILINEAR)
      do
	 !! Result.make (Current)
      end;

   item (a_cursor: like new_cursor): G is
      do
	 Result := a_cursor.item
      end

   put_root (v: G) is
      local
	 new_cell: like root_cell
      do
	 !! new_cell.make (v)
	 root_cell := new_cell
      end


   root_cell: DS_LINKED_TREE_CELL [G]
feature -- Measurement

   count: INTEGER is
	 -- Number of items in structure
      local
	 cs: DS_LINKED_TREE_CURSOR [G]
      do
	 --cs := new_cursor
	 if
	    is_empty
	  then
	    Result := 0
	 else
	    Result := 1
	 end
					
      end
   is_empty: BOOLEAN is
      do
	 Result := root_cell = Void
      end

feature -- Status report

feature -- Comparison

   is_equal (other: like Current): BOOLEAN is
	 -- Is current structure equal to `other'?
      do
	 check False end
      end

feature -- Removal

   wipe_out is
	 -- Remove all items from structure.
      do
	 root_cell := Void
      end

feature -- Duplication

   copy (other: like Current) is
	 -- Copy `other' to list.
      do
	 check False end
      end;


feature -- Children

   put_first_child (v: G; a_cursor: like new_cursor) is
	 -- Add `v' to beginning of list.
      do
	 a_cursor.children.put_first (v)
      end

   put_last_child (v: G; a_cursor: like new_cursor) is
	 -- Add `v' to end of list.
      do
	 a_cursor.children.put_last (v)
      end

   put_left_child (v: G; a_cursor: like new_cursor) is
	 -- Add `v' to left of `a_cursor' position.
      do
	 a_cursor.children.put_left (v, a_cursor.children_cursor)
      end

   put_right_child (v: G; a_cursor: like new_cursor) is
	 -- Add `v' to right of `a_cursor' position.
      do
	 a_cursor.children.put_right_cursor (v, a_cursor.children_cursor)
      end
		
feature {NONE}
   move_all_cursors_after is
	 -- Move `after' all cursors.
      local
	 a_cursor, next_cursor: like new_cursor
      do
	 from a_cursor := internal_cursor until (a_cursor = Void) loop
	    a_cursor.set_after
	    next_cursor := a_cursor.next_cursor
	    a_cursor.set_next_cursor (Void)
	    a_cursor := next_cursor
	 end
      end   
		
end -- class DS_LINKED_TREE

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
