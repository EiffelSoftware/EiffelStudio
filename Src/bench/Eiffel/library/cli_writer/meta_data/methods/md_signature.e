indexing
	description: "Representation of a signature"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_SIGNATURE

feature {NONE} -- Initialization

	make is
			-- Allocated `item'.
		local
			a: ARRAY [INTEGER_8]
		do
			create item.make (Default_size)
			create a.make (0, Default_size)
			internal_signature := a.area
			current_position := 0
			is_written := False
		ensure
			current_position_set: current_position = 0
			not_is_written: not is_written
		end
			
feature -- Access

	size: INTEGER is
			-- Size of structure once emitted.
		do
			Result := current_position
		end

	item: MANAGED_POINTER
			-- C structures that holds signature.

feature -- Status report

	is_written: BOOLEAN
			-- Is current signature written in `item'?
		
feature -- Saving

	update_item is
			-- Write to `item'.
		require
			not_is_written: not is_written
		local
			l_spe: like internal_signature
		do
			l_spe := internal_signature
			if item.size < current_position then
				item.resize (current_position.max (item.size + Default_size))
			end
			item.item.memory_copy ($l_spe, current_position)
			is_written := True
		ensure
			is_written: is_written
		end
		
feature {NONE} -- Implementation

	compress_data (i: INTEGER) is
			-- Compress `i' using Partition II 22.2 specification
			-- and store it at currrent_position in current.
		require
			valid_i: i <= 0x1FFFFFFF
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

	compress_type_token (i: INTEGER) is
			-- Compress token `i' using Partition II 22.2.8 specification
			-- and store it at current_position in current.
		local
			l_header: INTEGER
			l_val: INTEGER
			l_encoding: INTEGER
		do
			l_header := i & 0xFF000000
			l_val := i & 0x00FFFFFF

			if l_header = 0x01000000 then
					-- TypeRef token
				l_encoding := 1
			elseif l_header = 0x02000000 then
					-- TypeDef token
				l_encoding := 0
			elseif l_header = 0x1b000000 then
					-- TypeSpec token
				l_encoding := 2
			else
				check
					error: False
				end
			end

			l_val := (l_val |<< 2) | l_encoding

			compress_data (l_val)
		end

	internal_put (val: INTEGER_8; pos: INTEGER) is
			-- Safe insertion that will resize `internal_body' if needed.
		require
			valid_pos: pos >= 0
		local
			l_capacity: INTEGER
		do
			l_capacity := internal_signature.count
			if pos > l_capacity then
				internal_signature := internal_signature.resized_area (pos.max (l_capacity + Default_size))
			end
			internal_signature.put (val, pos)
		end

feature {NONE} -- Internal signature

	internal_signature: SPECIAL [INTEGER_8]
			-- Store current signature.

	current_position: INTEGER
			-- Current position in `internal_body' for next insertion.

	default_size: INTEGER is 20
			-- Default allocated size for a signature.

invariant
	item_not_void: item /= Void
	
end -- class MD_SIGNATURE
