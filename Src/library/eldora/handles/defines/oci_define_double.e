indexing
	description: "Define Variable of type DOUBLE"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_define_double.e $"

class
	OCI_DEFINE_DOUBLE

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
			make_variable (Sqlt_flt, Double_bytes)
		end

feature -- Access

	value: DOUBLE_REF is
			-- Current value of define variable
		local
			double_value: DOUBLE
		do
			($double_value).memory_copy (buffer, Double_bytes)
			create Result
			Result.set_item (double_value)
		end
	
	valid_data_type_and_size (type: INTEGER_16; size: INTEGER): BOOLEAN is
			-- Are `type' and `size' valid values for `data_type' and `data_size' ?
		do
			Result := type = Sqlt_flt and size = Double_bytes
		end
	
end -- class OCI_DEFINE_DOUBLE
