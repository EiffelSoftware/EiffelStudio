indexing
	description: "COM GUID structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_GUID

inherit
	ECOM_STRUCTURE
		redefine
			is_equal,
			out
		end

	ECOM_ROUTINES
		undefine
			is_equal,
			copy,
			out
		end

create
	make,
	make_from_pointer,
	make_from_string,
	make_from_guid

feature {NONE} -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Basic operation

	generate is
			-- Generate a new GUID
		do
			is_initialized := c_generate_guid (item) = 0
		end

feature {NONE} -- Initialization

	make_from_string (string: STRING) is
			-- Create GUID from string `string'.
		require
			non_void_string: string /= Void
			valid_guid_string: guid_routines.is_valid_guid_string (string)
		local
			l_string: WEL_STRING
		do
			make
			create l_string.make (string)
			is_initialized := c_string_to_guid (l_string.item, item) = 0
		ensure
			valid_item: item /= default_pointer
		end

	make_from_guid (other: ECOM_GUID) is
			-- Create new structure with same GUID as `other'.
		require
			valid_guid: other /= Void and then other.item /= default_pointer
		do
			make
			memory_copy (other.item, structure_size)
		ensure
			valid_item: item /= default_pointer
		end

feature -- Status Report

	is_equal (a_guid: ECOM_GUID): BOOLEAN is
			-- Is `a_guid' equal to `Current'?
		do
			Result := c_is_equal_guid (item, a_guid.item)
		end

	is_initialized: BOOLEAN
			-- Is underlying C structure correctly initialized?

feature -- Measurement

	structure_size: INTEGER is
			-- Size of GUID structure
		do
			Result := c_size_of_guid
		end

feature -- Conversion

	to_string: STRING is
			-- String representation
		require
			valid_item: item /= default_pointer
		local
			l_string: WEL_STRING
		do
			create l_string.make_empty (39)
			if c_guid_to_string (item, l_string.item, 39) = 0 then
				Result := ""
			else
				Result := l_string.string
			end
		ensure
			non_void_representation: Result /= Void
		end

	to_definition_string: STRING is
			-- String representation needed for code generation.
		require
			valid_item: item /= default_pointer
		local
			l_string: C_STRING
		do
			create l_string.make_empty (69)
			c_guid_to_defstring (item, l_string.item)
			Result := l_string.string
		ensure
			non_void_representation: Result /= Void
		end

	out: STRING is
			-- String representation
		do
			Result := to_string
		end

feature {NONE} -- Externals

	c_size_of_guid: INTEGER is
		external
			"C macro use <windows.h>"
		alias
			"sizeof(GUID)"
		end

	c_string_to_guid (a_str: POINTER; a_guid: POINTER): INTEGER is
		external
			"C signature (LPOLESTR, LPCLSID): EIF_INTEGER use <windows.h>"
		alias
			"CLSIDFromString"
		end

	c_guid_to_string (a_guid, a_string: POINTER; a_count: INTEGER): INTEGER is
		external
			"C signature (REFGUID, LPOLESTR, int): EIF_INTEGER use <windows.h>"
		alias
			"StringFromGUID2"
		end

	c_is_equal_guid (a_guid1, a_guid2: POINTER): BOOLEAN is
		external
			"C signature (REFGUID, REFGUID): EIF_BOOLEAN use <windows.h>"
		alias
			"IsEqualGUID"
		end

	c_generate_guid (a_guid: POINTER): INTEGER is
		external
			"C signature (GUID*): EIF_INTEGER use <windows.h>"
		alias
			"CoCreateGuid"
		end

	c_guid_to_defstring (a_guid, a_string: POINTER) is
		external
			"C inline use <windows.h>"
		alias
			"[
				sprintf ($a_string, "{0x%.8x,0x%.4x,0x%.4x,{0x%.2x,0x%.2x,0x%.2x,0x%.2x,0x%.2x,0x%.2x,0x%.2x,0x%.2x}}",
      				((GUID*)$a_guid)->Data1, ((GUID*)$a_guid)->Data2, ((GUID*)$a_guid)->Data3,
      				((GUID*)$a_guid)->Data4[0], ((GUID*)$a_guid)->Data4[1], ((GUID*)$a_guid)->Data4[2], ((GUID*)$a_guid)->Data4[3],
      				((GUID*)$a_guid)->Data4[4], ((GUID*)$a_guid)->Data4[5], ((GUID*)$a_guid)->Data4[6], ((GUID*)$a_guid)->Data4[7])
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

end -- class ECOM_GUID

