indexing
	description: "Wrapper for OCI Environment Handle"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_environment.e $"

class
	OCI_ENVIRONMENT

inherit
	OCI_HANDLE
	
	MEMORY
		rename
			free as free_object
		export
			{NONE} all
		undefine
		 	is_equal
		redefine
			dispose
		end
		
	EXCEPTIONS
		export
			{NONE} all
		undefine
		 	is_equal
		end
	
creation
	make, make_by_handle

feature {NONE} -- Initialization

	Default_error_buffer_size: INTEGER is 512
	
	make is
			-- Initialize OCI environment; raise an exception if an error is encountered.
		local
			status: INTEGER_16
			size: INTEGER
			temp_ptr: POINTER
			l_handle: like handle
			message: STRING
			error_code: INTEGER
		do
			status := oci_env_create ($l_handle, Oci_object | Oci_threaded, default_pointer, 
					default_pointer, default_pointer, default_pointer, 0, default_pointer)
			handle := l_handle
			is_allocated := status = Oci_success
			if status = Oci_error then
				size := Default_error_buffer_size
				temp_ptr := default_pointer.memory_alloc (size)
				status := oci_error_get (handle, 1, default_pointer, $error_code, temp_ptr, size, 
						handle_type)
				create message.make_from_c (temp_ptr)
				temp_ptr.memory_free
				raise (message)
			end
		ensure
			allocated: is_allocated
		end

feature -- Removal

	dispose is
			-- Ensure the OCI environment is destroyed when garbage collected.
		do
			if is_allocated and not is_external then
				free
			end
		end

feature {NONE} -- Implementation

	handle_type: INTEGER is
			-- Handle type
		do
			Result := Oci_htype_env
		end

feature {NONE} -- Externals

	oci_env_create (envhpp: POINTER; mode: INTEGER; ctxp: POINTER; malocfp: POINTER; 
			ralocfp: POINTER; mfreefp: POINTER; xtramemsz: INTEGER; usrmempp: POINTER): 
			INTEGER_16 is
		external
			"C (void **, int, void *, void *, void *, void *, int, void **): short | %"oci.h%""
		alias
			"OCIEnvCreate"
		end
		
end -- class OCI_ENV_HANDLE
