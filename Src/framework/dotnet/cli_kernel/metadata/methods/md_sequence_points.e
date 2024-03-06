note
	description: "Representation of a sequence points blob"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Sequence Points", "src=https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#sequence-points-blob", "target=uri"

class
	MD_SEQUENCE_POINTS

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make
			-- Allocated `item'.
		do
			create item.make (Default_size)
			current_position := 0
		end

feature -- Access

	count: INTEGER
			-- Size of structure once emitted.
		do
			Result := current_position
		end

	item: MANAGED_POINTER
			-- C structures that holds signature.

feature -- Reset

	reset
			-- Reset current for new signature definition
		do
			current_position := 0
		ensure
			current_position_set: current_position = 0
		end

feature -- Setting		

	set_local_signature (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		do
			compress_unsigned_data (a_value)
		end

	set_document_id (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		do
			compress_unsigned_data (a_value)
		end

	put_il_offset (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value <= 0x20000000
		do
			compress_unsigned_data (a_value)
		end

	put_start_line (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value <= 0x20000000
		do
			compress_unsigned_data (a_value)
		end

	put_start_column (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value <= 0x10000
		do
			compress_unsigned_data (a_value)
		end

	put_lines (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value >= 0
		do
			compress_unsigned_data (a_value)
		end

	put_columns (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value >= 0
		do
			compress_unsigned_data (a_value)
		end


	put_document_record(a_value: INTEGER_32)
			--
		require
			valid_value: a_value <= 0x20000000
		do
			compress_unsigned_data (0) -- IL offset
			compress_unsigned_data (a_value)
		end

	put_signed (a_value: INTEGER_32)
		do
			compress_signed_data (a_value)
		end

	put_unsigned_value (a_value: INTEGER_32)
		do
			compress_unsigned_data (a_value)
		end

feature -- Copy

	as_special: SPECIAL [NATURAL_8]
			-- Copy of Current as SPECIAL.
		local
			i, nb: INTEGER
		do
			from
				i := 0
				nb := current_position
				create Result.make_filled (0, nb)
			until
				i = nb
			loop
				Result.put (item.read_natural_8 (i), i)
				i := i + 1
			end
		ensure
			as_special_not_void: Result /= Void
			same_count: Result.count = current_position
		end

	as_array: ARRAY [NATURAL_8]
			-- Copy of Current as ARRAY
		do
			create Result.make_from_special (as_special)
		end

feature -- Status report

	debug_output: STRING
		local
			n: INTEGER
			n8: NATURAL_8
		do
			n := count * 2
			create Result.make (n)
			across
				as_array as ic
			loop
				n8 := ic.item
				Result.append_string (n8.to_hex_string)
				Result.append_character('-')
			end
			Result.remove_tail (1)
		end

feature {NONE} -- Implementation

	compress_unsigned_data (i: INTEGER)
			-- Compress `i' using Partition II 22.2 specification
			-- and store it at currrent_position in current.
		require
			valid_i: i <= 0x20000000
		local
			l_pos, l_incr: INTEGER
			l_val: INTEGER
			n16: NATURAL_16
			n32: NATURAL_32
		do
			l_pos := current_position

			if i <= 0x7F then
					-- Simply copy first byte.
				internal_put (i.to_integer_8, l_pos)
				l_incr := 1;
			elseif i <= 0x3FFF then
					-- Copy two bytes added with 0x00008000.
				n16 := i.to_natural_16 + 0x00008000
				internal_put (((n16 & 0x0000FF00) |>> 8).to_integer_8, l_pos)
				internal_put ((n16 & 0x000000FF).to_integer_8, l_pos + 1)
				l_incr := 2
			else
					-- Copy four bytes added with 0xC0000000
				n32 := i.to_natural_32 + 0xC0000000
				internal_put (((n32 & 0xFF000000) |>> 24).to_integer_8, l_pos)
				internal_put (((n32 & 0x00FF0000) |>> 16).to_integer_8, l_pos + 1)
				internal_put (((n32 & 0x0000FF00) |>> 8).to_integer_8, l_pos + 2)
				internal_put ((n32 & 0x000000FF).to_integer_8, l_pos + 3)
				l_incr := 4
			end
			current_position := l_pos + l_incr
		end

	compress_signed_data (i: INTEGER)
			-- Compress `i' using using Partition II 22.2 specification for
			-- signed integers and store it at currrent_position in current.
		note
			eis: "name=Signed Ingegers", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=237&zoom=100,116,848", "protocol=uri"
		require
			valid_i:  i >= -0x10000000 and i <= 0x0FFFFFFF
				--checks if the input integer i lies between -2^28 and 2^28 - 1 inclusive
		local
			l_pos, l_incr: INTEGER
			n8: NATURAL_8
			n16: NATURAL_16
			n32: NATURAL_32
		do
			l_pos := current_position

				-- 2^6 and 2^6 -1 inclusive	
			if -0x40 <= i and i <= 0x3F then
					-- Two complement
				n8 := i.to_natural_8
					-- rotate the value 1 bit lef
				n8 := (n8 |<< 1 + (n8 & 0b1000_0000) |>> 7) & 0b0111_1111
					 -- Encode as a one-byte integer: bit 7 clear, rotated value in bits 6 through 0
				n8 := n8 & 0x7F

				internal_put (n8.to_integer_8, l_pos)
				l_incr := 1
				-- 2^13 and 2^13 -1 inclusive
			elseif -0x2000 <= i and i <= 0x1FFF then
				n16 := i.to_natural_16
					-- Represent the value as a 14-bit 2’s complement number, giving 0x2000 (-213) to 0x1FFF (213-1)
				n16 := n16 & 0b0011_1111_1111_1111
					-- Rotate this value 1 bit left, giving 0x0001 (-213) to 0x3FFE (213-1);
				n16 := (n16 |<< 1 + (n16 & 0b0010_0000_0000_0000) |>> 13) & 0b0011_1111_1111_1111

					-- Encode as a two-byte integer: bit 15 set, bit 14 clear, rotated value
					-- in bits 13 through 0, giving 0x8001 (-213) to 0xBFFE (213-1).
				n16 := (n16 + 0b1000_0000_0000_0000) & 0b1011_1111_1111_1111

				internal_put (((n16 & 0b1111_1111_0000_0000) |>> 8).to_integer_8, l_pos)
				internal_put ( (n16 & 0b0000_0000_1111_1111).to_integer_8, l_pos + 1)
				l_incr := 2
			else
				n32 := i.to_natural_32
					-- Represent the value as a 29-bit 2’s complement representation,
					-- giving 0x10000000 (-228) to 0xFFFFFFF (228-1);
				n32 := n32 & 0b0011_1111_1111_1111_1111_1111_1111_1111

					-- Rotate this value 1-bit left, giving 0x00000001 (-228) to 0x1FFFFFFE (228-1)
				n32 := (n32 |<< 1 + (n32 & 0b0010_0000_0000_0000_0000_0000_0000_0000) |>> 29) & 0b0011_1111_1111_1111_1111_1111_1111_1111

					-- Encode as a four-byte integer: bit 31 set, bit 30 set, bit 29 clear,
					-- rotated value in bits 28 through 0
				n32 := (n32 + 0b1100_0000_0000_0000_0000_0000_0000_0000) & 0b1101_1111_1111_1111_1111_1111_1111_1111


				internal_put (((n32 & 0xFF000000) |>> 24).to_integer_8, l_pos)
				internal_put (((n32 & 0x00FF0000) |>> 16).to_integer_8, l_pos + 1)
				internal_put (((n32 & 0x0000FF00) |>> 8).to_integer_8, l_pos + 2)
				internal_put ( (n32 & 0x000000FF).to_integer_8, l_pos + 3)
				l_incr := 4
			end
			current_position := l_pos + l_incr
		end

	internal_put (val: INTEGER_8; pos: INTEGER)
			-- Safe insertion that will resize `internal_body' if needed.
		require
			valid_pos: pos >= 0
		do
			allocate (pos + 1)
			item.put_integer_8_le (val, pos)
		end

feature {NONE} -- Internal signature

	current_position: INTEGER
			-- Current position in `internal_body' for next insertion.

	default_size: INTEGER = 20
			-- Default allocated size for a signature.

feature {NONE} -- Stack depth management

	allocate (new_size: INTEGER)
			-- Resize `item' if needed so that it can accomdate `new_size'.
		local
			l_capacity: INTEGER
		do
			l_capacity := item.count
			if new_size > l_capacity then
				item.resize (new_size.max (l_capacity + Default_size))
			end
		ensure
			enough_size: item.count >= new_size
		end

invariant
	item_not_void: item /= Void
end
