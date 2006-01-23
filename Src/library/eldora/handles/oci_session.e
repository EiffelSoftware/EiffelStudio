indexing
	description: "Wrapper for user session"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_session.e $"

class
	OCI_SESSION
	
inherit
	OCI_CHILD_HANDLE

create
	make_session, make_session_by_handle

feature {NONE} -- Initialization

	make_session (context: OCI_SERVICE_CONTEXT; errh: OCI_ERROR_HANDLER) is
		require
			valid_service_context: context /= Void and then context.is_allocated
		do
			make (context.environment, errh)
			service_context := context
			logon_mode := Oci_default
			credentials := Oci_cred_rdbms
		ensure
			session_inactive: not is_active
			default_logon_mode: logon_mode = Oci_default
			default_credentials: credentials = Oci_cred_rdbms
			assigned_service_context: service_context = context
		end
		
	make_session_by_handle (value: POINTER; context: OCI_SERVICE_CONTEXT; errh: OCI_ERROR_HANDLER) is
			-- Initialize using a pre-allocated OCI handle
		require
			valid_error_handler: valid_error_handle (errh)
		do
			make_child_by_handle (value, errh)
			service_context := context
			logon_mode := Oci_default
			credentials := Oci_cred_rdbms
		ensure
			allocated: is_allocated
			definition: handle = value
			session_inactive: not is_active
			default_logon_mode: logon_mode = Oci_default
			default_credentials: credentials = Oci_cred_rdbms
			assigned_service_context: service_context = context
		end
	
feature -- Access

	failed: BOOLEAN
			-- Has the last operation failed ?

	credentials: INTEGER
		-- The type of credentials to use for establishing the user session
	
	logon_mode: INTEGER
		-- The mode of operation to use for establishing the user session

	service_context: OCI_SERVICE_CONTEXT
		-- The current service context

	username: STRING
		-- Logon username
	
	password: STRING
		-- Logon password

feature -- Status report

	is_active: BOOLEAN
		-- Is session active (i.e. logon successful) ?
		
feature -- Basic operations

	set_logon_mode (mode: INTEGER) is
			-- Set logon mode
		require
			valid_argument: valid_logon_mode (mode)
			session_inactive: not is_active
		do
			logon_mode := mode
		ensure
			definition: logon_mode = mode
		end
		
	set_credentials (cred: INTEGER) is
			-- Set credentials
		require
			valid_argument: valid_credentials (cred)
			session_inactive: not is_active
		do
			credentials := cred
		ensure
			definition: credentials = cred
		end

	set_username (name: STRING) is
			-- Set logon username
		require
			valid_name: name /= Void and then name.count /= 0
			session_inactive: not is_active
		do
			set_str_attr (Oci_attr_username, name, error_handler)
			username := name.twin
		ensure
			definition: username /= Void and then username.is_equal (name)
		end

	set_password (pwd: STRING) is
			-- Set logon password
		require
			valid_password: pwd /= Void
			session_inactive: not is_active
		do
			set_str_attr (Oci_attr_password, pwd, error_handler)
			password := pwd.twin
		ensure
			definition: password /= Void and then password.is_equal (pwd)
		end

	logon is
			-- Begin a user session for the server specified in service context handle
		require
			allocated: is_allocated
			session_not_active: not is_active
			valid_service_context: service_context /= Void and then service_context.is_allocated
		local
			status: INTEGER_16
		do
			status := oci_session_begin (service_context.handle, error_handler.handle, handle, 
					credentials, logon_mode)
			failed := status /= Oci_success
			error_handler.check_error (status)
			if not failed then
				is_active := True
				service_context.set_session (Current)
			end
		ensure
			success_unless_failed: (not failed) implies is_active
		end
		
	logoff is
			-- Terminate the user session context
		require
			allocated: is_allocated
			session_active: is_active
		local
			status: INTEGER_16
		do
			status := oci_session_end (service_context.handle, error_handler.handle, handle, 
					Oci_default)
			failed := status /= Oci_success
			error_handler.check_error (status)
			if not failed then
				is_active := False
			end
		ensure
			success_unless_failed: (not failed) implies (not is_active)
		end

feature {OCI_HANDLE} -- Implementation

	handle_type: INTEGER is
			-- Handle type
		do
			Result := Oci_htype_session
		end
		
feature -- Utilities

	valid_logon_mode (mode: INTEGER): BOOLEAN is
			-- Is `mode' a valid logon mode ?
		do
			Result := mode = Oci_default or
					  mode = Oci_migrate or
					  mode = Oci_sysdba or
					  mode = Oci_sysoper or
					  mode = (Oci_sysdba | Oci_prelim_auth) or
					  mode = (Oci_sysoper | Oci_prelim_auth)
		end
		
	valid_credentials (cred: INTEGER): BOOLEAN is
			-- Is `cred' a valid value for credentials ?
		do
			Result := (cred = Oci_cred_rdbms) or (cred = Oci_cred_ext)
		end
		
feature {NONE} -- Externals

	oci_session_begin (svchp: POINTER; errhp: POINTER; usrhp: POINTER; credt: INTEGER; 
			mode: INTEGER): INTEGER_16 is
		external
			"C (void *, void *, void *, int, int): short | %"oci.h%""
		alias
			"OCISessionBegin"
		end
		
	oci_session_end (svchp: POINTER; errhp: POINTER; usrhp: POINTER; mode: INTEGER): INTEGER_16 is
		external
			"C (void *, void *, void *, int): short | %"oci.h%""
		alias
			"OCISessionEnd"
		end
		
invariant
	valid_logon_mode: valid_logon_mode (logon_mode)
	valid_credentials: valid_credentials (credentials)
	service_attached: is_active implies service_context /= Void
		
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




end -- class OCI_SESSION
