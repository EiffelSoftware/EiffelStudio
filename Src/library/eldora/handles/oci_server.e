indexing
	description: "OCI Server Context"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_server.e $"

class
	OCI_SERVER

inherit
	OCI_CHILD_HANDLE

create
	make_server, make_server_by_handle

feature {NONE} -- Initialization

	make_server (context: OCI_SERVICE_CONTEXT; errh: OCI_ERROR_HANDLER) is
		require
			valid_context: context /= Void and context.is_allocated
			valid_error_handler: valid_error_handle (errh)
		do
			make (context.environment, errh)
--			service_context := context
--			allocate (context)
--			error_handler := errh
		ensure
			allocated: is_allocated
			error_handler_assigned: error_handler = errh
		end
		
	make_server_by_handle (value: POINTER; errh: OCI_ERROR_HANDLER) is
			-- Initialize using a pre-allocated OCI handle
		require
			valid_error_handler: valid_error_handle (errh)
		do
			make_child_by_handle (value, errh)
		ensure
			allocated: is_allocated
			definition: handle = value
			error_handler_assigned: error_handler = errh
		end
		
feature -- Access

	failed: BOOLEAN
			-- Has the last operation failed ?

feature -- Status report

	is_attached: BOOLEAN
			-- Is server attached ?
	
	is_active_connection: BOOLEAN is
			-- Is there an active connection to the server?
		require
			allocated: is_allocated
		do
			Result := int_attr (Oci_attr_server_status, error_handler) = Oci_server_normal
		end
		
feature -- Basic operations

	attach (server: STRING) is
			-- Create an access path to a data source for OCI operations
		require
			not_attached: not is_attached
		local
			status: INTEGER_16
			area: WEL_STRING
		do
			create area.make (server)
			status := oci_server_attach (handle, error_handler.handle, area.item, server.count,
					Oci_default)
			failed := status /= Oci_success
			error_handler.check_error (status)
			is_attached := status = Oci_success
		ensure
			attached: (not failed) implies is_attached
		end
		
	detach is
			-- Delete an access to a data source for OCI operations
		require
			attached: is_attached
			allocated: is_allocated
		local
			status: INTEGER_16
		do
			status := oci_server_detach (handle, error_handler.handle, Oci_default)
			failed := status /= Oci_success
			error_handler.check_error (status)
			if not failed then
				is_attached := False
			end
		ensure
			detached: (not failed) implies (not is_attached)
		end

feature {NONE} -- Implementation

	handle_type: INTEGER is
			-- Handle type
		do
			Result := Oci_htype_server
		end
		
feature {NONE} -- Externals

	oci_server_attach (srvhp: POINTER; errhp: POINTER; dblink: POINTER; dblink_len: INTEGER; 
			mode: INTEGER): INTEGER_16 is
		external
			"C (void *, void *, char *, int, int): short | %"oci.h%""
		alias
			"OCIServerAttach"
		end
		
	oci_server_detach (srvhp: POINTER; errhp: POINTER; mode: INTEGER): INTEGER_16 is
		external
			"C (void *, void *, int): short | %"oci.h%""
		alias
			"OCIServerDetach"
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




end -- class OCI_SERVER
