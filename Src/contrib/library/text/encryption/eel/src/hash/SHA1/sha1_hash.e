note
	description: "Summary description for {SHA1_HASH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHA1_HASH

inherit
	HASH
		undefine
			is_equal
		end

	SHA1

create
	make,
	make_copy

feature -- Access

	block_size: INTEGER = 64
			-- <Precursor>

	output_size: INTEGER = 20
			-- <Precursor>	

end
