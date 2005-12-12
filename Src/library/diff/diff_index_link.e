indexing
	description: "This are objects that are used internaly by the diff algorithm to store a list of indices that are a match."
	author: "Patrick Ruckstuhl"
	date: "$Date$"
	revision: "$Revision$"

class
	DIFF_INDEX_LINK

create
	make

feature {NONE} -- Initialization

	make (a_link: DIFF_INDEX_LINK; a_src: INTEGER; a_dst: INTEGER) is
			-- Create the element
		do
			next := a_link
			index_src := a_src
			index_dst := a_dst
		end


feature -- Access

	index_src: INTEGER
			-- The source index of the link.

	index_dst: INTEGER
			-- The destination index of the link.

	next: DIFF_INDEX_LINK
			-- The next link (or void if none)

end
