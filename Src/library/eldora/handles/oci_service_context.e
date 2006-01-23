indexing
	description: "Service Context"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_service_context.e $"

class 
	OCI_SERVICE_CONTEXT

inherit
	OCI_CHILD_HANDLE

create
	make, logon

feature -- Access

	server: OCI_SERVER
			-- Associated server context handle

	session: OCI_SESSION
			-- Associated user session handle

	transaction: OCI_TRANSACTION
			-- Associated transaction handle
	
	timeout: INTEGER_16
			-- Transaction timeout
	
feature -- Status report

	failed: BOOLEAN
			-- Has the last operation failed ?

	simple_logon: BOOLEAN
			-- Connection was made using simplified `logon' method; service context is read-only

feature -- Basic operations

	set_server (value: OCI_SERVER) is
			-- Set associated server context handle
		require
			allocated: value.is_allocated
			valid_argument: value /= Void and then value.is_allocated
			no_simple_logon: not simple_logon
		do
			set_pointer_attr (Oci_attr_server, value.handle, error_handler)
			server := value
		ensure
			definition: server /= Void and then server.is_equal (value)
		end

	set_session (value: OCI_SESSION) is
			-- Set associated user session handle
		require
			allocated: value.is_allocated
			valid_argument: value /= Void and then value.is_allocated
			no_simple_logon: not simple_logon
		do
			set_pointer_attr (Oci_attr_session, value.handle, error_handler)
			session := value
		ensure
			definition: session /= Void and then session.is_equal (value)
		end

	set_transaction (value: OCI_TRANSACTION) is
			-- Set associated transaction handle
		require
			allocated: value.is_allocated
			valid_argument: value /= Void and then value.is_allocated
			no_simple_logon: not simple_logon
		do
			set_pointer_attr (Oci_attr_trans, value.handle, error_handler)
			transaction := value
		ensure
			definition: transaction /= Void and then transaction.is_equal (value)
		end

	set_timeout (value: INTEGER_16) is
			-- Set transaction timeout
		require
			valid_argument: value >= 0
		do
			timeout := value
		ensure
			definition: timeout = value
		end

	logon (env: OCI_ENVIRONMENT; errh: OCI_ERROR_HANDLER; username, password, dbname: STRING) is
			-- Simple logon; server context and user session are created implicitly
		require
			not_allocated: not is_allocated
			valid_error_handler: valid_error_handle (errh)
		local
			status: INTEGER_16
			temp_ptr: POINTER
			temp_user, temp_pwd, temp_db: WEL_STRING
			l_handle: like handle
		do
			error_handler := errh
			create temp_user.make (username)
			create temp_pwd.make (password)
			create temp_db.make (dbname)
			status := oci_logon (env.handle, error_handler.handle, $l_handle, temp_user.item, 
					username.count, temp_pwd.item, password.count, temp_db.item, dbname.count)
			handle := l_handle
			error_handler.check_error (status)
			failed := status /= Oci_success
			if not failed then
				is_allocated := True -- Allocated implicitly by `oci_logon', if successful
				temp_ptr := pointer_attr (Oci_attr_server, error_handler)
				create server.make_server_by_handle (temp_ptr, error_handler)
				temp_ptr := pointer_attr (Oci_attr_session, error_handler)
				create session.make_session_by_handle (temp_ptr, Current, error_handler)
				temp_ptr := pointer_attr (oci_attr_trans, error_handler)
				create transaction.make_child_by_handle (temp_ptr, error_handler)
				simple_logon := True
			end
		ensure
			allocated: (not failed) implies is_allocated
			assigned_error_handler: error_handler = errh
			simple_logon: (not failed) implies simple_logon
		end

	logoff is
			-- Terminate simple connection created by `logon'
		require
			simple_logon: simple_logon
			allocated: is_allocated
		local
			status: INTEGER_16
		do
			status := oci_logoff (handle, error_handler.handle)
			failed := status /= Oci_success
			error_handler.check_error (status)
			if not failed then
				simple_logon := False
				is_allocated := False
				session := Void
				server := Void
				transaction := Void
			end
		ensure
			no_simple_logon: (not failed) implies (not simple_logon)
			deallocated: (not failed) implies (not is_allocated)
		end

	break is
			-- Immediate (asynchronous) abort of any currently executing OCI function that is 
			-- associated with the server
		require
			allocated: is_allocated
		local
			status: INTEGER_16
		do
			status := oci_break (handle, error_handler.handle)
			failed := status /= Oci_success
			error_handler.check_error (status)
		end

	start_transaction is
			-- Start a new transaction
		require
			allocated: is_allocated
		local
			status: INTEGER_16
			temp_ptr: POINTER
		do
			status := oci_trans_start (handle, error_handler.handle, timeout, Oci_trans_new)
			failed := status /= Oci_success
			error_handler.check_error (status)
			temp_ptr := pointer_attr (Oci_attr_trans, error_handler)
			create transaction.make_child_by_handle (temp_ptr, error_handler)
		ensure
			transaction_active: transaction /= Void and then transaction.is_allocated
		end

	resume_transaction is
			-- Resume current `transaction'
		require
			allocated: is_allocated
		local
			status: INTEGER_16
		do
			status := oci_trans_start (handle, error_handler.handle, timeout, Oci_trans_resume)
			failed := status /= Oci_success
			error_handler.check_error (status)
		end

	commit is
			-- Commit current `transaction'
		require
			allocated: is_allocated
		local
			status: INTEGER_16
		do
			status := oci_trans_commit (handle, error_handler.handle, Oci_default)
			failed := status /= Oci_success
			error_handler.check_error (status)
		end

	rollback is
			-- Rollback current `transaction'
		require
			allocated: is_allocated
		local
			status: INTEGER_16
		do
			status := oci_trans_rollback (handle, error_handler.handle, Oci_default)
			failed := status /= Oci_success
			error_handler.check_error (status)
		end
	
feature {NONE} -- Implementation

	handle_type: INTEGER is
			-- Handle type
		do
			Result := Oci_htype_svcctx
		end
	
feature {NONE} -- Externals

	oci_logon (envhp: POINTER; errhp: POINTER; svchp: POINTER; 
			username: POINTER; uname_len: INTEGER; password: POINTER; passwd_len: INTEGER; 
			dbname: POINTER; dbname_len: INTEGER): INTEGER_16 is
		external
			"C (OCIEnv *, OCIError *, OCISvcCtx **, text *, ub4, text *, ub4, text *, ub4): sword | %"oci.h%""
		alias
			"OCILogon"
		end

	oci_logoff (svchp: POINTER; errhp: POINTER): INTEGER_16 is
		external
			"C (OCISvcCtx *, OCIError *): sword | %"oci.h%""
		alias
			"OCILogoff"
		end

	oci_break (svchp: POINTER; errhp: POINTER): INTEGER_16 is
		external
			"C (dvoid *, OCIError *): sword | %"oci.h%""
		alias
			"OCIBreak"
		end

	oci_trans_start (svchp: POINTER; errhp: POINTER; time_out: INTEGER_16; flags: INTEGER): INTEGER_16 is
		external
			"C (OCISvcCtx *, OCIError *, uword, ub4): sword | %"oci.h%""
		alias
			"OCITransStart"
		end

	oci_trans_detach (svchp: POINTER; errhp: POINTER; flags: INTEGER): INTEGER_16 is
		external
			"C (OCISvcCtx *, OCIError *, ub4): sword | %"oci.h%""
		alias
			"OCITransDetach"
		end

	oci_trans_commit (svchp: POINTER; errhp: POINTER; flags: INTEGER): INTEGER_16 is
		external
			"C (OCISvcCtx *, OCIError *, ub4): sword | %"oci.h%""
		alias
			"OCITransCommit"
		end

	oci_trans_rollback (svchp: POINTER; errhp: POINTER; flags: INTEGER): INTEGER_16 is
		external
			"C (OCISvcCtx *, OCIError *, ub4): sword | %"oci.h%""
		alias
			"OCITransRollback"
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




end -- class OCI_SERVICE_CONTEXT
