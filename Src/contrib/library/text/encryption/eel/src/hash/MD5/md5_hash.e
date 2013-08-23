note
	description: "Summary description for {MD5_HASH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD5_HASH

inherit
	HASH
		undefine
			is_equal
		end

	MD5

create
	make,
	make_copy

feature -- Access

	block_size: INTEGER = 64
			-- <Precursor>	

	output_size: INTEGER = 16
			-- <Precursor>

end
