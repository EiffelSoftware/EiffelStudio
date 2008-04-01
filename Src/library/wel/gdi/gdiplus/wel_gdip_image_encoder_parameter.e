indexing
	description: "[
					Encoder parameter used by {WEL_GDIP_IMAGE_ENCODER_PARAMETERS}
																					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_IMAGE_ENCODER_PARAMETER

create
	make

feature {NONE} -- Initialization

	make (a_guid: !WEL_GUID; a_value: NATURAL_64) is
			-- Creation method
		require
			valid: (create {WEL_GDIP_IMAGE_ENCODER}.make_empty).is_valid (a_guid)
			valid_for_quality: a_guid.is_equal ((create {WEL_GDIP_IMAGE_ENCODER}.make_empty).quality) implies (0 <= a_value and a_value <= 100)
		do
			create item.make (size)
			set_guid (a_guid)
			set_value_type (4) -- NATURAL_64 type is 4
			set_number_of_values (1)
			set_value (a_value)
		ensure
			set: guid.is_equal (a_guid)
			set: value = a_value
			set: value_type = 4
			set: number_of_values = 1
		end

feature -- Command

	item: !MANAGED_POINTER
			-- Convert current to C pointer

	set_guid (a_guid: !WEL_GUID) is
			-- Set `gudi' with `a_guid'
		do
			c_set_guid (item.item, a_guid.item)
		ensure
			set: guid.is_equal (a_guid)
		end

	set_value_type (a_type: NATURAL_64) is
			-- Set `value_type' with `a_value'
		do
			c_set_type (item.item, a_type)
		ensure
			set: value_type = a_type
		end

	set_number_of_values (a_number: NATURAL_64) is
			-- Set `number_of_value' with `a_number'
		do
			c_set_number_of_values (item.item, a_number)
		ensure
			set: number_of_values = a_number
		end

	set_value (a_value: NATURAL_64) is
			-- Set `value' with `a_value'
		do
			create value_cache.make (natural_64_byte)
			value_cache.put_natural_64 (a_value, 0)
			c_set_value (item.item, value_cache.item)
		ensure
			set: value = a_value
		end

feature -- Query

	guid: !WEL_GUID is
			-- Parameter GUID.
		do
			create Result.share_from_pointer (c_guid (item.item))
		end

	value: NATURAL_64 is
			-- Value of this parameter
		local
			l_result: MANAGED_POINTER
			l_platform: PLATFORM
		do
			create l_platform
			create l_result.make_from_pointer (c_value (item.item), natural_64_byte)
			Result := l_result.read_natural_64 (0)
		end

	value_type: NATURAL_64 is
			-- `value''s type
		do
			Result := c_type (item.item)
		end

	number_of_values: NATURAL_64 is
			-- `value' number count
		do
			Result := c_number_of_values (item.item)
		end

feature {WEL_GDIP_IMAGE_ENCODER_PARAMETER} -- Internal query

	size: INTEGER is
			-- C structure size
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"sizeof (ImageEncoderParameter)"
		end

feature {NONE} -- Implementation

	value_cache: MANAGED_POINTER
			-- The pointer wrapper for `value'
			-- We have to cache it here,
			-- otherwise the value will be collected by GC

	natural_64_byte: INTEGER is 8
			--  NATURAL_64 is 8 bits

feature {NONE} -- C externals

	c_guid (a_item: POINTER): POINTER is
			-- Get structure `a_item''s Guid
		require
			exists: a_item /= default_pointer
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				& (((ImageEncoderParameter *)$a_item)->Guid)
			]"
		end

	c_set_guid (a_item: POINTER; a_guid: POINTER) is
			-- Set structure `a_item''s Guid with `a_guid'.
		require
			exists: a_item /= default_pointer
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
			{
				((ImageEncoderParameter *)$a_item)->Guid = * ((GUID *)$a_guid);
			}
			]"
		end

	c_number_of_values (a_item: POINTER): NATURAL_64 is
			-- Get structure `a_item''s NumberOfValues
		require
			exists: a_item /= default_pointer
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageEncoderParameter *)$a_item)->NumberOfValues
			]"
		end

	c_set_number_of_values (a_item: POINTER; a_number: NATURAL_64) is
			-- Set structure `a_item''s NumberOfValues with `a_number'.
		require
			exists: a_item /= default_pointer
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
			{
				((ImageEncoderParameter *)$a_item)->NumberOfValues = (EIF_NATURAL_64)$a_number;
			}
			]"
		end

	c_type (a_item: POINTER): NATURAL_64 is
			-- Get structure `a_item''s Type
		require
			exists: a_item /= default_pointer
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageEncoderParameter *)$a_item)->Type
			]"
		end

	c_set_type (a_item: POINTER; a_type: NATURAL_64) is
			-- Set structure `a_item''s Type with `a_type'.
		require
			exists: a_item /= default_pointer
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
			{
				((ImageEncoderParameter *)$a_item)->Type = (EIF_NATURAL_64)$a_type;
			}
			]"
		end

	c_value (a_item: POINTER): POINTER is
			-- Get structure `a_item''s Value
		require
			exists: a_item /= default_pointer
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
				((ImageEncoderParameter *)$a_item)->Value
			]"
		end

	c_set_value (a_item: POINTER; a_value: POINTER) is
			-- Set structure `a_item''s Value with `a_value'.
		require
			exists: a_item /= default_pointer
		external
			"C inline use <wel_gdi_plus.h>"
		alias
			"[
			{
				((ImageEncoderParameter *)$a_item)->Value = (EIF_POINTER)$a_value;
			}
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

