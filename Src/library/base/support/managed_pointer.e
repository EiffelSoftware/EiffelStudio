indexing
	description: "[
		To easily manage allocation and release of allocated C memory, and
		to perform insertion of basic elements. Byte order is by default
		the one from the current hardware.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	MANAGED_POINTER

inherit
	MEMORY
		export
			{NONE} all
		redefine
			dispose, is_equal, copy
		end
		
	ANY
		redefine
			is_equal, copy
		end
	
create
	make, make_from_array, make_from_pointer
	
feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Allocate `item' with `n' bytes.
		require
			n_positive: n > 0
		do
			item := item.memory_alloc (n)
			item.memory_set (0, n)
			count := n
		ensure
			item_set: item /= default_pointer
			count_set: count = n
		end

	make_from_array (data: ARRAY [INTEGER_8]) is
			-- Allocate `item' with `data.count' bytes and copy
			-- content of `data' into `item'.
		require
			data_not_void: data /= Void
		do
			count := data.count
			item := item.memory_alloc (count)
			put_array (data, 0)
		ensure
			item_set: item /= default_pointer
			count_set: count = data.count
		end

	make_from_pointer (a_ptr: POINTER; n: INTEGER) is
			-- Copy `a_count' bytes from `a_ptr' into current.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			n_positive: n > 0
		do
			item := item.memory_alloc (n)
			item.memory_copy (a_ptr, n)
			count := n
		ensure
			item_set: item /= default_pointer
			count_set: count = n
		end
		
feature -- Access

	item: POINTER
			-- Access to allocated memory.
			
	count: INTEGER
			-- Number of elements that Current can hold.

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered equal to current object?
		do
			Result := count = other.count and then item.memory_compare (other.item, count)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		do
			resize (other.count)
			item.memory_copy (other.item, other.count)
		end
		
feature -- Format independant

	read_integer_8 (pos: INTEGER): INTEGER_8 is
			-- Read INTEGER_8 at position `pos'.
		require
			valid_position: (pos + 1) <= count
		do
			($Result).memory_copy (item + pos, 1)
		end

	put_integer_8 (i: INTEGER_8; pos: INTEGER) is
			-- Insert `i' at position `pos'.
		require
			valid_position: (pos + 1) <= count
		do
			(item + pos).memory_copy ($i, 1)
		end

	put_array (data: ARRAY [INTEGER_8]; pos: INTEGER) is
			-- Copy content of `data' into `item' at position `pos'.
		require
			valid_position: (pos + data.count) <= count
		local
			l_sp: SPECIAL [INTEGER_8]
		do
			l_sp := data.area;
			(item + pos).memory_copy ($l_sp, data.count)
		end

feature -- Platform specific, here x86

	put_real (r: REAL; pos: INTEGER) is
			-- Insert `r' at position `pos'.
		require
			valid_position: (pos + 4) <= count
		do
			(item + pos).memory_copy ($r, 4)
		end

	put_double (d: DOUBLE; pos: INTEGER) is
			-- Insert `d' at position `pos'.
		require
			valid_position: (pos + 8) <= count
		do
			(item + pos).memory_copy ($d, 8)
		end
		
feature -- Update in little-endian format

	put_integer_16 (i: INTEGER_16; pos: INTEGER) is
			-- Insert `i' at position `pos'.
		require
			valid_position: (pos + 2) <= count
		do
			(item + pos).memory_copy ($i, 2)
		end

	put_integer_32 (i: INTEGER; pos: INTEGER) is
			-- Insert `i' at position `pos'.
		require
			valid_position: (pos + 4) <= count
		do
			(item + pos).memory_copy ($i, 4)
		end

	put_integer_64 (i: INTEGER_64; pos: INTEGER) is
			-- Insert `i' at position `pos'.
		require
			valid_position: (pos + 8) <= count
		do
			(item + pos).memory_copy ($i, 8)
		end
		
feature -- Update in big-endian format

	put_integer_16_be (i: INTEGER_16; pos: INTEGER) is
			-- Insert `i' at position `pos'.
		require
			valid_position: (pos + 2) <= count
		do
			put_integer_8 (((i & 0xFF00) |>> 8).to_integer_8, pos)
			put_integer_8 (((i & 0x00FF) |>> 8).to_integer_8, pos + 1)
		end

	put_integer_32_be (i: INTEGER; pos: INTEGER) is
			-- Insert `i' at position `pos'.
		require
			valid_position: (pos + 4) <= count
		do
			put_integer_16_be (((i & 0xFFFF0000) |>> 16).to_integer_16, pos)
			put_integer_16_be (((i & 0x0000FFFF) |>> 16).to_integer_16, pos + 2)
		end

	put_integer_64_be (i: INTEGER_64; pos: INTEGER) is
			-- Insert `i' at position `pos'.
		require
			valid_position: (pos + 8) <= count
		do
			put_integer_32_be (((i & 0xFFFFFFFF00000000) |>> 32).to_integer_32, pos)
			put_integer_32_be (((i & 0x00000000FFFFFFFF) |>> 32).to_integer_32, pos + 4)		
		end

feature -- Concatenation

	append (other: like Current) is
			-- Append `other' at the end of Current.
		require
			other_not_void: other /= Void
		local
			new_count: INTEGER
		do
			new_count := count + other.count
			item := item.memory_realloc (new_count)
			(item + count).memory_copy (other.item, other.count)
			count := new_count
		end

feature -- Resizing

	resize (n: INTEGER) is
			-- Reallocate `item' to hold `n' bytes.
			-- If `n' smaller than `count', does nothing.
		do
			if n > count then
					-- Reallocate.
				item := item.memory_realloc (n)
				
					-- Reset newly allocated memory to `0'.
				(item + count).memory_set (0, n - count)
				count := n
			end
		end

feature {NONE} -- Disposal

	dispose is
			-- Release memory pointed by `item'.
		local
			null: POINTER
		do
			item.memory_free
			item := null
		ensure
			item_reset: item = default_pointer
		end

invariant
	item_not_null: item /= default_pointer
	valid_count: count >= 0
	
end -- class MANAGED_POINTER
