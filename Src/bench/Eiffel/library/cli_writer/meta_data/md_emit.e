indexing
	description: "Encapsulation of IMetaDataEmit defined in <cor.h>"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_EMIT

inherit
	COM_OBJECT
		export
			{DBG_WRITER} item
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

	define_assembly_ref (assembly_name: UNI_STRING; assembly_info: MD_ASSEMBLY_INFO;
			public_key_token: MD_PUBLIC_KEY_TOKEN): INTEGER is
			-- Get token reference on referenced assembly `assembly_name'.
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_info_not_void: assembly_info /= Void
		do
			Result := assembly_emitter.define_assembly_ref (assembly_name,
				assembly_info, public_key_token)
		ensure
			valid_result: Result > 0
		end
		
	define_type_ref (type_name: UNI_STRING; resolution_scope: INTEGER): INTEGER is
			-- Compute new token for `type_name' located in `resolution_scope'.
		do
			last_call_success := c_define_type_ref_by_name (item, resolution_scope,
				type_name.item, $Result)

			if last_call_success = feature {MD_ERRORS}.meta_s_duplicate then
				last_call_success := 0
			end
		ensure
			success: last_call_success = 0
		end

	define_member_ref (method_name: UNI_STRING; in_class_token: INTEGER;
			signature: MD_SIGNATURE): INTEGER
		is
			-- Create reference to member in class `in_class_token'.
		require
			method_name_not_void: method_name /= Void
			signature_not_void: signature /= Void
		do
			last_call_success := c_define_member_ref (item, in_class_token,
				method_name.item, signature.item.item, signature.count, $Result)

			if last_call_success = feature {MD_ERRORS}.meta_s_duplicate then
				last_call_success := 0
			end
		ensure
			success: last_call_success = 0
			result_valid: Result > 0
		end
		
	define_module_ref (name: UNI_STRING): INTEGER is
			-- Define a reference to a module of name `name'.
		do
			last_call_success := c_define_module_ref (item, name.item, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result > 0		
		end
		
feature -- Definition: creation

	define_assembly (assembly_name: UNI_STRING; assembly_flags:
			INTEGER; assembly_info: MD_ASSEMBLY_INFO; public_key: MD_PUBLIC_KEY): INTEGER
		is
			-- Define a new assembly.
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_info_not_void: assembly_info /= Void
			valid_flags: public_key /= Void implies assembly_flags &
				feature {MD_ASSEMBLY_FLAGS}.public_key = feature {MD_ASSEMBLY_FLAGS}.public_key
		do
			Result := assembly_emitter.define_assembly (assembly_name, assembly_flags,
				assembly_info, public_key)
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
			method_flags: INTEGER; signature: MD_METHOD_SIGNATURE;
			impl_flags: INTEGER): INTEGER
		is
			-- Create new method in class `in_class_token'.
		require
			method_name_not_void: method_name /= Void
			signature_not_void: signature /= Void
		do
			last_call_success := c_define_method (item, in_class_token,
				method_name.item, method_flags, signature.item.item, signature.count,
				0, impl_flags, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result > 0
		end

	define_method_impl (in_class_token, method_token, used_method_declaration_token: INTEGER) is
			-- Define a method impl from `used_method_declaration_token' from inherited
			-- class to method `method_token' defined in `in_class_tojen'.
		require
			valid_tokens: in_class_token /= 0 and method_token /= 0 and
				used_method_declaration_token /= 0
		do
			last_call_success := c_define_method_impl (item, in_class_token, method_token,
				used_method_declaration_token)
		ensure
			success: last_call_success = 0
		end
	
	define_pinvoke_map (method_token, mapping_flags: INTEGER;
			import_name: UNI_STRING; module_ref: INTEGER)
		is
			-- Further specification of a pinvoke method location defined by `method_token'.
		require
			import_name_not_void: import_name /= Void
		do
			last_call_success := c_define_pinvoke_map (item, method_token,
				mapping_flags, import_name.item, module_ref)
		ensure
			success: last_call_success = 0
		end
			
	define_parameter (in_method_token: INTEGER; param_name: UNI_STRING;
			param_pos: INTEGER; param_flags: INTEGER): INTEGER
		is
			-- Create a new parameter specification token for method `in_method_token'.
		require
			valid_in_method_token: in_method_token /= 0
			param_name_not_void: param_name /= Void
			valid_pos: param_pos >= 0
		do
			last_call_success := c_define_param (item, in_method_token, param_pos,
				param_name.item, param_flags, 0, default_pointer, 0, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result > 0
		end

	define_field (field_name: UNI_STRING; in_class_token: INTEGER;
			field_flags: INTEGER; signature: MD_FIELD_SIGNATURE): INTEGER
		is
			-- Create a new field in class `in_class_token'.
		require
			field_name_not_void: field_name /= Void
			signature_not_void: signature /= Void
		do
			last_call_success := c_define_field (item, in_class_token,
				field_name.item, field_flags, signature.item.item, signature.count,
				0, default_pointer, 0, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result > 0
		end

	define_signature (signature: MD_LOCAL_SIGNATURE): INTEGER is
			-- Define a new token for `signature'. To be used only for
			-- local signature.
		require
			signature_not_void: signature /= Void
		do
			last_call_success := c_define_signature (item, signature.item.item,
				signature.count, $Result)
			if last_call_success = feature {MD_ERRORS}.meta_s_duplicate then
				last_call_success := 0
			end
		ensure
			success: last_call_success = 0
			result_valid: Result > 0
		end

	define_string (str: UNI_STRING): INTEGER is
			-- Define a new token for `str'.
		require
			str_not_void: str /= Void
		do
			last_call_success := c_define_user_string (item, str.item, str.count, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result > 0
		end

	define_custom_attribute (owner, constructor: INTEGER; ca: MD_CUSTOM_ATTRIBUTE): INTEGER is
			-- Define a new token for `ca' applied on token `owner' with using `constructor'
			-- as creation procedure.
		require
			ca_not_void: ca /= Void
		do
			last_call_success := c_define_custom_attribute (item, owner, constructor,
				ca.item.item, ca.count, $Result)
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

	c_define_custom_attribute (an_item: POINTER; owner, constructor: INTEGER;
			blob: POINTER; blobl_len: INTEGER; ca_token: POINTER): INTEGER
		is
			-- Call `IMetaDataEmit->DefineCustomAttribute'.
		external
			"[
				C++ IMetaDataEmit signature
					(mdToken, mdToken, void *, ULONG, mdCustomAttribute *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefineCustomAttribute"
		end

	c_define_field (an_item: POINTER; type_token: INTEGER; name: POINTER;
			flags: INTEGER; signature: POINTER; sig_length: INTEGER;
			default_value_type: INTEGER; data: POINTER; data_length: INTEGER;
			method_token: POINTER): INTEGER
		is
			-- Call `IMetaDataEmit->DefineMethod'.
		external
			"[
				C++ IMetaDataEmit signature
					(mdTypeDef, LPCWSTR, DWORD, PCCOR_SIGNATURE, ULONG,
					DWORD, void *, ULONG, mdFieldDef *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefineField"
		end

	c_define_member_ref (an_item: POINTER; type_token: INTEGER; name: POINTER;
			signature: POINTER; sig_length: INTEGER; member_token: POINTER): INTEGER
		is
			-- Call `IMetaDataEmit->DefineMemberRef'.
		external
			"[
				C++ IMetaDataEmit signature
					(mdToken, LPCWSTR, PCCOR_SIGNATURE, ULONG,
					mdMemberRef *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefineMemberRef"
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

	c_define_method_impl (an_item: POINTER; in_type_token: INTEGER; method_token: INTEGER;
			used_method_declaration_token: INTEGER): INTEGER
		is
			-- Call `IMetaDataEmit->DefineMethodImpl'.
		external
			"C++ IMetaDataEmit signature (mdTypeDef, mdToken, mdToken): EIF_INTEGER use <cor.h>"
		alias
			"DefineMethodImpl"
		end

	c_define_module_ref (an_item: POINTER; module_name: POINTER;
			module_token: POINTER): INTEGER
		is
			-- Call `IMetaDataEmit->DefineModuleRef'.
		external
			"C++ IMetaDataEmit signature (LPCWSTR, mdModuleRef *): EIF_INTEGER use <cor.h>"
		alias
			"DefineModuleRef"
		end

	c_define_param (an_item: POINTER; meth_token: INTEGER; param_number: INTEGER;
			name: POINTER; flags: INTEGER; default_value_type: INTEGER;
			default_value_data: POINTER; default_value_data_length: INTEGER;
			param_token: POINTER): INTEGER
		is
			-- Call `IMetaDataEmit->DefineParam'.
		external
			"[
				C++ IMetaDataEmit signature
					(mdMethodDef, ULONG, LPCWSTR, DWORD, DWORD,
					void *, ULONG, mdParamDef *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefineParam"
		end

	c_define_pinvoke_map (an_item: POINTER; method_token, mapping_flags: INTEGER;
			import_name: POINTER; module_ref: INTEGER): INTEGER
		is
			-- Call `IMetaDataEmit->DefinePinvokeMap'.
		external
			"[
				C++ IMetaDataEmit signature (mdToken, DWORD, LPCWSTR, mdModuleRef): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefinePinvokeMap"
		end

	c_define_signature (an_item: POINTER; signature: POINTER;
			sig_length: INTEGER; sig_token: POINTER): INTEGER
		is
			-- Call `IMetaDataEmit->GetTokenFromSig'. See doc on unmanaged
			-- Metadata API to see why we call it `c_define_signature'.
		external
			"[
				C++ IMetaDataEmit signature (PCCOR_SIGNATURE, ULONG, mdSignature *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"GetTokenFromSig"
		end

	c_define_user_string (an_item: POINTER; string: POINTER;
			str_len: INTEGER; sig_token: POINTER): INTEGER
		is
			-- Call `IMetaDataEmit->DefineUserString'.
		external
			"[
				C++ IMetaDataEmit signature (LPCWSTR, ULONG, mdString *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefineUserString"
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

	c_get_save_size (an_item: POINTER; size_query: INTEGER; returned_size: POINTER): INTEGER is
			-- Call `IMetaDataEmit->SaveToStream'.
			-- If `size_query' equals 0, then accurate computation, if 1 quick computation.
		external
			"C++ IMetaDataEmit signature (CorSaveSize, DWORD *): EIF_INTEGER use <cor.h>"
		alias
			"GetSaveSize"
		end

	c_query_assembly_emit (an_item: POINTER): POINTER is
			-- Call `QueryInterface(IID_IMetaDataAssemblyEmit, (void **)&imda)' on `an_item'.
		external
			"C use %"cli_writer.h%""
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

	c_set_module_props (an_item, name: POINTER): INTEGER is
			-- Call `IMetaDataEmit->SetModuleProps'.
		external
			"C++ IMetaDataEmit signature (LPCWSTR): EIF_INTEGER use <cor.h>"
		alias
			"SetModuleProps"
		end

	c_set_rva (an_item: POINTER; a_token, an_rva: INTEGER): INTEGER is
			-- Call `IMetaDataEmit->SetRVA'.
		external
			"C++ IMetaDataEmit signature (mdToken, ULONG): EIF_INTEGER use <cor.h>"
		alias
			"SetRVA"
		end

end -- class MD_EMIT
