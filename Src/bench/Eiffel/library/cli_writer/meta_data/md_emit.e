indexing
	description: "Encapsulation of IMetaDataEmit defined in <cor.h>"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_EMIT

inherit
	COM_OBJECT
		redefine
			make_by_pointer
		end
		
create
	make_by_pointer

feature {NONE} -- Initialization

	make_by_pointer	(an_item: POINTER) is
			-- Initialize Current with `an_item'.
		do
			Precursor {COM_OBJECT} (an_item)
			
				-- Get associated IMetaDataAssemblyEmit object.
			create assembly_emitter.make_by_pointer (c_query_assembly_emit (item))
		end

feature -- Access

	save_size: INTEGER is
			-- Size of Current emitted assembly in memory if we were to emit it now.
		do
			last_call_success := c_get_save_size (item, accurate, $Result)
		ensure
			success: last_call_success = 0
			result_positive: Result >= 0
		end

feature -- Save

	assembly_memory: MANAGED_POINTER is
			-- Save Current into a MEMORY location.
			-- Allocated here and needs to be freed by caller.
		local
			l_size: INTEGER
		do
			l_size := save_size
			create Result.make (l_size)
			last_call_success := c_save_to_memory (item, Result.item, l_size)
		ensure
			success: last_call_success = 0
			valid_result: Result /= Void
		end
		
	save (f_name: UNI_STRING) is
			-- Save current assembly to file `f_name'.
		require
			f_name_not_void: f_name /= Void
		do
			last_call_success := c_save (item, f_name.item, 0)
		ensure
			success: last_call_success = 0
		end
		
feature -- Definition: access

	define_assembly_ref (assembly_name: UNI_STRING; assembly_info: MD_ASSEMBLY_INFO): INTEGER is
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_info_not_void: assembly_info /= Void
		do
			Result := assembly_emitter.define_assembly_ref (assembly_name, assembly_info)
		ensure
			valid_result: Result > 0
		end
		
	define_type_ref (type_name: UNI_STRING; resolution_scope: INTEGER): INTEGER is
			-- Compute new token for `type_name' located in `resolution_scope'.
		do
			last_call_success := c_define_type_ref_by_name (item, resolution_scope,
				type_name.item, $Result)
		ensure
			success: last_call_success = 0
		end

feature -- Definition: creation

	define_assembly (assembly_name: UNI_STRING; assembly_flags: INTEGER; assembly_info: MD_ASSEMBLY_INFO): INTEGER is
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_info_not_void: assembly_info /= Void
		do
			Result := assembly_emitter.define_assembly (assembly_name, assembly_flags,
				assembly_info)
		ensure
			valid_result: Result > 0
		end
		
	define_type (type_name: UNI_STRING; flags: INTEGER; extend_token: INTEGER;
			implements: ARRAY [INTEGER]): INTEGER
		is
			-- Create new type with name `type_name' and `flags' which inherits from
			-- base class `extend_token' and implements interfaces `implements'.
		require
			type_name_not_void: type_name /= Void
		local
			a: ANY	
		do
			if implements /= Void then
				a := implements.to_c
				last_call_success := c_define_type_def (item, type_name.item, flags,
					extend_token, $a, $Result)
			else
				last_call_success := c_define_type_def (item, type_name.item, flags,
					extend_token, default_pointer, $Result)
			end
		ensure
			success: last_call_success = 0
			result_valid: Result > 0
		end

	define_method (method_name: UNI_STRING; in_class_token: INTEGER;
			method_flags: INTEGER; signature: MD_SIGNATURE; impl_flags: INTEGER): INTEGER
		is
			-- Creat new methode in class `in_class_token'.
		require
			method_name_not_void: method_name /= Void
			signature_not_void: signature /= Void
		do
			last_call_success := c_define_method (item, in_class_token,
				method_name.item, method_flags, signature.item.item, signature.size,
				0, impl_flags, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result > 0
		end

feature -- Settings

	set_module_name (a_name: UNI_STRING) is
			-- Set name of current generated module to `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			last_call_success := c_set_module_props (item, a_name.item)
		ensure
			success: last_call_success = 0
		end

	set_method_rva (method_token, rva: INTEGER) is
			-- Set RVA of `method_token' to `rva'.
		do
			last_call_success := c_set_rva (item, method_token, rva)
		ensure
			success: last_call_success = 0
		end

feature -- Constants

	accurate: INTEGER is 0x0000
	quick: INTEGER is 0x0001
			-- Value taken from CorSaveSize enumeration in `correg.h'.

feature {NONE} -- Access

	assembly_emitter: MD_ASSEMBLY_EMIT
			-- COM interface that knows how to define assemblies.

feature {NONE} -- Implementation

	c_query_assembly_emit (an_item: POINTER): POINTER is
			-- Call `QueryInterface(IID_IMetaDataAssemblyEmit, (void **)&imda)' on `an_item'.
		external
			"C use %"cli_writer.h%""
		end

	c_set_module_props (an_item, name: POINTER): INTEGER is
			-- Call `IMetaDataEmit->SetModuleProps'.
		external
			"C++ IMetaDataEmit signature (LPCWSTR): EIF_INTEGER use <cor.h>"
		alias
			"SetModuleProps"
		end

	c_save (an_item, file_name: POINTER; save_flags: INTEGER): INTEGER is
			-- Call `IMetaDataEmit->Save'.
		external
			"C++ IMetaDataEmit signature (LPCWSTR, DWORD): EIF_INTEGER use <cor.h>"
		alias
			"Save"
		end

	c_save_to_memory (an_item, memory: POINTER; memory_length: INTEGER): INTEGER is
			-- Call `IMetaDataEmit->SaveToMemory'.
		external
			"C++ IMetaDataEmit signature (void *, ULONG): EIF_INTEGER use <cor.h>"
		alias
			"SaveToMemory"
		end

	c_save_to_stream (an_item, stream: POINTER; save_flags: INTEGER): INTEGER is
			-- Call `IMetaDataEmit->SaveToStream'.
		external
			"C++ IMetaDataEmit signature (IStream *, DWORD): EIF_INTEGER use <cor.h>"
		alias
			"SaveToStream"
		end

	c_get_save_size (an_item: POINTER; size_query: INTEGER; returned_size: POINTER): INTEGER is
			-- Call `IMetaDataEmit->SaveToStream'.
			-- If `size_query' equals 0, then accurate computation, if 1 quick computation.
		external
			"C++ IMetaDataEmit signature (CorSaveSize, DWORD *): EIF_INTEGER use <cor.h>"
		alias
			"GetSaveSize"
		end

	c_define_type_def (an_item, type_name: POINTER; type_flags: INTEGER; extend: INTEGER;
			implements: POINTER; type_def: POINTER): INTEGER
		is
			-- Call `IMetaDataEmit->DefineTypeDef'.
		external
			"C++ IMetaDataEmit signature (LPCWSTR, DWORD, mdToken, mdToken *, mdTypeDef *): EIF_INTEGER use <cor.h>"
		alias
			"DefineTypeDef"
		end

	c_define_type_ref_by_name (an_item: POINTER; scope: INTEGER; name: POINTER; type_token: POINTER): INTEGER is
			-- Call `IMetaDataEmit->DefineTypeRefByName'.
		external
			"C++ IMetaDataEmit signature (mdToken, LPCWSTR, mdTypeRef *): EIF_INTEGER use <cor.h>"
		alias
			"DefineTypeRefByName"
		end

	c_set_rva (an_item: POINTER; a_token, an_rva: INTEGER): INTEGER is
			-- Call `IMetaDataEmit->SetRVA'.
		external
			"C++ IMetaDataEmit signature (mdToken, ULONG): EIF_INTEGER use <cor.h>"
		alias
			"SetRVA"
		end

	c_define_method (an_item: POINTER; type_token: INTEGER; name: POINTER;
			flags: INTEGER; signature: POINTER; sig_length: INTEGER;
			code_rva: INTEGER; impl_flags: INTEGER; method_token: POINTER): INTEGER
		is
			-- Call `IMetaDataEmit->DefineMethod'.
		external
			"[
				C++ IMetaDataEmit signature
					(mdTypeDef, LPCWSTR, DWORD, PCCOR_SIGNATURE, ULONG,
					ULONG, DWORD, mdMethodDef *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefineMethod"
		end

end -- class MD_EMIT
