indexing
	description: "Define Variable of type STRING"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_define_string.e $"

class
	OCI_DEFINE_STRING

inherit
	OCI_DEFINE

	STRING_HANDLER
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (size: INTEGER) is
		do
			make_variable (Sqlt_chr, size)
			create string_value.make (size)
		end

feature -- Access

	value: STRING is
			-- Current value of define variable
		do
			Result := string_value
			check
				no_memory_violation: actual_length <= data_size
			end
			Result.set_count (actual_length)
			Result.from_c_substring (buffer, 1, actual_length)
		end
		
	Max_string_length: INTEGER is 65535
	
	valid_data_type_and_size (type: INTEGER_16; size: INTEGER): BOOLEAN is
			-- Are `type' and `size' valid values for `data_type' and `data_size' ?
		do
			Result := type = Sqlt_chr and (size > 0) and (size <= Max_string_length)
		end
		
feature {NONE} -- Implementation

	string_value: STRING
	
end -- class OCI_DEFINE_STRING
