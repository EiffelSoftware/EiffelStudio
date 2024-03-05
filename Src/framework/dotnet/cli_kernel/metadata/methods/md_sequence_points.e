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
			compress_data (a_value)
		end

	set_document_id (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		do
			compress_data (a_value)
		end

	put_il_offset (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value <= 0x20000000
		do
			compress_data (a_value)
		end

	put_start_line (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value <= 0x20000000
		do
			compress_data (a_value)
		end

	put_start_column (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value <= 0x10000
		do
			compress_data (a_value)
		end

	put_lines (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value >= 0
		do
			compress_data (a_value)
		end

	put_columns (a_value: INTEGER_32)
			-- Insert `a_value' into Current.
		require
			valid_value: a_value >= 0
		do
			compress_data (a_value)
		end


	put_document_record(a_value: INTEGER_32)
			--
		require
			valid_value: a_value <= 0x20000000
		do
			compress_data (0) -- IL offset
			compress_data (a_value)
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

	compress_data (i: INTEGER)
			-- Compress `i' using Partition II 22.2 specification
			-- and store it at currrent_position in current.
		require
			valid_i: i <= 0x20000000
		local
			l_pos, l_incr: INTEGER
			l_val: INTEGER
		do
			l_pos := current_position

			if i <= 0x7F then
					-- Simply copy first byte.
				internal_put (i.to_integer_8, l_pos)
				l_incr := 1;
			elseif i <= 0x3FFF then
					-- Copy two bytes added with 0x00008000.
				l_val := i + 0x00008000
				internal_put (((l_val & 0x0000FF00) |>> 8).to_integer_8, l_pos)
				internal_put ((l_val & 0x000000FF).to_integer_8, l_pos + 1)
				l_incr := 2
			else
					-- Copy four bytes added with 0xC0000000
				l_val := i + 0xC0000000
				internal_put (((l_val & 0xFF000000) |>> 24).to_integer_8, l_pos)
				internal_put (((l_val & 0x00FF0000) |>> 16).to_integer_8, l_pos + 1)
				internal_put (((l_val & 0x0000FF00) |>> 8).to_integer_8, l_pos + 2)
				internal_put ((l_val & 0x000000FF).to_integer_8, l_pos + 3)
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
