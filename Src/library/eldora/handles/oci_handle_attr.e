indexing
	description: "Abstract OCI handle wrapper with access to attributes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_handle_attr.e $"  
	
deferred class
	OCI_HANDLE_ATTR
	
inherit
	OCI_HANDLE
	
	PLATFORM
		undefine
			is_equal
		end

	STRING_HANDLER
		undefine
			is_equal
		end

feature -- Access

	Default_max_str_attr_size: INTEGER is 512
		-- Default maximum size for a string attribute
	
	max_str_attr_size: INTEGER
		-- Maximum size for a string attribute value

	str_attr (type: INTEGER; errh: OCI_ERROR_HANDLER): STRING is
			-- Obtain value of handle's string attribute
		require
			allocated: is_allocated
			valid_error_handle: valid_error_handle (errh)
		local
			size: INTEGER
			status: INTEGER_16
			temp: POINTER
		do
			if max_str_attr_size = 0 then
					-- Automatically initialize max_str_attr_size
				max_str_attr_size := Default_max_str_attr_size
			end
			size := max_str_attr_size
			status := oci_attr_get (handle, handle_type, $temp, $size, type, errh.handle)
			check
				success: status = Oci_success
				size_not_exceeded: size <= max_str_attr_size
				address_non_void: temp /= default_pointer
			end
			errh.check_error (status)
			create Result.make (size)
			Result.from_c_substring (temp, 1, size)
		ensure
			initialized_max_str_attr_size: max_str_attr_size > 0
		end
		
	int_attr (type: INTEGER; errh: OCI_ERROR_HANDLER): INTEGER is
			-- Obtain value of handle's integer attribute
		require
			allocated: is_allocated
			valid_error_handle: valid_error_handle (errh)
		local
			size: INTEGER
			status: INTEGER_16
		do
			size := Integer_bytes
			status := oci_attr_get (handle, handle_type, $Result, $size, type, errh.handle)
				check
					success: status = Oci_success
				end
			errh.check_error (status)
		end
		
	int16_attr (type: INTEGER; errh: OCI_ERROR_HANDLER): INTEGER_16 is
			-- Obtain value of handle's short integer attribute
		require
			allocated: is_allocated
			valid_error_handle: valid_error_handle (errh)
		local
			size: INTEGER
			status: INTEGER_16
		do
			size := 2
			status := oci_attr_get (handle, handle_type, $Result, $size, type, errh.handle)
				check
					success: status = Oci_success
				end
			errh.check_error (status)
		end
		
	int8_attr (type: INTEGER; errh: OCI_ERROR_HANDLER): INTEGER_8 is
			-- Obtain value of handle's byte attribute
		require
			allocated: is_allocated
			valid_error_handle: valid_error_handle (errh)
		local
			size: INTEGER
			status: INTEGER_16
		do
			size := 1
			status := oci_attr_get (handle, handle_type, $Result, $size, type, errh.handle)
				check
					success: status = Oci_success
				end
			errh.check_error (status)
		end
		
feature -- Element change

	set_str_attr (type: INTEGER; value: STRING; errh: OCI_ERROR_HANDLER) is
			-- Set handle's string attribute value
		require
			allocated: is_allocated
			valid_error_handle: valid_error_handle (errh)
		local
			status: INTEGER_16
			area: WEL_STRING
		do
			create area.make (value)
			status := oci_attr_set (handle, handle_type, area.item, value.count, type, errh.handle)
			check
				success: status = Oci_success
			end
			errh.check_error (status)
		ensure
--			definition: str_attr (type, errh).is_equal (value)
		end

	set_int_attr (type: INTEGER; value: INTEGER; errh: OCI_ERROR_HANDLER) is
			-- Set handle's integer attribute value
		require
			allocated: is_allocated
			valid_error_handle: valid_error_handle (errh)
		local
			status: INTEGER_16
		do
			status := oci_attr_set (handle, handle_type, $value, Integer_bytes, type, errh.handle)
				check
					success: status = Oci_success
				end
			errh.check_error (status)
		ensure
--			definition: int_attr (type, errh) = value
		end

feature -- Basic operations

	set_max_str_attr_size (size: INTEGER) is
			-- Set maximum size for a string attribute value
		require
			positive_size: size > 0
		do
			max_str_attr_size := size
		ensure
			definition: max_str_attr_size = size
		end
			
feature {OCI_HANDLE} -- Implementation
		
	pointer_attr (type: INTEGER; errh: OCI_ERROR_HANDLER): POINTER is
			-- Obtain value of handle's pointer attribute (e.g. a sub-handle)
		require
			allocated: is_allocated
			valid_error_handle: valid_error_handle (errh)
		local
			size: INTEGER
			status: INTEGER_16
		do
			size := Pointer_bytes
			status := oci_attr_get (handle, handle_type, $Result, $size, type, errh.handle)
				check
					success: status = Oci_success
				end
			errh.check_error (status)
		end
		
	set_pointer_attr (type: INTEGER; value: POINTER; errh: OCI_ERROR_HANDLER) is
			-- Set handle's integer attribute value
		require
			allocated: is_allocated
			valid_error_handle: valid_error_handle (errh)
		local
			status: INTEGER_16
		do
			status := oci_attr_set (handle, handle_type, value, Pointer_bytes, type, errh.handle)
				check
					success: status = Oci_success
				end
			errh.check_error (status)
		end

feature {NONE} -- Externals

	oci_attr_get (trgthndlp: POINTER; trghndltyp: INTEGER; attributep: POINTER; sizep: POINTER; 
			attrtype: INTEGER; errhp: POINTER): INTEGER_16 is
		external
			"C (dvoid *, ub4, dvoid *, ub4 *, ub4, OCIError *): short | %"oci.h%""
		alias
			"OCIAttrGet"
		end
				
	oci_attr_set (trgthndlp: POINTER; trghndltyp: INTEGER; attributep: POINTER; size: INTEGER; 
			attrtype: INTEGER; errhp: POINTER): INTEGER_16 is
		external
			"C (dvoid *, ub4, dvoid *, ub4, ub4, OCIError *): short | %"oci.h%""
		alias
			"OCIAttrSet"
		end
		
invariant
	non_negative_max_str_attr_size: max_str_attr_size >= 0

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




end -- class OCI_HANDLE_ATTR
