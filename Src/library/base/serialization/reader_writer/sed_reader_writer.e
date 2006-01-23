indexing
	description: "Ancestor for reading/writing basic known entities from and to a particular % 
		%location specified in concrete descendants of current."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SED_READER_WRITER

feature -- Header/Footer

	read_header is
			-- Action being executed before starting to read data.
		do
		end

	write_header is
			-- Action being executed before starting to write data.
		do
		end

	read_footer is
			-- Action being executed after finishing to read data.
		do
		end

	write_footer is
			-- Action being executed after finishing to write data.
		do
		end

feature -- Status report

	is_ready_for_reading: BOOLEAN is
			-- Is Current ready for future read operations?
		deferred
		end

	is_ready_for_writing: BOOLEAN is
			-- Is Current ready for future write operations?
		deferred
		end

	is_pointer_value_stored: BOOLEAN
			-- Is value of a POINTER stored?

feature -- Settings

	set_is_pointer_value_stored (v: like is_pointer_value_stored) is
			-- Set `is_pointer_value_stored' with `v'.
		do
			is_pointer_value_stored := v	
		ensure
			is_pointer_value_stored_set: is_pointer_value_stored = v
		end

feature -- Access

	read_character_8: CHARACTER is
			-- Read next 8-bits character
		require
			is_ready: is_ready_for_reading
		local
			l_nat8: NATURAL_8
		do
			l_nat8 := read_natural_8
			Result := l_nat8.to_character
		end

	read_string_8: STRING is
			-- Read next 8-bits sequence of character
		require
			is_ready: is_ready_for_reading
		local
			i, nb: INTEGER
		do
				-- Although we are reading a NATURAL_32, the value
				-- is not bigger than INTEGER_32.max_value since
				-- `count' of STRING is still an INTEGER_32.
			nb := read_compressed_natural_32.to_integer_32
			create Result.make (nb)
			from
				i := 1
				nb := nb + 1
			until
				i = nb
			loop
				Result.append_character (read_character_8)
				i := i + 1
			end
		ensure
			read_string_8_not_void: Result /= Void
		end

	read_boolean: BOOLEAN is
			-- Read next boolean
		require
			is_ready: is_ready_for_reading
		local
			l_nat: NATURAL_8
		do
			l_nat := read_natural_8
			Result := l_nat = 1
		end

	read_natural_8: NATURAL_8 is
			-- Read next natural_8
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_natural_16: NATURAL_16 is
			-- Read next natural_16
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_natural_32: NATURAL_32 is
			-- Read next natural_32
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_natural_64: NATURAL_64 is
			-- Read next natural_64
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_integer_8: INTEGER_8 is
			-- Read next integer_8
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_integer_16: INTEGER_16 is
			-- Read next integer_16
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_integer_32: INTEGER is
			-- Read next integer_32
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_integer_64: INTEGER_64 is
			-- Read next integer_64
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_real_32: REAL is
			-- Read next real_32
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_real_64: DOUBLE is
			-- Read next real_64
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_pointer: POINTER is
			-- Read next pointer
		require
			is_ready: is_ready_for_reading
		deferred
		end
		
	read_compressed_integer_32: INTEGER is
			-- Read next compressed integer_32.
			-- See `read_compressed_natural_32' for more details about encoding.
		require
			is_ready: is_ready_for_reading
		do
			Result := read_compressed_natural_32.as_integer_32
		end
		
	read_compressed_natural_32: NATURAL_32 is
			-- Read next compressed natural_32.
			-- Depending on first natural_8 value read, it will tell how much more we need to read:
			-- 1 - Of the form 0xxxxxxx (0x00) for values between 0 and 127
			-- 2 - Of the form 10xxxxxx (0x80) for values between 128 and 16382 and one more to read.
			-- 3 - Of the form 110xxxxx (0xC0) for values between 16383 and 2097150 and 2 more to read.
			-- 4 - Of the form 110xxxxx (0xE0) for values between 2097151 and 268435454 and 3 more to read
			-- 5 - Otherwise a full natural_32 to read.
		require
			is_ready: is_ready_for_reading
		local
			l_nat8: NATURAL_8
		do
			l_nat8 := read_natural_8
			if l_nat8 & 0x80 = 0 then
					-- Values between 0 and 127
				Result := l_nat8
			elseif l_nat8 & 0xC0 = 0x80 then
					-- Values between 128 and 16382
				Result := ((l_nat8.as_natural_32 & 0x0000003F) |<< 8) | 
					(read_natural_8.as_natural_32)
			elseif l_nat8 & 0xE0 = 0xC0 then
					-- Values between 16383 and 2097150
				Result := ((l_nat8.as_natural_32 & 0x0000001F) |<< 16) |
					(read_natural_8.as_natural_32 |<< 8) | 
					(read_natural_8.as_natural_32)
			elseif l_nat8 & 0xF0 = 0xE0 then
					-- Values between 2097151 and 268435454
				Result := ((l_nat8.as_natural_32 & 0x0000000F) |<< 24) |
					(read_natural_8.as_natural_32 |<< 16) |
					(read_natural_8.as_natural_32 |<< 8) |
					(read_natural_8.as_natural_32)
			else
					-- Values between 268435455 and 4294967295
				Result := read_natural_32
			end
		end

feature -- Element change

	write_character_8 (v: CHARACTER) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		do
			write_natural_8 (v.code.to_natural_8)
		end
		
	write_string_8 (v: STRING) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
			v_not_void: v /= Void
		local
			i, nb: INTEGER
		do
			write_compressed_natural_32 (v.count.to_natural_32)
			from
				i := 1
				nb := v.count + 1
			until
				i = nb
			loop
				write_character_8 (v.item (i))
				i := i + 1
			end
		end

	write_boolean (v: BOOLEAN) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		do
			if v then
				write_natural_8 (1)
			else
				write_natural_8 (0)
			end
		end

	write_natural_8 (v: NATURAL_8) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_natural_16 (v: NATURAL_16) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_natural_32 (v: NATURAL_32) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_natural_64 (v: NATURAL_64) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_integer_8 (v: INTEGER_8) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_integer_16 (v: INTEGER_16) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_integer_32 (v: INTEGER) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_integer_64 (v: INTEGER_64) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_real_32 (v: REAL) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_real_64 (v: DOUBLE) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_pointer (v: POINTER) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_compressed_integer_32 (v: INTEGER) is
			-- Write `v' as a compressed integer_32.
			-- See `write_compressed_natural_32' for details about encoding.
		require
			is_ready: is_ready_for_writing
		do
			write_compressed_natural_32 (v.as_natural_32)
		end
		
	write_compressed_natural_32 (v: NATURAL_32) is
			-- Write `v' as a compressed natural_32.
			-- Depending on value of `v', it will tell how many natural_8 will 
			-- be written. Below here is the actual encoding where `x' represents
			-- a meaningful bit for `v' and the last number in parenthesis is the 
			-- marker value in hexadecimal which is added to the value of `v'.
			-- 1 - For values between 0 and 127, write 0xxxxxxx (0x00).
			-- 2 - For values between 128 and 16382, write 0x10xxxxxx xxxxxxxx (0xE0).
			-- 3 - For values between 16383 and 2097150, write 0x110xxxxx xxxxxxxx xxxxxxxx (0xC0).
			-- 4 - For values between 2097151 and 268435454, write 0x1110xxx xxxxxxxx xxxxxxxx xxxxxxxx (0xE0).
			-- 5 - Otherwise write `v' as a full natural_32.
		require
			is_ready: is_ready_for_writing
		do
				-- Perform a pseudo binary search on the 0x00004000 value
				-- so that we have less checks to do for values above 0x00004000.
				-- If have one more check for values less than 0x00000080, but
				-- experience shows that they don't occur often.
			if v < 0x00004000 then
				if v < 0x00000080 then
						-- Values between 0 and 127.
					write_natural_8 (v.as_natural_8)
				else
						-- Values between 128 and 16382.
					write_natural_8 ((((v | 0x00008000) & 0x0000FF00) |>> 8).as_natural_8)
					write_natural_8 ((v & 0x000000FF).as_natural_8)
				end
			elseif v < 0x00200000 then
					-- Values between 16383 and 2097150.
				write_natural_8 ((((v | 0x00C00000) & 0x00FF0000) |>> 16).as_natural_8)
				write_natural_8 (((v & 0x0000FF00) |>> 8).as_natural_8)
				write_natural_8 ((v & 0x000000FF).as_natural_8)
			elseif v < 0x10000000 then
					-- Value between 2097151 and 268435454.
				write_natural_8 ((((v | 0xE0000000) & 0xFF000000) |>> 24).as_natural_8)
				write_natural_8 (((v & 0x00FF0000) |>> 16).as_natural_8)
				write_natural_8 (((v & 0x0000FF00) |>> 8).as_natural_8)
				write_natural_8 ((v & 0x000000FF).as_natural_8)
			else
					-- Values between 268435455 and 4294967295
				write_natural_8 (0xF0)
				write_natural_32 (v)
			end
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
