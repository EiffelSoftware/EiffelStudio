indexing
	description: "BSTR string for COM Interop"
	date: "$Date$"
	revision: "$Revision$"

class
	BSTR_STRING

inherit
	MEMORY
		redefine
			dispose
		end

create
	make_by_uni_string,
	make_by_pointer
	
feature {NONE} -- Initialization

	make_by_uni_string (astring: UNI_STRING) is
			-- creates new instance from a unistring
		require
			non_void_string: astring /= Void
		do
			item := c_get_bstr (astring.item)
		ensure
			string_created: item /= Void
		end
		
	make_by_pointer (p: POINTER) is
			-- create a BSTR from a pointer
		require
			non_void_pointer: p /= Void
		do
			item := p
		end
		
feature -- Access

	item: POINTER
		-- pointer to the BSTR string
		
feature -- Basic Oprtations

	string: STRING is
			-- return a STRING
		do
			Result := uni_string.string
		end
		
	uni_string: UNI_STRING is
			-- returns a UNI_STRING
		do
			create Result.make_by_pointer (item)
		end
		
feature -- Destruction

	dispose is
			-- free up used resources
		do
			c_free_bstr (item)
		end
		
feature {NONE} -- Implementation

	c_get_bstr (astring: POINTER): POINTER is
			-- returns a BSTR from a UNI_STRING
		external
			"C signature (EIF_POINTER): EIF_POINTER use %"OleAuto.h%""
		alias
			"SysAllocString"
		end
		
	c_free_bstr (abstr: POINTER) is
			-- frees a BSTR
		external
			"C signature (EIF_POINTER) use %"OleAuto.h%""
		alias
			"SysFreeString"
		end
		
end -- class ISE_COM_CACHE_MANAGER_INTERFACE
