indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FUSION_SUPPORT_ASSEMBLY_INFO

inherit
	COM_OBJECT
		
create
	make_by_pointer
	
feature -- Access

	name: STRING is
		-- Assembly name
		local
			a_ptr: POINTER
		do
			last_call_success := (c_name (item, $a_ptr))
			create uni_string.make_by_pointer (a_ptr)
			--a_ptr.memory_free
			Result := uni_string.string
		end
		
	version: STRING is
		-- Assembly version
		local
			a_ptr: POINTER
		do
			last_call_success := (c_version (item, $a_ptr))
			create uni_string.make_by_pointer (a_ptr)
			--a_ptr.memory_free
			Result := uni_string.string
		end
		
	culture: STRING is
		-- Assembly culture
		local
			a_ptr: POINTER
		do
			last_call_success := (c_culture (item, $a_ptr))
			create uni_string.make_by_pointer (a_ptr)
			--a_ptr.memory_free
			Result := uni_string.string
		end
		
	public_key_token: STRING is
		-- Assembly public key token
		local
			a_ptr: POINTER
		do
			last_call_success := (c_public_key_token (item, $a_ptr))
			create uni_string.make_by_pointer (a_ptr)
			--a_ptr.memory_free
			Result := uni_string.string
		end
		
feature {NONE} -- Internal
		
	uni_string: UNI_STRING
		
feature {NONE} -- Implementation

	c_name (p, a_name: POINTER): INTEGER is
			-- Call `IAssemblyInfo->assembly_name'.
		external
			"C++ IAssemblyInfo signature (LPWSTR *): EIF_INTEGER use %"ise_vs_fusion_support.h%""
		alias
			"get_AssemblyName"
		end
		
	c_version (p, a_version: POINTER): INTEGER is
			-- Call `IAssemblyInfo->assembly_version ((IUnknown **) &iai)'.
		external
			"C++ IAssemblyInfo signature (LPWSTR *): EIF_INTEGER use %"ise_vs_fusion_support.h%""
		alias
			"get_Version"
		end
		
	c_culture (p, a_culture: POINTER): INTEGER is
			-- Call `IAssemblyInfo->assembly_culture'.
		external
			"C++ IAssemblyInfo signature (LPWSTR *): EIF_INTEGER use %"ise_vs_fusion_support.h%""
		alias
			"get_Culture"
		end
		
	c_public_key_token (p, a_public_key_token: POINTER): INTEGER is
			-- Call `IAssemblyInfo->assembly_public_key_token'.
		external
			"C++ IAssemblyInfo signature (LPWSTR *): EIF_INTEGER use %"ise_vs_fusion_support.h%""
		alias
			"get_PublicKeyToken"
		end

end -- class FUSION_SUPPORT_ASSEMBLY_INFO
