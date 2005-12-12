indexing
	description: "Base class for diff line indices."
	author: "Patrick Ruckstuhl"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIFF_LINE

feature {DIFF_LINE} -- Initialization

	feature make(a_src_index: INTEGER; a_dst_index: INTEGER) is
			-- Create a match index pair.
		do
			src := a_src_index
			dst := a_dst_index
		end


feature -- Access

	src: INTEGER
			-- The index in the source.

	dst: INTEGER
			-- The index in the destination.

end
