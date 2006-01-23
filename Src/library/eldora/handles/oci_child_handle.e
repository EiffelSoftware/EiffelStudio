indexing
	description: "Abstract OCI Child Handle, i.e. a handle for which OCI_ENVIRONMENT is parent"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_child_handle.e $"

deferred class
	OCI_CHILD_HANDLE
	
inherit
	OCI_HANDLE_ATTR

feature {NONE} -- Initialization

	make (parent: OCI_HANDLE; errh: OCI_ERROR_HANDLER) is
		require
			valid_parent: parent /= Void and parent.is_allocated
			valid_error_handler: valid_error_handle (errh)
		do
			allocate (parent)
			error_handler := errh
		ensure
			allocated: is_allocated
			error_handler_assigned: error_handler = errh
			not_external: not is_external
		end
		
	make_child_by_handle (value: POINTER; errh: OCI_ERROR_HANDLER) is
			-- Initialize using a pre-allocated OCI handle
		require
			valid_error_handler: valid_error_handle (errh)
		do
			make_by_handle (value)
			error_handler := errh
		ensure
			allocated: is_allocated
			definition: handle = value
			error_handler_assigned: error_handler = errh
			is_external: is_external
		end
	
feature -- Access

	environment: OCI_ENVIRONMENT is
			-- The environment handle
		local
			env_handle: POINTER
		do
			env_handle := pointer_attr (Oci_attr_env, error_handler)
			create Result.make_by_handle (env_handle)
		end

	error_handler: OCI_ERROR_HANDLER
		-- Error handler
	
feature -- Basic operations

	set_error_handler (errh: OCI_ERROR_HANDLER) is
			-- Set error handler
		require
			valid_error_handler: valid_error_handle (errh)
		do
			error_handler := errh
		ensure
			definition: error_handler = errh
		end

invariant
	valid_error_handler: valid_error_handle (error_handler)
		
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




end -- class OCI_CHILD_HANDLE
