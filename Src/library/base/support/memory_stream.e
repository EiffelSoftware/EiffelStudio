indexing
	description: "Stream of data stored in non Eiffel memory"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MEMORY_STREAM

inherit
	DISPOSABLE
		redefine
			copy, is_equal
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
			create internal_area.make (a_size)
			is_resizable := True
		ensure
			non_void_area: area /= default_pointer
			capacity_set: capacity = a_size
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
			create internal_area.make (a_size)
			is_resizable := False
		ensure
			non_void_area: area /= default_pointer
			capacity_set: capacity = a_size
			is_resizable_set: not is_resizable
		end

feature -- Access

	count: INTEGER is
			-- Number of bytes in Current.
		do
			Result := internal_area.count
		end

	capacity: INTEGER is
			-- Number of bytes in Current.
		do
			Result := internal_area.count
		end

	area: POINTER is
			-- Memory area that holds data.
		do
			Result := internal_area.item
		ensure
			non_void_area: Result /= default_pointer
		end

	item alias "[]", infix "@" (i: INTEGER): INTEGER_8 assign put is
			-- Entry at index `i'.
		require
			valid_index: valid_index (i)			
		do
			($Result).memory_copy (area.item + i, 1)
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

	set_count, set_capacity (n: INTEGER) is
		require
			valid_index: valid_index (n - 1)
		do
			internal_area.resize (n)
		ensure
			capacity_set: capacity = n
		end

feature -- Element change

	put (v: INTEGER_8; i: INTEGER) is
			-- Replace `i'-th entry by `v'.
		require
			valid_index: valid_index (i)
		do
			internal_area.put_integer_8 (v, i)
		ensure
			inserted: item (i) = v
		end

	force (v: INTEGER_8; i: INTEGER) is
			-- Replace `i'-th entry by `v'.
			-- If `i' is out of bound, reallocate Current.
		require
			positive_index: i > 0
		do
			if not valid_index (i) then
				internal_area.resize (i + 1)
			end
			internal_area.put_integer_8 (v, i)
		ensure
			inserted: item (i) = v
		end

	append (other: like Current) is
			-- Append `other' at the end of Current.
		require
			other_not_void: other /= Void
			resizable: is_resizable
		local
			l_mp: MANAGED_POINTER
		do
			create l_mp.make_from_pointer (other.area, other.capacity)
			internal_area.resize (capacity + other.capacity)
			internal_area.append (l_mp)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := capacity = other.capacity and then area.memory_compare (other.area, capacity)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Copy other in Current
		do
			area.memory_free
			make (other.capacity)
			area.memory_copy (other.area, other.capacity)
		end

feature {NONE} -- Disposal

	dispose is
			-- Release `area'.
		do
			area.item.memory_free
		end

	internal_area: MANAGED_POINTER
	
invariant
	non_void_internal_area: internal_area /= Void
	area_not_null: area /= default_pointer

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






end -- class MEMORY_STREAM
