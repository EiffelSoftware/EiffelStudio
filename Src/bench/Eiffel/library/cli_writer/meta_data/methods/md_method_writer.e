indexing
	description: "Factory that create a memory stream holding IL instruction stream."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_METHOD_WRITER

inherit
	CLI_UTILITIES
		export
			{NONE} all
		end
		
	ANY
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Create Factory to store method bodys into `item'.
		do
			create method_locations.make (10)
			create internal_item.make (Chunk_size)
			current_position := 0
			capacity := Chunk_size
			is_previous_body_written := True
			is_closed := False
		end
		
feature -- Access

	item: POINTER is
			-- Memory area containing IL code
		do
			Result := internal_item.item
		ensure
			result_not_null: Result /= default_pointer
		end

	size: INTEGER is
			-- Size of code
		do
			Result := current_position
		end
		
feature -- Method body definition

	new_method_body (token: INTEGER): MD_METHOD_BODY is
			-- Get a new body for method token `token'.
		require
			not_closed: not is_closed
			last_one_has_been_emitted: is_previous_body_written
		do
			Result := internal_method_body
			if Result = Void then
				create Result.make (token)
				internal_method_body := Result
			else
				Result.remake (token)
			end
			is_previous_body_written := False
		ensure
			result_not_void: Result /= Void
		end

feature -- Status Report

	is_previous_body_written: BOOLEAN
			-- Has last body generated through Current been emitted?
	
	is_closed: BOOLEAN
			-- Can Current object be used for further method body definition?
			-- If `True' no, otherwise yes.

feature -- Update

	update_rvas (md_emit: MD_EMIT; top_rva: INTEGER) is
			-- Now that all bodys have been emitted, update each
			-- method token with its corresponding rva knowing
			-- that current memory stream starts at `top_rva'.
		require
			not_is_closed: not is_closed
		do
			is_closed := True
			from
				method_locations.start
			until
				method_locations.after
			loop
				method_locations.forth
			end
		ensure
			is_closed: is_closed
		end

feature -- Settings

	write_current_body is
			-- Store `current body' in `Current'.
		require
			not_closed: not is_closed
			not_yet_emitted: not is_previous_body_written
		local
			l_pos: INTEGER
			l_meth_size: INTEGER
			l_meth: like internal_method_body
		do
			l_meth := internal_method_body
			l_pos := current_position
			l_meth_size := l_meth.size
			method_locations.put (l_pos, l_meth.method_token)

			if (l_pos + l_meth_size + feature {MD_FAT_METHOD_HEADER}.Size) > capacity then
					-- Resize `internal_item'.
				internal_item.resize ((l_pos + l_meth_size + feature {MD_FAT_METHOD_HEADER}.Size)
					.max (capacity + Chunk_size))
			end
			
			if
				not l_meth.has_locals and then not l_meth.has_exceptions_handling
				and then l_meth.max_stack <= 8
			then
					-- Valid candidate for tiny header.
				Tiny_method_header.set_code_size (l_meth_size.to_integer_8)
				Tiny_method_header.write_to_stream (internal_item, l_pos)
				l_pos := l_pos + Tiny_method_header.size
			else
					-- Valid candidate for fat header.
				Fat_method_header.remake (l_meth.max_stack.to_integer_16,
					l_meth_size, l_meth.local_token)
				Fat_method_header.write_to_stream (internal_item, l_pos)
				l_pos := l_pos + Fat_method_header.size
			end
			
			l_meth.write_to_stream (internal_item, l_pos)
			l_pos := l_pos + l_meth_size
			
				-- Find next location that must be 4 bytes aligned.
			current_position := pad_up (l_pos, 4)
			is_previous_body_written := True
		end

feature {NONE} -- Implementation

	current_position: INTEGER
			-- Current position for next write.
			
	capacity: INTEGER
			-- Number of `bytes' that `internal_item' can hold.

	method_locations: HASH_TABLE [INTEGER, INTEGER]
			-- Correspondances between method token and location in `internal_item'
			-- so that we can easily update the method token RVA
			-- when storing onto PE file in CLI_PE_FILE.
			-- Key: token
			-- Value: location

	internal_method_body: MD_METHOD_BODY
			-- Body used over and over to avoid memory consumption.

	internal_item: MANAGED_POINTER
			-- Memory where IL data instruction stream is stored.

feature {NONE} -- constants

	Chunk_size: INTEGER is 1000000
			-- Default chunk size is 1MB.

	tiny_method_header: MD_TINY_METHOD_HEADER is
			-- To avoid over creating method headers.
		once
			create Result.make (0)
		end
		
	fat_method_header: MD_FAT_METHOD_HEADER is
			-- To avoid over creating method headers.
		once
			create Result.make (0, 0, 0)
		end

invariant
	good_capacity: capacity > 0 and current_position <= capacity
	method_locations_not_void: method_locations /= Void
	
end -- class MD_METHOD_WRITER
