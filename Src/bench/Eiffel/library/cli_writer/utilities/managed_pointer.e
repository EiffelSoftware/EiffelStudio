indexing
	description: "To easily manage allocation and release of allocated C memory"
	date: "$Date$"
	revision: "$Revision$"

class
	MANAGED_POINTER

inherit
	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end
		
	ANY
	
create
	make, make_from_array
	
feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Allocate `item' with `n' bytes.
		require
			valid_n: n > 0
		do
			item := item.memory_alloc (n)
			item.memory_set (0, n)
			size := n
		ensure
			item_set: item /= default_pointer
			size_set: size = n
		end

	make_from_array (data: ARRAY [INTEGER_8]) is
			-- Allocate `item' with `data.count' bytes and copy
			-- content of `data' into `item'.
		require
			data_not_void: data /= Void
		local
			l_sp: SPECIAL [INTEGER_8]
		do
			size := data.count
			item := item.memory_alloc (size)
			l_sp := data.area
			item.memory_copy ($l_sp, size)
		ensure
			item_set: item /= default_pointer
			size_set: size = data.count
		end
		
feature -- Access

	item: POINTER
			-- Access to allocated memory.
			
	size: INTEGER
			-- Allocated size area.

feature -- Update

	put_integer_8 (i: INTEGER_8; pos: INTEGER) is
			-- Insert `i' at position `pos'.
		require
			valid_pos: (pos + 1) < size
		do
			(item + pos).memory_copy ($i, 1)
		end

	put_integer_16 (i: INTEGER_16; pos: INTEGER) is
			-- Insert `i' at position `pos'.
		require
			valid_pos: (pos + 2) < size
		do
			(item + pos).memory_copy ($i, 2)
		end

	put_integer_32 (i: INTEGER; pos: INTEGER) is
			-- Insert `i' at position `pos'.
		require
			valid_pos: (pos + 4) < size
		do
			(item + pos).memory_copy ($i, 4)
		end

	put_integer_64 (i: INTEGER_64; pos: INTEGER) is
			-- Insert `i' at position `pos'.
		require
			valid_pos: (pos + 8) < size
		do
			(item + pos).memory_copy ($i, 8)
		end
		
feature -- Resizing

	resize (n: INTEGER) is
			-- Reallocate `item' to hold `n' bytes.
		require
			bigger_size: n > size
		do
				-- Reallocate.
			item := item.memory_realloc (n)
			
				-- Reset newly allocated memory to `0'.
			(item + size).memory_set (0, n - size)
			size := n
		end
		
feature {NONE} -- Disposal

	dispose is
			-- Release memory pointed by `item'.
		do
			item.memory_free
			item := default_pointer
		ensure
			item_reset: item = default_pointer
		end

invariant
	item_not_null: item /= default_pointer
	valid_size: size >= 0
	
end -- class MANAGED_POINTER
