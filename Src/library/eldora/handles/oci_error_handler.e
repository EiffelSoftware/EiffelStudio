indexing
	description: "Base OCI Error Handler"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_error_handler.e $"

class
	OCI_ERROR_HANDLER

inherit
	OCI_HANDLE
	
	EXCEPTIONS
		undefine
			is_equal
		end
		
	PLATFORM
		undefine
			is_equal
		end
	
create
	make
	
feature {NONE} -- Initialization

	make (env: OCI_ENVIRONMENT) is
		require
			valid_environment: env /= Void and then env.is_allocated
		do
			allocate (env)
				-- Nothing to handle yet
			handled := True
		ensure
			allocated: is_allocated
			handled: handled
		end
		
feature -- Access

	error_code: INTEGER
		-- Error code for last error
	
	message: STRING
		-- Error message for last error
	
	row_offset: INTEGER is
			-- The offset (into the DML array) at which the error occurred
		local
			size: INTEGER
			status: INTEGER_16
		do
			size := Integer_bytes
			status := oci_attr_get (handle, handle_type, $Result, $size, Oci_attr_dml_row_offset,
					handle)
				check
					success: status = Oci_success
				end
		end
	
feature -- Status Report
	
	handled: BOOLEAN
		-- Has last error been handled ?
	
	valid_return_code (return_code: INTEGER): BOOLEAN is
			-- Is `return_code' valid ?
		do
			Result :=
				return_code = Oci_success or
				return_code = Oci_success_with_info or
				return_code = Oci_no_data or
				return_code = Oci_error or
				return_code = Oci_invalid_handle or
				return_code = Oci_need_data or
				return_code = Oci_still_executing or
				return_code = Oci_continue
		end

feature -- Basic Operations
	
	get_error_info (recordno: INTEGER) is
			-- Retrieve error_code and message of the last error
		require
			allocated: is_allocated
			positive_recordno: recordno > 0
		local
			size: INTEGER
			status: INTEGER_16
			temp: POINTER
		do
			size := Default_error_buffer_size
			temp := default_pointer.memory_alloc (size)
			status := oci_error_get (handle, recordno, default_pointer, $error_code, temp, size,
					handle_type)
			create message.make_from_c (temp)
			temp.memory_free
		ensure
			message_exists: message /= Void
		end

	check_error (return_code: INTEGER) is
			-- Handle errors (after an OCI operation)
		require
			valid_return_code: valid_return_code (return_code)
		do
			handled := return_code = Oci_success
			default_handle_error (return_code)
		ensure
			handled_if_success: return_code = Oci_success implies handled
		end

feature {NONE} -- Implementation

	handle_type: INTEGER is
			-- Handle type
		do
			Result := Oci_htype_error
		end

	frozen default_handle_error (return_code: INTEGER) is
			-- Perform default error handling
		do
			inspect
				return_code
			when Oci_invalid_handle then
					-- Raise a developer exception if invalid handle
				raise (Msg_invalid_handle)
			when Oci_error then
					-- Print error message if error
				get_error_info (1)
				print (message)
				handled := True
			else
					-- Otherwise, ignore
			end
		end
		
	Default_error_buffer_size: INTEGER is 512
	
	Msg_invalid_handle: STRING is "Invalid handle"
	
feature {NONE} -- Externals

	oci_attr_get (trgthndlp: POINTER; trghndltyp: INTEGER; attributep: POINTER; sizep: POINTER; 
			attrtype: INTEGER; errhp: POINTER): INTEGER_16 is
		external
			"C (void *, int, void *, int *, int, void *): sword | %"oci.h%""
		alias
			"OCIAttrGet"
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




end -- class OCI_ERROR_HANDLER
