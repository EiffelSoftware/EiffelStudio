indexing
	description: "GUID struct used by GDI+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GUID

inherit
	ANY
		redefine
			is_equal
		end

create
	make,
	share_from_pointer

feature {NONE} -- Initlization

	make is
			-- Creation method.
		do
			create internal_item.make (structure_size)
		end

	share_from_pointer (a_pointer: POINTER) is
			-- Creation method
		do
			create internal_item.share_from_pointer (a_pointer, structure_size)
		end

	make_from_string (a_string: STRING) is
			-- Creation method
		do
			-- We need a simple parser for this creation method.
			check not_implemented: False end
		end

feature -- Command

	set_data_1 (a_value: NATURAL_64) is
			-- Set `data_1' with `a_value'.
		do
			c_set_data_1 (item, a_value)
		end

	set_data_2 (a_value: NATURAL_16) is
			-- Set `data_2' with `a_value'.
		do
			c_set_data_2 (item, a_value)
		end

	set_data_3 (a_value: NATURAL_16) is
			-- Set `data_3' with `a_value'.
		do
			c_set_data_3 (item, a_value)
		end

	set_data_4 (a_value: NATURAL_8; a_index: INTEGER) is
			-- Set `data_4' array item at `a_index''s value with `a_value'.
		do
			c_set_data_4 (item, a_index, a_value)
		end

feature -- Query

	structure_size: INTEGER is
			-- Size of Current structure.
		do
			Result := c_size_of_guid
		end

	data_1: NATURAL_64 is
			-- Data 1
		do
			Result := c_data_1 (internal_item.item)
		end

	data_2: NATURAL_16 is
			-- Data 2
		do
			Result := c_data_2 (internal_item.item)
		end

	data_3: NATURAL_16 is
			-- Data 3
		do
			Result := c_data_3 (internal_item.item)
		end

	data_4: ARRAY [NATURAL_8] is
			-- Data 4
		local
			l_count: INTEGER
		do
			from
				create Result.make (0, 7)
			until
				l_count >= 8
			loop
				Result.put (c_data_4 (internal_item.item, l_count), l_count)
				l_count := l_count + 1
			end
		ensure
			not_void: Result /= Void
			count_right: Result.count = 8
		end

	is_equal (other: like Current): BOOLEAN is
			-- Redefine
		local
			l_data_4, l_other_data_4: like data_4
		do
			l_data_4 := data_4
			l_data_4.compare_objects

			l_other_data_4 := other.data_4
			l_other_data_4.compare_objects

			Result := other.data_1 = data_1 and
					other.data_2 = data_2 and
					other.data_3 = data_3 and
					l_other_data_4.is_equal (l_data_4)
		end

	item: POINTER is
			-- Pointer
		do
			Result := internal_item.item
		end

feature {NONE} -- Implementation

	internal_item: MANAGED_POINTER
			-- Managed pointer to the struct.

feature {NONE} -- C externals

	c_size_of_guid: INTEGER is
			-- GUID struct size.
		external
			"C [macro %"wel_gdi_plus.h%"]"
		alias
			"sizeof (GUID)"
		end

	c_set_data_1 (a_item: POINTER; a_value: NATURAL_64) is
			-- Set `a_item''s Data1 with `a_x'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((GUID *)$a_item)->Data1 = (EIF_NATURAL_64)$a_value;
			}
			]"
		end
		
	c_set_data_2 (a_item: POINTER; a_value: NATURAL_16) is
			-- Set `a_item''s Data2 with `a_value'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((GUID *)$a_item)->Data2 = (EIF_NATURAL_16)$a_value;
			}
			]"
		end

	c_set_data_3 (a_item: POINTER; a_value: NATURAL_16) is
			-- Set `a_item''s Data3 with `a_value'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((GUID *)$a_item)->Data3 = (EIF_NATURAL_16)$a_value;
			}
			]"
		end

	c_set_data_4 (a_item: POINTER; a_index: INTEGER; a_value: NATURAL_8) is
			-- Set `a_item''s data4 value at `a_index' with `a_value'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((GUID *)$a_item)->Data4[$a_index] = (EIF_NATURAL_8)$a_value;
			]"
		end

	c_data_1 (a_item: POINTER): NATURAL_64 is
			-- `a_item''s data1
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((GUID *)$a_item)->Data1
			]"
		end

	c_data_2 (a_item: POINTER): NATURAL_16 is
			-- `a_item''s data1
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((GUID *)$a_item)->Data2
			]"
		end

	c_data_3 (a_item: POINTER): NATURAL_16 is
			-- `a_item''s data1
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((GUID *)$a_item)->Data3
			]"
		end

	c_data_4 (a_item: POINTER; a_index: INTEGER): NATURAL_8 is
			-- `a_item''s data4 value at `a_index'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((GUID *)$a_item)->Data4[$a_index]
			]"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
