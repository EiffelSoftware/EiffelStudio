
indexing
	
	author: "David Hollenberg";
	date:	"November 22, 1995"
	description: "Facilities for allocating C memory, which is not %
		%subject to garbage collection by the Eiffel garbage %
		%collector"

class PROCESS_C_MEMORY_ALLOCATION

feature -- Memory allocation

	allocate_nongc_memory (size_in_bytes: INTEGER): POINTER is
			-- Allocate `size_in_bytes' bytes of memory which
			-- is not subject to garbage collection and
			-- return a pointer to it.  Raise an exception
			-- if no memory is available.
		require
			positive_size: size_in_bytes > 0
		external
			"C"
		end;
			
	copy_nongc_memory (source, dest: POINTER; size_in_bytes: INTEGER) is
			-- Copy `size_in_bytes' bytes of memory which
			-- is not subject to garbage collection from
			-- `source' to `dest'
		require
			nonnegative_size: size_in_bytes >= 0;
		external
			"C [macro %"mem_alloc.h%"]"
		end;
			
	set_nongc_memory (dest: POINTER; c: CHARACTER size: INTEGER) is
			-- Set `size' bytes of memory starting at
			-- `dest' to `c'
		require
			nonnegative_size: size >= 0;
		external
			"C | <string.h>"
		alias
			"memset"
		end;
			
	free_nongc_memory (memptr: POINTER) is
			-- Free previously allocated memory pointed to
			-- by `memptr'.
		external
			"C"
		end;
			
	offset (addr: POINTER; incr: INTEGER): POINTER is
			-- New address which is `addr' plus `incr'
		external
			"C [macro %"mem_alloc.h%"]"
		end;

	to_pointer (p: POINTER): POINTER is
			-- Return pointer `p'
		do
			Result := p;
		end;
			
	pointer_size: INTEGER is
			-- Size of pointer in bytes
		external
			"C [macro %"mem_alloc.h%"]"
		end;
			
	store_pointer (p: POINTER addr: POINTER n: INTEGER) is
			-- Store `p' into `n'th pointer slot (relative to 0)
			-- of memory pointed to by `addr'
		require
			nonnegative_offset: n >= 0
		external
			"C [macro %"mem_alloc.h%"]"
		end;
			
	nth_pointer (addr: POINTER n: INTEGER): POINTER is
			-- Value in `n'th pointer slot (relative to 0)
			-- of memory pointed to by `addr'
		require
			nonnegative_offset: n >= 0
		external
			"C [macro %"mem_alloc.h%"]"
		end;
			
end -- class PROCESS_C_MEMORY_ALLOCATION
