indexing
	description: "Stream of data stored in non Eiffel memory"
	date: "$Date$"
	revision: "$Revision$"

class
	MEMORY_STREAM

inherit
	MEMORY
		redefine
			dispose, copy, is_equal
		end
		
create
	make,
	make_from_pointer
	
feature {NONE} -- Initialization

	make (a_size: INTEGER) is
			-- Initialize current with `a_size' bytes.
		require
			valid_size: a_size >= 0
		do
			area := area.memory_alloc (a_size)
			count := a_size
			capacity := a_size
			is_resizable := True
		ensure
			capacity_set: capacity = a_size
			count_set: count = a_size
			is_resizable_set: is_resizable
		end
	
	make_from_pointer (an_area: POINTER; a_size: INTEGER) is
			-- Initialize Current with `an_area' and `a_size'.
			-- Current will not be resizable as we do not know
			-- who created `an_area'.
		require
			an_area_not_null: an_area /= default_pointer
			valid_size: a_size >= 0
		do
			area := an_area
			capacity := a_size
			count := a_size
			is_resizable := False
		ensure
			capacity_set: capacity = a_size
			count_set: count = a_size
			is_resizable_set: not is_resizable
		end

feature -- Access

	count: INTEGER
			-- Number of bytes used in Current.

	capacity: INTEGER
			-- Number of bytes in Current.

	area: POINTER
			-- Memory area that holds data.

	item, infix "@" (i: INTEGER): INTEGER_8 is
			-- Entry at index `i'.
		require
			valid_index: valid_index (i)			
		do
			($Result).memory_copy (area + i, 1)
		end
		
feature -- Status report

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within the bounds of Current?
		do
			Result := (0 <= i) and then (i < capacity)
		end
	
	is_resizable: BOOLEAN
			-- Can Current be resized?

feature -- Setting

	set_count (n: INTEGER) is
		require
			valid_index: valid_index (n - 1)
		do
			count := n
		ensure
			count_set: count = n
		end

feature -- Element change

	put (v: INTEGER_8; i: INTEGER) is
			-- Replace `i'-th entry by `v'.
		require
			valid_index: valid_index (i)
		local
			l_offset: POINTER
		do
			l_offset := area + i
			l_offset.memory_copy ($v, 1)
		ensure
			inserted: item (i) = v
		end

	force (v: INTEGER_8; i: INTEGER) is
			-- Replace `i'-th entry by `v'.
			-- If `i' is out of bound, reallocate Current.
		local
			l_offset: POINTER
		do
			if not valid_index (i) then
				area := area.memory_realloc (i + 1)
				capacity := i + 1
			end
			l_offset := area + i
			l_offset.memory_copy ($v, 1)
		ensure
			inserted: item (i) = v
		end

	append (other: like Current) is
			-- Append `other' at the end of Current.
		require
			other_not_void: other /= Void
			resizable: is_resizable
		local
			new_count: INTEGER
			l_offset: POINTER
		do
			new_count := count + other.count
			if new_count > capacity then
				area := area.memory_realloc (new_count)
				capacity := new_count
			end
			l_offset := area + count
			l_offset.memory_copy (other.area, other.count)
			count := new_count
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := count = other.count and then area.memory_compare (other.area, count)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Copy other in Current
		do
			area.memory_free
			make (other.count)
			area.memory_copy (other.area, other.count)
		end

feature {NONE} -- Disposal

	dispose is
			-- Release `area'.
		do
			area.memory_free
		end
		
invariant
	area_not_null: area /= default_pointer

end -- class MEMORY_STREAM
