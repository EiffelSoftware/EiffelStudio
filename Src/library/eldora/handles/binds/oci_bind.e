indexing
	description: "Abstract OCI Bind Handle"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_bind.e $"

deferred class
	OCI_BIND
	
inherit
	OCI_VARIABLE

feature -- Access

	name: STRING

feature -- Status report

	is_bound: BOOLEAN
		-- Is the variable bound ?
	
feature -- Basic operations

	bind_by_name (stmt: OCI_STATEMENT; errh: OCI_ERROR_HANDLER; varname: STRING) is
			-- Create association between a program variable and a placeholder in a SQL statement
			-- or PL/SQL block
		require
			not_bound: not is_bound
			non_empty_name: name /= Void and then name.count > 0
			buffer_allocated: buffer_allocated
			valid_data_type_and_size: valid_data_type_and_size (data_type, data_size)
		local
			status: INTEGER
			curel: INTEGER
			l_handle: like handle
			temp: WEL_STRING
		do
			if varname /= Void then				
				name := varname.twin	
			end
			create temp.make (name)
			status := oci_bind_by_name(stmt.handle, $l_handle, errh.handle, temp.item, name.count, 
				buffer, data_size, data_type, indicator_ptr, actual_length_ptr, return_code_ptr, 
				0, $curel, Oci_default)
			handle := l_handle
			errh.check_error (status)
			is_allocated := status = Oci_success
			is_bound := status = Oci_success
		ensure
			allocated: is_allocated
			bound: is_bound
		end
		
	set_value (new_value: like value) is
			-- Set value of `Current' bind-variable to `new_value'
		require
			value_exists: value /= Void
		deferred
		ensure
			value_set: value /= Void and then value.is_equal (new_value)
		end
	
feature {NONE} -- Implementation

	handle_type: INTEGER is
			-- Handle type
		do
			Result := Oci_htype_bind
		end

feature {NONE} -- Externals

	oci_bind_by_name(stmtp: POINTER; bindpp: POINTER; errhp: POINTER; placeholder: POINTER;
			placeh_len: INTEGER; valuep: POINTER; value_sz: INTEGER; dty: INTEGER_16; indp: POINTER;
			alenp: POINTER; rcodep: POINTER; maxarr_len: INTEGER; curelep: POINTER; mode: INTEGER): 
			INTEGER_16 is
		external
			"C (void *, void **, void *, char *, int, void *, int, short, void *, short *, short *,%
			%int, int *, int): sword | %"oci.h%""
		alias
			"OCIBindByName"
		end
		
--invariant
--	name_not_empty: name /= Void and then not name.is_empty

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




end -- class OCI_BIND
