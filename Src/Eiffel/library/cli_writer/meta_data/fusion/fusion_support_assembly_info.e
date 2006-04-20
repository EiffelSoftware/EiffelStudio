indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class FUSION_SUPPORT_ASSEMBLY_INFO
