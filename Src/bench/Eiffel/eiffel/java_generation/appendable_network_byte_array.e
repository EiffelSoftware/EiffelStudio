indexing
	description: "extends NETWORK_BYTE_ARRAY to be appendable (also in the middle of the stream"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPENDABLE_NETWORK_BYTE_ARRAY

inherit
	NETWORK_BYTE_ARRAY
		rename
			make as basic_make
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			basic_make (Initial_size)
			position := 1
							
		end
			
	make_size (a_size: INTEGER) is
		require
			valid_size: a_size >= 0
		do
			basic_make (a_size)
			position := 1
		end

feature {ANY}
			
feature {ANY}
			
	Initial_size: INTEGER is 50
	Inc_size: INTEGER is 50
			
	position: INTEGER
			-- position of cursor in array
			
feature {NONE}
			
	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		require
			pos_large_enough: i > 0
			pos_small_enough: i <= size
		do
			position := i
		end
			
feature {ANY}
			
	append_uint_8_from_int (i: INTEGER) is
			-- puts the 8 least significant bits of `i' at `position'
			-- using network byte order
			-- enlarges
		require
			i_positive: i >= 0
			i_small_enough: i < 256 -- 2^8
		local
			new_position: INTEGER
		do
			new_position := position + Int_8_size
			if new_position > size then
				resize (size + Inc_size)
			end
			put_uint_8_from_int (i, position);
			position := new_position
		end
			
	append_uint_16_from_int (i: INTEGER) is
			-- puts the 16 least significant bits of `i' at `pos'
			-- using network byte order
		require
			i_positive: i >= 0
			i_small_enough: i < 65536 -- 2^16
		local
			new_position: INTEGER
		do
			new_position := position + Int_16_size
			if new_position > size then
				resize (size + Inc_size)
			end
			put_uint_16_from_int (i, position);
			position := new_position
		end
			
	append_sint_16_from_int (i: INTEGER) is
			-- puts the 16 least significant bits of `i' at `pos'
			-- using network byte order
		require
			i_big_enough: i >= -32768
			i_small_enough: i <= 32767
		local
			new_position: INTEGER
		do
			new_position := position + Int_16_size
			if new_position > size then
				resize (size + Inc_size)
			end
			put_sint_16_from_int (i, position);
			position := new_position
		end
			
	append_uint_32_from_int (i: INTEGER) is
			-- puts the 32 least significant bits of `i' at `pos'
			-- using network byte order
			-- Note: on most machines INTEGER is only 32 bit and signed,
			-- so there should never be an overflow here
		require
			i_positive: i >= 0
			i_small_enough: i < 4294967296 -- 2^32
		local
			new_position: INTEGER
		do
			new_position := position + Int_32_size
			if new_position > size then
				resize (size + Inc_size)
			end
			put_uint_32_from_int (i, position)
			position := new_position
		end
			
	append_sint_32_from_int (i: INTEGER) is
			-- puts the 32 least significant bits of `i' at `pos'
			-- using network byte order
			-- Note: on most machines INTEGER is only 32 bit and signed,
			-- so there should never be an overflow here
		require
			i_big_enough: i >= -2147483648
			i_small_enough: i <= 2147483647
		local
			new_position: INTEGER
		do
			new_position := position + Int_32_size
			if new_position > size then
				resize (size + Inc_size)
			end
			put_sint_32_from_int (i, position)
			position := new_position
		end
			
	append_uint_64_from_int_64 (i: INTEGER_64) is
			-- puts the 64 least significant bits of `i' at `pos'
			-- using network byte order
		require
			i_positive: i >= 0
			i_small_enough: i < 18446744073709551616 -- 2^64
		local
			new_position: INTEGER
		do
			new_position := position + Int_64_size
			if new_position > size then
				resize (size + Inc_size)
			end
			put_uint_64_from_int_64 (i, position);
			position := new_position
		end
			
	append_sint_64_from_int_64 (i: INTEGER_64) is
			-- puts the 64 least significant bits of `i' at `pos'
			-- using network byte order
			-- Note: on most machines INTEGER is only 32 bit and signed,
			-- so there should never be an overflow here
		require
			i_positive: i >= 0
			i_small_enough: i < 18446744073709551616 -- 2^64	Double_size: INTEGER is 8
			

		local
			new_position: INTEGER
		do
			new_position := position + Int_64_size
			if new_position > size then
				resize (size + Inc_size)
			end
			put_sint_64_from_int_64 (i, position);
			position := new_position
		end
			
	append_utf8_from_string (s: STRING) is
			-- puts `s' at pos
			-- byte for byte from `s' will be written to the array
			-- there will be no additional info on size or a terminating
			-- zero character. You have to provide this information yourself
		require	
			s_not_void: s /= Void
			s_short_enought: s.count < 65536 -- 2^16
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := s.count
							-- First write the string count
			until
				i > nb
			loop
				append_uint_8_from_int (s.item (i).code)
				i := i + 1
			end
		end
			
	append_byte_code (other: APPENDABLE_NETWORK_BYTE_ARRAY) is
			-- appends all bytes from `other' (in the range of
			-- 0..`other.position' to `Current' starting at (position + `Int_8_size'))
			-- Note: seems to be buggy, needs some work!
		require
			other_not_void: other /= Void
		local
			new_position: INTEGER
			other_area: like area
		do
			check
				buggy: False
			end
			new_position := position + other.position - 1
			if
				new_position > size
			then
				resize (new_position + Inc_size)
			end
			other_area := other.area
			ca_copy ($other_area, $area, other.position - 1, position)
		end
						
	append_double_from_double (d: DOUBLE) is
			-- Note: `put_double_from_double' does not seem to work. FIXME
		local
			new_position: INTEGER
		do
			new_position := position + Double_size
			if new_position > size then
				resize (size + Inc_size)
			end
			put_double_from_double (d, position);
			position := new_position
		end
			
	append_float_from_real (f: REAL) is
		local
			new_position: INTEGER
		do
			new_position := position + Float_size
			if new_position > size then
				resize (size + Inc_size)
			end
			put_float_from_real (f, position);
			position := new_position
		end
			


end -- class JVM_BYTE_CODE





