indexing
	description:"Cursor for DS_LINKED_TREE_CHILDREN_LIST"
	status:		"See notice at end of class."
	author:		"Andreas Leitner"

class
	DS_LINKED_TREE_CHILDREN_CURSOR [G]

inherit
	DS_BILINKED_LIST_CURSOR [G]
		redefine
			container,
			current_cell
		end

creation
	make

feature -- Initialization

feature -- Access
	container: DS_LINKED_TREE_CHILDREN_LIST [G]
			-- List traversed

feature {DS_LINKED_TREE_CURSOR}
	go_to_cell (a_cell: like current_cell) is
		require -- from DS_LINEAR_CURSOR
			valid_cursor: is_valid
			a_cell /= Void
			container.has_cell (a_cell)
		do
			current_cell := a_cell
			before := False
			after := False
		end;


feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature -- {DS_LINKED_LIST, DS_LINKED_LIST_SEARCHER} -- Implementation

	current_cell: DS_LINKED_TREE_CELL [G]
			-- Cell at cursor position

feature {NONE} -- Implementation

invariant
	invariant_clause: -- Your invariant here

end -- class DS_LINKED_TREE_CHILDREN_CURSOR
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
