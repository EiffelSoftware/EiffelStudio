note
	description:

		"Abstract base for C arrays wrappers. Array is fixed size, zero based."

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WRAPC_ARRAY

inherit

	MANAGED_POINTER
		rename
			item as array_address,
			count as capacity
		export {NONE} all
		end


feature {NONE} -- Initialisation

	make_new_unshared (a_count: INTEGER)
			-- Create new C array wrapper with `a_count' items
			-- each `item_size' bytes big.
			-- Allocates as much new memory as the array needs.
			-- 'unshared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the array will
			-- be freed as well.
		require
			a_count_greater_zero: a_count > 0
		do
			count := a_count
			make (item_size * count)
			make_internal
		ensure
			count_set: count = a_count
			item_not_default_pointer: array_address /= default_pointer
			is_not_shared: not is_shared
		end

	make_new_shared (a_count: INTEGER)
			-- Create new C array wrapper with `a_count' items
			-- each `item_size' bytes big.
			-- Allocates as much new memory as the array needs.
			-- 'shared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the array will
			-- not be freed as well.
		require
			a_count_greater_zero: a_count > 0
		do
			count := a_count
			make (item_size * count)
			is_shared := True
			make_internal
		ensure
			count_set: count = a_count
			item_not_default_pointer: array_address /= default_pointer
			is_shared: is_shared
		end

	make_unshared (a_item: POINTER; a_count: INTEGER)
			-- Create a new array wrapper to a given C array starting at `a_item'
			-- with `a_count' items each item `item_size' big.
			-- 'unshared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the array will
			-- be freed as well.
		require
			a_count_greater_zero: a_count > 0
		do
			count := a_count
			make_from_pointer (a_item, item_size * count)
			make_internal
		ensure
			count_set: count = a_count
			item_not_default_pointer: array_address /= default_pointer
			is_not_shared: not is_shared
		end

	make_shared (a_item: POINTER; a_count: INTEGER)
			-- Create a new array wrapper to a given C array starting at `a_item'
			-- with `a_count' items each item `item_size' big.
			-- 'shared' means if the Current object
			-- gets collected by the garbage collector,
			-- the memory allocated for the struct will
			-- not be freed as well.
		require
			a_count_greater_zero: a_count > 0
		do
			count := a_count
			share_from_pointer (a_item, item_size * count)
			make_internal
		ensure
			count_set: count = a_count
			item_not_default_pointer: array_address /= default_pointer
			is_shared: is_shared
		end

	make_internal
		do
		end

feature -- Access

	count: INTEGER
			-- Number of elements in the current array.

	exists: BOOLEAN
			-- Does `array_address' point to a valid C array ?
		do
			Result := array_address /= default_pointer
		end

	is_valid_index (i: INTEGER): BOOLEAN
			-- Is `i' a valid index for this array ?
		do
			Result := i >= 0 and i < count
		end


	item_size: INTEGER
			-- Size of one array item in bytes
			-- Define in concrete array wrapper
		deferred
		ensure
			item_size_greater_zero: Result >= 0
		end

invariant

	managed_capacity_equals_size_of_array: capacity = count * item_size

	count_greater_zero: count > 0

end
