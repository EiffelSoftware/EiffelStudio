indexing
	description: "Abstract Define Variable"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_define.e $"

deferred class
	OCI_DEFINE
	
inherit
	OCI_VARIABLE

feature -- Status report

	is_defined: BOOLEAN 
	
feature -- Basic operations

	define_by_pos (stmt: OCI_STATEMENT; errh: OCI_ERROR_HANDLER; pos: INTEGER) is
			-- Associate an item in a select-list with the output data buffer
		require
			not_defined: not is_defined
			valid_position: pos > 0
			valid_data_type_and_size: valid_data_type_and_size (data_type, data_size)
			buffer_allocated: buffer_allocated
		local
			status: INTEGER
			l_handle: like handle
		do
			status := oci_define_by_pos (stmt.handle, $l_handle, errh.handle, pos, 
				buffer, data_size, data_type, indicator_ptr, actual_length_ptr, return_code_ptr,
				Oci_default)
			handle := l_handle
			errh.check_error (status)
			is_allocated := status = Oci_success
			is_defined := status = Oci_success
		ensure
			allocated: is_allocated
			defined: is_defined
		end
		
feature {NONE} -- Implementation

	handle_type: INTEGER is -- Handle type
		do
			Result := Oci_htype_define
		end
		
feature {NONE} -- Externals

	oci_define_by_pos (stmtp: POINTER; defnpp: POINTER; errhp: POINTER; position: INTEGER; 
			valuep: POINTER; value_sz: INTEGER; dty: INTEGER_16; indp: POINTER; rlenp: POINTER;
			rcodep: POINTER; mode: INTEGER): INTEGER is
		external
			"C (void *, void **, void *, int, void *, int, short, void *, short *, short *, int):%
			%short | %"oci.h%""
		alias
			"OCIDefineByPos"
		end
		
end -- class OCI_DEFINE
