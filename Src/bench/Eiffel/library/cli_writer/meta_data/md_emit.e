indexing
	description: "Encapsulation of IMetaDataEmit defined in <cor.h>"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	MD_TOKEN_TYPES

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
			f_name_not_empty: not f_name.is_empty
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
			assembly_name_not_empty: not assembly_name.is_empty
			assembly_info_not_void: assembly_info /= Void
		do
			Result := assembly_emitter.define_assembly_ref (assembly_name,
				assembly_info, public_key_token)
		ensure
			valid_result: Result > 0
		end

	define_type_ref (type_name: UNI_STRING; resolution_scope: INTEGER): INTEGER is
			-- Compute new token for `type_name' located in `resolution_scope'.
		require
			type_name_not_void: type_name /= Void
			type_name_not_empty: not type_name.is_empty
			resolution_scope_valid:
				(resolution_scope = 0) or
				(resolution_scope & Md_mask = Md_module_ref) or
				(resolution_scope & Md_mask = Md_assembly_ref) or
				(resolution_scope & Md_mask = Md_type_ref)
		do
			last_call_success := c_define_type_ref_by_name (item, resolution_scope,
				type_name.item, $Result)

			if last_call_success = {MD_ERRORS}.meta_s_duplicate then
				last_call_success := 0
			end
		ensure
			success: last_call_success = 0
			result_valid: Result & Md_mask = Md_type_ref
		end

	define_member_ref (method_name: UNI_STRING; in_class_token: INTEGER;
			a_signature: MD_SIGNATURE): INTEGER
		is
			-- Create reference to member in class `in_class_token'.
		require
			method_name_not_void: method_name /= Void
			method_name_not_empty: not method_name.is_empty
			in_class_token_valid: in_class_token & Md_mask = Md_type_ref or
				in_class_token & Md_mask = Md_type_def
			signature_not_void: a_signature /= Void
		do
			last_call_success := c_define_member_ref (item, in_class_token,
				method_name.item, a_signature.item.item, a_signature.count, $Result)

			if last_call_success = {MD_ERRORS}.meta_s_duplicate then
				last_call_success := 0
			end
		ensure
			success: last_call_success = 0
			result_valid: Result & Md_mask = Md_member_ref
		end

	define_module_ref (a_name: UNI_STRING): INTEGER is
			-- Define a reference to a module of name `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			last_call_success := c_define_module_ref (item, a_name.item, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result & Md_mask = Md_module_ref
		end

feature -- Definition: creation

	define_assembly (assembly_name: UNI_STRING; assembly_flags: INTEGER;
			assembly_info: MD_ASSEMBLY_INFO; public_key: MD_PUBLIC_KEY): INTEGER
		is
			-- Define a new assembly.
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_name_not_empty: not assembly_name.is_empty
			assembly_info_not_void: assembly_info /= Void
			valid_flags: public_key /= Void implies assembly_flags &
				{MD_ASSEMBLY_FLAGS}.public_key = {MD_ASSEMBLY_FLAGS}.public_key
		do
			Result := assembly_emitter.define_assembly (assembly_name, assembly_flags,
				assembly_info, public_key)
		ensure
			valid_result: Result & Md_mask = Md_assembly
		end

	define_manifest_resource (resource_name: UNI_STRING; implementation_token: INTEGER;
			offset, resource_flags: INTEGER): INTEGER
		is
			-- Define a new assembly.
		require
			resource_name_not_void: resource_name /= Void
			resource_name_not_empty: not resource_name.is_empty
			valid_flags:
				(resource_flags & {MD_RESOURCE_FLAGS}.public =
					{MD_RESOURCE_FLAGS}.public) or
				(resource_flags & {MD_RESOURCE_FLAGS}.private =
					{MD_RESOURCE_FLAGS}.private)
		do
			Result := assembly_emitter.define_manifest_resource (resource_name,
				implementation_token, offset, resource_flags)
		ensure
			valid_result: Result & Md_mask = Md_manifest_resource
		end

	define_type (type_name: UNI_STRING; flags: INTEGER; extend_token: INTEGER;
			implements: ARRAY [INTEGER]): INTEGER
		is
			-- Create new type with name `type_name' and `flags' which inherits from
			-- base class `extend_token' and implements interfaces `implements'.
		require
			type_name_not_void: type_name /= Void
			type_name_not_empty: not type_name.is_empty
			extend_token_valid:
				(extend_token & Md_mask = Md_type_def) or
				(extend_token & Md_mask = Md_type_ref) or
				(extend_token & Md_mask = Md_type_spec) or
				extend_token = 0
			--implements_valid: for_all (implemements.item (i) is a Md_type_def, Md_type_ref
			--	or Md_type_spec.
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
			result_valid: Result & Md_mask = Md_type_def
		end

	define_type_spec (a_signature: MD_TYPE_SIGNATURE): INTEGER is
			-- Define a new token of TypeSpec for a type represented by `a_signature'.
			-- To be used to define different type for .NET arrays.
		require
			signature_not_void: a_signature /= Void
		do
			last_call_success := c_define_type_spec (item, a_signature.item.item,
				a_signature.count, $Result)
			if last_call_success = {MD_ERRORS}.meta_s_duplicate then
				last_call_success := 0
			end
		ensure
			success: last_call_success = 0
			result_valid: Result & Md_mask = Md_type_spec
		end

	define_exported_type (type_name: UNI_STRING; implementation_token: INTEGER;
			type_def_token: INTEGER; type_flags: INTEGER): INTEGER
		is
				-- Create a row in ExportedType table.
		require
			type_name_not_void: type_name /= Void
			type_name_not_empty: not type_name.is_empty
			implementation_token_valid:
				(implementation_token & Md_mask = Md_file) or
				(implementation_token & Md_mask = Md_exported_type)
			type_def_token_valid: type_def_token = 0 or (type_def_token & Md_mask = Md_type_def)
		do
			Result := assembly_emitter.define_exported_type (type_name, implementation_token,
				type_def_token, type_flags)
		ensure
			valid_result: Result & Md_mask = Md_exported_type
		end

	define_file (file_name: UNI_STRING; hash_value: MANAGED_POINTER; file_flags: INTEGER): INTEGER is
			-- Create a row in File table
		require
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.is_empty
			hash_value_not_void: hash_value /= Void
			hash_value_not_empty: hash_value.count > 0
			valid_file_flags:
				(file_flags = 0) or
				(file_flags = {MD_FILE_FLAGS}.has_no_meta_data)
		do
			Result := assembly_emitter.define_file (file_name, hash_value, file_flags)
		ensure
			valid_result: Result & Md_mask = Md_file
		end

	define_method (method_name: UNI_STRING; in_class_token: INTEGER;
			method_flags: INTEGER; a_signature: MD_METHOD_SIGNATURE;
			impl_flags: INTEGER): INTEGER
		is
			-- Create new method in class `in_class_token'.
		require
			method_name_not_void: method_name /= Void
			method_name_not_void: not method_name.is_empty
			in_class_token_valid: in_class_token & Md_mask = Md_type_def
			signature_not_void: a_signature /= Void
		do
			last_call_success := c_define_method (item, in_class_token,
				method_name.item, method_flags, a_signature.item.item, a_signature.count,
				0, impl_flags, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result & Md_mask = Md_method_def
		end

	define_method_impl (in_class_token, method_token, used_method_declaration_token: INTEGER) is
			-- Define a method impl from `used_method_declaration_token' from inherited
			-- class to method `method_token' defined in `in_class_token'.
		require
			in_class_token_valid: in_class_token & Md_mask = Md_type_def
			method_token_valid:
				(method_token & Md_mask = Md_method_def) or
				(method_token & Md_mask = Md_member_ref)
			used_method_declaration_token_valid:
				(used_method_declaration_token & Md_mask = Md_method_def) or
				(used_method_declaration_token & Md_mask = Md_member_ref)
		do
			last_call_success := c_define_method_impl (item, in_class_token, method_token,
				used_method_declaration_token)
		ensure
			success: last_call_success = 0
		end

	define_property (type_token: INTEGER; name: UNI_STRING; flags: NATURAL_32;
			signature: MD_PROPERTY_SIGNATURE; setter_token: INTEGER; getter_token: INTEGER): INTEGER
		is
			-- Define property `name' for a type `type_token'.
		require
			valid_type_token: type_token & Md_mask = Md_type_def
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			signature_not_void: signature /= Void
			signature_not_empty: signature.count > 0
			setter_token_valid: setter_token & Md_mask = Md_method_def
			getter_token_valid: getter_token & Md_mask = Md_method_def
		local
			property_token: NATURAL_32
		do
			last_call_success := c_define_property (item,
				type_token, name.item, flags, signature.item.item, signature.count,
				0, default_pointer, 0, setter_token, getter_token, default_pointer,
				$property_token)
			Result := property_token.as_integer_32
		ensure
			success: last_call_success = 0
		end

	define_pinvoke_map (method_token, mapping_flags: INTEGER;
			import_name: UNI_STRING; module_ref: INTEGER)
		is
			-- Further specification of a pinvoke method location defined by `method_token'.
		require
			method_token_valid:
				(method_token & Md_mask = Md_field_def) or
				(method_token & Md_mask = Md_method_def)
			import_name_not_void: import_name /= Void
			import_name_not_empty: not import_name.is_empty
			module_ref_valid: module_ref & Md_mask = Md_module_ref
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
			in_method_token_valid: in_method_token & Md_mask = Md_method_def
			param_name_not_void: param_name /= Void
			param_name_not_empty: not param_name.is_empty
			pos_valid: param_pos >= 0
		do
			last_call_success := c_define_param (item, in_method_token, param_pos,
				param_name.item, param_flags, 0, default_pointer, 0, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result & Md_mask = Md_param_def
		end

	set_field_marshal (a_token: INTEGER; a_native_type_sig: MD_NATIVE_TYPE_SIGNATURE) is
			-- Set a particular marshaling for `a_token'. Limited to parameter token for the moment.
		require
			a_token_valid: a_token & Md_mask = md_param_def
			a_native_type_sig_not_void: a_native_type_sig /= Void
		do
			last_call_success := c_set_field_marshal (item, a_token,
				a_native_type_sig.item.item, a_native_type_sig.count)
		ensure
			success: last_call_success = 0
		end

	define_field (field_name: UNI_STRING; in_class_token: INTEGER;
			field_flags: INTEGER; a_signature: MD_FIELD_SIGNATURE): INTEGER
		is
			-- Create a new field in class `in_class_token'.
		require
			field_name_not_void: field_name /= Void
			field_name_not_empty: not field_name.is_empty
			in_class_token_valid: in_class_token & Md_mask = Md_type_def
			signature_not_void: a_signature /= Void
		do
			last_call_success := c_define_field (item, in_class_token,
				field_name.item, field_flags, a_signature.item.item, a_signature.count,
				{MD_SIGNATURE_CONSTANTS}.element_type_end, default_pointer, 0, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result & Md_mask = Md_field_def
		end

	define_integer_constant (field_name: UNI_STRING; in_class_token: INTEGER;
			field_flags: INTEGER; a_value: INTEGER_CONSTANT): INTEGER
		is
			-- Create a new field in class `in_class_token'.
		require
			field_name_not_void: field_name /= Void
			field_name_not_empty: not field_name.is_empty
			in_class_token_valid: in_class_token & Md_mask = Md_type_def
			a_value_not_void: a_value /= Void
		local
			l_field_signature: MD_FIELD_SIGNATURE
			l_constant_type: INTEGER_8
			l_i1: INTEGER_8
			l_i2: INTEGER_16
			l_i4: INTEGER
			l_i8: INTEGER_64
			l_u1: NATURAL_8
			l_u2: NATURAL_16
			l_u4: NATURAL_32
			l_u8: NATURAL_64
			l_ptr: POINTER
			l_size: INTEGER_8
		do
			l_constant_type := a_value.il_element_type
			inspect l_constant_type
			when {MD_SIGNATURE_CONSTANTS}.element_type_i1 then
				l_size := 1
				l_i1 := a_value.integer_8_value
				l_ptr := $l_i1
			when {MD_SIGNATURE_CONSTANTS}.element_type_i2 then
				l_size := 2
				l_i2 := a_value.integer_16_value
				l_ptr := $l_i2
			when {MD_SIGNATURE_CONSTANTS}.element_type_i4 then
				l_size := 4
				l_i4 := a_value.integer_32_value
				l_ptr := $l_i4
			when {MD_SIGNATURE_CONSTANTS}.element_type_i8 then
				l_size := 8
				l_i8 := a_value.integer_64_value
				l_ptr := $l_i8
			when {MD_SIGNATURE_CONSTANTS}.element_type_u1 then
				l_size := 1
				l_u1 := a_value.natural_8_value
				l_ptr := $l_u1
			when {MD_SIGNATURE_CONSTANTS}.element_type_u2 then
				l_size := 2
				l_u2 := a_value.natural_16_value
				l_ptr := $l_u2
			when {MD_SIGNATURE_CONSTANTS}.element_type_u4 then
				l_size := 4
				l_u4 := a_value.natural_32_value
				l_ptr := $l_u4
			when {MD_SIGNATURE_CONSTANTS}.element_type_u8 then
				l_size := 8
				l_u8 := a_value.natural_64_value
				l_ptr := $l_u8
			end
			create l_field_signature.make
			l_field_signature.set_type (l_constant_type, 0)
			last_call_success := c_define_field (item, in_class_token,
				field_name.item, field_flags, l_field_signature.item.item, l_field_signature.count,
				l_constant_type, l_ptr, l_size, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result & Md_mask = Md_field_def
		end

	define_string_constant (field_name: UNI_STRING; in_class_token: INTEGER;
			field_flags: INTEGER; a_string: STRING): INTEGER
		is
			-- Create a new field in class `in_class_token'.
		require
			field_name_not_void: field_name /= Void
			field_name_not_empty: not field_name.is_empty
			in_class_token_valid: in_class_token & Md_mask = Md_type_def
			a_string_not_void: a_string /= Void
		local
			l_field_signature: MD_FIELD_SIGNATURE
			l_uni_str: UNI_STRING
		do
			create l_field_signature.make
			create l_uni_str.make (a_string)
			l_field_signature.set_type ({MD_SIGNATURE_CONSTANTS}.element_type_string, 0)
			last_call_success := c_define_field (item, in_class_token,
				field_name.item, field_flags, l_field_signature.item.item, l_field_signature.count,
				{MD_SIGNATURE_CONSTANTS}.element_type_string, l_uni_str.item, l_uni_str.count, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result & Md_mask = Md_field_def
		end

	define_signature (a_signature: MD_LOCAL_SIGNATURE): INTEGER is
			-- Define a new token for `a_signature'. To be used only for
			-- local signature.
		require
			signature_not_void: a_signature /= Void
		do
			last_call_success := c_define_signature (item, a_signature.item.item,
				a_signature.count, $Result)
			if last_call_success = {MD_ERRORS}.meta_s_duplicate then
				last_call_success := 0
			end
		ensure
			success: last_call_success = 0
			result_valid: Result & Md_mask = Md_signature
		end

	define_string (str: UNI_STRING): INTEGER is
			-- Define a new token for `str'.
		require
			str_not_void: str /= Void
		do
			last_call_success := c_define_user_string (item, str.item, str.count, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result & Md_mask = Md_string
		end

	define_custom_attribute (owner, constructor: INTEGER; ca: MD_CUSTOM_ATTRIBUTE): INTEGER is
			-- Define a new token for `ca' applied on token `owner' with using `constructor'
			-- as creation procedure.
		require
			owner_valid: (owner & Md_mask) /= Md_custom_attribute -- Any type of token except mdCustomAttribute is accepted.
			constructor_valid:
				(constructor & Md_mask = Md_member_ref) or
				(constructor & Md_mask = Md_method_def)
			ca_not_void_implies_not_empty: ca /= Void implies ca.count >= 4
		local
			blob: POINTER
			blob_count: INTEGER
		do
			if ca /= Void then
				blob := ca.item.item
				blob_count := ca.count
			end
			last_call_success := c_define_custom_attribute (item, owner, constructor,
				blob, blob_count, $Result)
		ensure
			success: last_call_success = 0
			result_valid: Result & Md_mask = Md_custom_attribute
		end

feature -- Settings

	set_module_name (a_name: UNI_STRING) is
			-- Set name of current generated module to `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			last_call_success := c_set_module_props (item, a_name.item)
		ensure
			success: last_call_success = 0
		end

	set_method_rva (method_token, rva: INTEGER) is
			-- Set RVA of `method_token' to `rva'.
		require
			method_token_valid: method_token & Md_mask = Md_method_def
			rvas_valid: rva >= 0
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
			flags: INTEGER; a_signature: POINTER; sig_length: INTEGER;
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

	c_set_field_marshal (an_item: POINTER; a_token: INTEGER; a_signature: POINTER;
			a_sig_length: INTEGER): INTEGER
		is
			-- Call `IMetaDataEmit->SetFieldMarshal'.
		external
			"[
				C++ IMetaDataEmit signature
					(mdToken, PCCOR_SIGNATURE, ULONG): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"SetFieldMarshal"
		end

	c_define_member_ref (an_item: POINTER; type_token: INTEGER; name: POINTER;
			a_signature: POINTER; sig_length: INTEGER; member_token: POINTER): INTEGER
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
			flags: INTEGER; a_signature: POINTER; sig_length: INTEGER;
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

	c_define_property (an_item: POINTER; td: INTEGER; wzProperty: POINTER;
			dwPropFlags: NATURAL_32; pvSig: POINTER; cbSig: INTEGER;
			dwDefType: NATURAL_32; pValue: POINTER; cchValue: NATURAL_32;
			mdSetter: INTEGER; mdGetter: INTEGER; rmdOtherMethods: POINTER;
			pmdProp: POINTER): INTEGER
		is
			-- Call `IMetaDataEmit->DefineProperty'.
		external
			"[
				C++ IMetaDataEmit signature
					(mdTypeDef, LPCWSTR, DWORD, PCCOR_SIGNATURE, ULONG, DWORD,
					void *, ULONG, mdMethodDef, mdMethodDef, mdMethodDef *, mdProperty *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefineProperty"
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

	c_define_type_spec (an_item: POINTER; a_signature: POINTER;
			sig_length: INTEGER; sig_token: POINTER): INTEGER
		is
			-- Call `IMetaDataEmit->GetTokenFromTypeSpec'. See doc on unmanaged
			-- Metadata API to see why we call it `c_define_type_spec'.
		external
			"[
				C++ IMetaDataEmit signature (PCCOR_SIGNATURE, ULONG, mdTypeSpec *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"GetTokenFromTypeSpec"
		end

	c_define_signature (an_item: POINTER; a_signature: POINTER;
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class MD_EMIT
