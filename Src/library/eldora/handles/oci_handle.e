indexing
	description: "Abstract OCI handle wrapper"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_handle.e $"

deferred class
	OCI_HANDLE
	
inherit
	OCI_CONST
		export {NONE} all
		undefine
			is_equal
		end
		
feature -- Status report

	is_allocated: BOOLEAN
		-- Has the handle been allocated by OCI ?
	
	is_external: BOOLEAN
		-- Was it allocated externally ?
	
	valid_error_handle (error_handle: OCI_HANDLE): BOOLEAN is
			-- Is `error_handle' a valid OCI error handle?
		do
			Result := error_handle /= Void and then 
				(error_handle.is_allocated and error_handle.handle_type = Oci_htype_error)
		end
		
feature -- Status setting

	allocate (parent: OCI_HANDLE) is
			-- Allocate handle
		require
			not_yet_allocated: not is_allocated
			valid_parent: parent /= Void and then parent.is_allocated
		local
			status: INTEGER_16
			l_handle: like handle
		do
			status := oci_handle_alloc (parent.handle, $l_handle, handle_type, 0, default_pointer)
			handle := l_handle
			is_allocated := status = Oci_success
		ensure
			allocated: is_allocated
			not_external: not is_external
		end
		
	free is
			-- Free the handle
		require
			allocated: is_allocated
			not_external: not is_external
		local
			status: INTEGER_16
		do
			status := oci_handle_free (handle, handle_type)
			check
				success: status = Oci_success
			end
			is_allocated := False
		ensure
			not_allocated: not is_allocated
		end
		
feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Equality relation for OCI handles
		do
			Result := handle.is_equal (other.handle)
		end
			
feature {OCI_HANDLE, OCI_TYPE, OCI_OBJECT} -- Implementation

	handle: POINTER
		-- Actual OCI handle
	
	handle_type: INTEGER is
			-- Handle type
		deferred
		end
		
	make_by_handle (value: POINTER) is
			-- Initialize using a pre-allocated OCI handle
		do
			handle := value
			is_allocated := True
			is_external := True
		ensure
			allocated: is_allocated
			definition: handle = value
			is_external: is_external
		end
	
feature {NONE} -- Externals

	oci_handle_alloc (parenth: POINTER; hndlpp: POINTER; type: INTEGER; xtramem_sz: INTEGER; 
			usrmempp: POINTER): INTEGER_16 is
		external
			"C (void *, void **, int, int, void **): short | %"oci.h%""
		alias
			"OCIHandleAlloc"
		end
		
	oci_handle_free (hndlp: POINTER; type: INTEGER): INTEGER_16 is
		external
			"C (void *, int): short | %"oci.h%""
		alias
			"OCIHandleFree"
		end
		
	oci_error_get (hndlp: POINTER; recordno: INTEGER; sqlstate: POINTER; errcodep: POINTER; 
			bufp: POINTER; bufsiz: INTEGER; type: INTEGER): INTEGER_16 is
		external
			"C (void *, ub4, text *, sb4 *, text *, ub4, ub4): sword | %"oci.h%""
		alias
			"OCIErrorGet"
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




end -- class OCI_HANDLE
