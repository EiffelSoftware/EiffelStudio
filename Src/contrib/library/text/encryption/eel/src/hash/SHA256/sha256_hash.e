note
	description: "Summary description for {SHA256_HASH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHA256_HASH

inherit
	HASH
		undefine
			is_equal
		end

	SHA256

create
	make,
	make_copy

feature -- Access

	block_size: INTEGER = 64
			-- <Precursor>

	output_size: INTEGER = 32
			-- <Precursor>

end
