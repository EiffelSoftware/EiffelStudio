indexing
	description:"The list of children items a DS_LINKED_TREE has"
	status:		"See notice at end of class."
	author:		"Andreas Leitner"

class
	DS_LINKED_TREE_CHILDREN_LIST [G]

inherit
	DS_BILINKED_LIST [G]
		rename
			make as make_list
		redefine
			first_cell,
			last_cell,
			new_cursor,
			put_first,
			put_last
		end
creation
	make

feature -- Initialization
	make (a_parent_cell: like parent_cell) is
		do
			make_list
			parent_cell := a_parent_cell
		end
feature -- Access

	new_cursor: DS_LINKED_TREE_CHILDREN_CURSOR [G] is
			-- New cursor for traversal
		do
			!! Result.make (Current)
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change
	put_last (v: G) is
		local
			old_cell: like first_cell
		do
			if is_empty then
				!! first_cell.make (v);
				last_cell := first_cell;
				count := 1
				first_cell.put_parent (parent_cell)
			else
				old_cell := last_cell;
				!! last_cell.make (v);
				old_cell.put_right (last_cell);
				count := count + 1
			end
		end;

	put_first (v: G) is
		local
			old_cell: like first_cell
		do
			if is_empty then
				!! first_cell.make (v);
				last_cell := first_cell;
				count := 1
				first_cell.put_parent (parent_cell)
			else
				old_cell := first_cell;
				!! first_cell.make (v);
				first_cell.put_right (old_cell);
				count := count + 1
			end
		end;


feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

   --feature {DS_LINKED_LIST, DS_LINKED_LIST_CURSOR, DS_LINKED_LIST_SEARCHER, DS_LINKED_TREE_CURSOR} -- Implementation
feature {DS_LINKED_LIST, DS_LINKED_LIST_CURSOR, DS_LINKED_TREE_CURSOR} -- Implementation

	first_cell: DS_LINKED_TREE_CELL [G]
			-- First cell in list
	last_cell: like first_cell
			-- Last cell in list
	parent_cell: like first_cell

	has_cell (a_cell: like first_cell): BOOLEAN is
		local
			cs: DS_LINKED_LIST_CURSOR [G]
			found: BOOLEAN
		do
			from
				cs := new_cursor
				cs.start
			until
				cs.off or found
			loop
				if
					cs.current_cell = a_cell
				then
					Result := True
					found := True
				end
				cs.forth
			end
		end



invariant
	invariant_clause: -- Your invariant here

end -- class DS_LINKED_TREE_CHILDREN_LIST
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
