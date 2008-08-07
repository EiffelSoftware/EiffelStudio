indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_SIZE

feature {NONE} -- Initialization

	make
		do
			size := 0
		end

feature -- Access

	size: INTEGER
			-- Heading size from 1 to 6

feature -- Element change

	set_size (v: like size)
		require
			valid_size: v >= 1 and v <= 6
		do
			size := v
		end
		
end
