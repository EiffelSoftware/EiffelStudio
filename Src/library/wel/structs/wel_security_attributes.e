indexing
	description: "SECURITY_ATTRIBUTES structure wrapper"
	
class
	WEL_SECURITY_ATTRIBUTES

inherit
	WEL_STRUCTURE
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize structure.
		do
			Precursor
			cwel_security_attributes_set_length (item, structure_size)
			cwel_security_attributes_set_security_descriptor (item, default_pointer)
		end

feature -- Access

	is_handle_inherited: BOOLEAN is
			-- Is returned handle inherited when new process is created?
		do
			Result := cwel_security_attributes_get_inherit_handle (item)
		end

feature -- Element Change

	set_inherit_handle (a_boolean: like is_handle_inherited) is
			-- Set `inherit_handle' with `a_boolean'.
		do
			cwel_security_attributes_set_inherit_handle (item, a_boolean)
		ensure
			inherit_handle_set: is_handle_inherited = a_boolean
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		do
			Result := cwin_size_of_security_attributes
		end

feature {NONE} -- External

	cwin_size_of_security_attributes: INTEGER is
		external
			"C [macro %"wel_security_attributes.h%"]: EIF_INTEGER"
		alias
			"sizeof (SECURITY_ATTRIBUTES)"
		end
		
	cwel_security_attributes_set_length (a_ptr: POINTER; a_length: INTEGER) is
		external
			"C [macro %"wel_security_attributes.h%"] (LPSECURITY_ATTRIBUTES, DWORD)"
		end
		
	cwel_security_attributes_set_security_descriptor (a_ptr: POINTER; a_descriptor: POINTER) is
		external
			"C [macro %"wel_security_attributes.h%"] (LPSECURITY_ATTRIBUTES, LPVOID)"
		end
		
	cwel_security_attributes_get_inherit_handle (a_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"wel_security_attributes.h%"] (LPSECURITY_ATTRIBUTES): EIF_BOOLEAN"
		end
		
	cwel_security_attributes_set_inherit_handle (a_ptr: POINTER; a_boolean:BOOLEAN) is
		external
			"C [macro %"wel_security_attributes.h%"] (LPSECURITY_ATTRIBUTES, BOOL)"
		end
		
end -- class WEL_SECURITY_ATTRIBUTES
