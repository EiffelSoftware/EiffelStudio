note
	description: "[
			Compute the sizeof C struct memory taking care of padding and alignment.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	STRUCT_SIZE

create
	make

convert
	size: {INTEGER_32}

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			internal_size := 0
			alignment_size := {PLATFORM}.character_8_bytes
		end

feature -- Access

	size: INTEGER
		local
			pad: INTEGER
		do
			Result := internal_size
			pad := Result \\ alignment_size
			if pad /= 0 then
				pad := alignment_size - pad
				Result := Result + pad
			end
		end

	alignment_size: INTEGER

feature {NONE} -- Implementation

	internal_size: INTEGER

feature -- Change

	padding (a_byte_size: INTEGER): INTEGER
		do
			Result := internal_size \\ a_byte_size
			if Result /= 0 then
				Result := a_byte_size - Result
			end
		end

	put_padding (a_byte_size: INTEGER)
		local
			pad: INTEGER
		do
			pad := padding (a_byte_size)
			if pad > 0 then
				internal_size := internal_size + pad -- Padding
			end
		end

	put (a_byte_size: INTEGER)
		do
			put_padding (a_byte_size)
			internal_size := internal_size + a_byte_size
			alignment_size := alignment_size.max (a_byte_size)
		end

	put_inner_struct (a_byte_size: INTEGER; a_struct_alignment: INTEGER)
		do
			put_padding (a_struct_alignment)
			internal_size := internal_size + a_byte_size
			alignment_size := alignment_size.max (a_struct_alignment)
		end

	put_character
		do
			internal_size := internal_size + {PLATFORM}.character_8_bytes
--			alignment_size := alignment_size.max ({PLATFORM}.character_8_bytes)
		end

	put_characters (n: INTEGER)
		do
			internal_size := internal_size + n * {PLATFORM}.character_8_bytes
--			alignment_size := alignment_size.max ({PLATFORM}.character_8_bytes)
		end

	put_natural_8_array (n: INTEGER)
		do
			internal_size := internal_size + n * {PLATFORM}.natural_8_bytes
--			alignment_size := alignment_size.max ({PLATFORM}.natural_8_bytes)
		end

	put_natural_8
		do
			put ({PLATFORM}.natural_8_bytes)
		end

	put_integer_32
		do
			put ({PLATFORM}.integer_32_bytes)
		end

	put_integer_8
		do
			put ({PLATFORM}.integer_8_bytes)
		end

	put_integer_16
		do
			put ({PLATFORM}.integer_16_bytes)
		end

	put_integer_64
		do
			put ({PLATFORM}.integer_64_bytes)
		end

	put_pointer
		do
			put ({PLATFORM}.pointer_bytes)
		end


end
