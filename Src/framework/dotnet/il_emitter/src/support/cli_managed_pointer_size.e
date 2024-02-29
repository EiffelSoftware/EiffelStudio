note
	description: "[
			Compute the size of the expected memory.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_MANAGED_POINTER_SIZE

create
	make

convert
	size: {INTEGER_32}

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			internal_size := 0
		end

feature -- Access

	size: INTEGER
		do
			Result := internal_size
		end

feature {NONE} -- Implementation

	internal_size: INTEGER

feature -- Change

	put_padding (pad: INTEGER)
		do
			internal_size := internal_size + pad
		end

	put_character
		do
			internal_size := internal_size + {PLATFORM}.character_8_bytes
		end

	put_natural_8_array (n: INTEGER)
		do
			internal_size := internal_size + n * {PLATFORM}.natural_8_bytes
		end

	put_natural_8
		do
			internal_size := internal_size + {PLATFORM}.natural_8_bytes
		end

	put_natural_32
		do
			internal_size := internal_size + {PLATFORM}.natural_32_bytes
		end

	put_integer_32
		do
			internal_size := internal_size + {PLATFORM}.integer_32_bytes
		end

	put_integer_8
		do
			internal_size := internal_size + {PLATFORM}.integer_8_bytes
		end

	put_integer_16
		do
			internal_size := internal_size + {PLATFORM}.integer_16_bytes
		end

	put_integer_64
		do
			internal_size := internal_size + {PLATFORM}.integer_64_bytes
		end

	put_pointer
		do
			internal_size := internal_size + {PLATFORM}.pointer_bytes
		end

end
