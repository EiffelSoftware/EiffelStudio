indexing
	description: "Define Variable of type INTEGER"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_define_integer.e $"

class
	OCI_DEFINE_INTEGER

inherit
	OCI_DEFINE
	
	PLATFORM
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			make_variable (Sqlt_int, Integer_bytes)
		end

feature -- Access

	value: INTEGER_REF is
			-- Current value of define variable
		local
			integer_value: INTEGER
		do
			($integer_value).memory_copy (buffer, Integer_bytes)
			create Result
			Result.set_item (integer_value)
		end
	
	valid_data_type_and_size (type: INTEGER_16; size: INTEGER): BOOLEAN is
			-- Are `type' and `size' valid values for `data_type' and `data_size' ?
		do
			Result := type = Sqlt_int and size = Integer_bytes
		end
	
end -- class OCI_DEFINE_INTEGER
