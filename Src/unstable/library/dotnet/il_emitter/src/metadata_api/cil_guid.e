note
	description: "Abstraction of a GUID data structure."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_GUID

inherit
	ANY
		redefine
			is_equal, copy
		end

create
	make,
	make_empty,
	share_from_pointer

feature {NONE} -- Initialization

	make (data1: NATURAL_32; data2, data3: NATURAL_16; data4: ARRAY [NATURAL_8])
			-- Create Current using provided above information.
		require
			data4_not_void: data4 /= Void
			data4_valid_count: data4.count = data_4_count
		do
			create internal_item.make (size)
			internal_item.put_natural_32 (data1, data_1_pos)
			internal_item.put_natural_16 (data2, data_2_pos)
			internal_item.put_natural_16 (data3, data_3_pos)
			internal_item.put_array (data4, data_4_pos)
		end

	make_empty
			-- Create a GUID with null data.
		do
			make (0, 0, 0, {ARRAY [NATURAL_8]} << 0,0,0,0,0,0,0,0 >>)
		end

	share_from_pointer (a_pointer: POINTER)
			-- Creation method
		do
			create internal_item.share_from_pointer (a_pointer, size)
		end

feature -- Element change

	set_data_1 (a_value: NATURAL_32)
			-- Set `data_1' with `a_value'.
		do
			internal_item.put_natural_32 (a_value, data_1_pos)
		ensure
			data_1_set: data_1 = a_value
		end

	set_data_2 (a_value: NATURAL_16)
			-- Set `data_2' with `a_value'.
		do
			internal_item.put_natural_16 (a_value, data_2_pos)
		ensure
			data_2_set: data_2 = a_value
		end

	set_data_3 (a_value: NATURAL_16)
			-- Set `data_3' with `a_value'.
		do
			internal_item.put_natural_16 (a_value, data_3_pos)
		ensure
			data_3_set: data_3 = a_value
		end

	set_data_4 (a_values: ARRAY [NATURAL_8]; a_index: INTEGER)
			-- Set `data_4' array item at `a_index''s value with `a_value'.
		require
			a_value_not_void: a_values /= Void
			a_values_valid_count: a_values.count = data_4_count
		do
			internal_item.put_array (a_values, data_4_pos)
		ensure
			data_4_set: data_4.is_equal (a_values)
		end

feature -- Access

	data_1: NATURAL_32
			-- Data 1
		do
			Result := internal_item.read_natural_32 (data_1_pos)
		end

	data_2: NATURAL_16
			-- Data 2
		do
			Result := internal_item.read_natural_16 (data_2_pos)
		end

	data_3: NATURAL_16
			-- Data 3
		do
			Result := internal_item.read_natural_16 (data_3_pos)
		end

	data_4: ARRAY [NATURAL_8]
			-- Data 4
		do
			Result := internal_item.read_array (data_4_pos, data_4_count)
		ensure
			not_void: Result /= Void
			count_right: Result.count = data_4_count
		end

	data_4_count: INTEGER = 8
			-- Number of elements in `data_4'.

	item: POINTER
			-- Pointer
		do
			Result := internal_item.item
		end

	size: INTEGER = 16
			-- Size of structure.

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Redefine
		do
			Result := internal_item.is_equal (other.internal_item)
		end

feature -- Duplication

	copy (other: like Current)
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
		do
			if other /= Current then
				internal_item := other.internal_item.twin
			end
		end

feature {CIL_GUID} -- Access

	internal_item: MANAGED_POINTER
			-- To hold data of Current.

	data_1_pos: INTEGER = 0
	data_2_pos: INTEGER = 4
	data_3_pos: INTEGER = 6
	data_4_pos: INTEGER = 8
			-- Starting position of `data_1', `data_2', `data_3' and `data_4' in `internal_item'.

invariant
	internal_item_not_void: internal_item /= Void

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
