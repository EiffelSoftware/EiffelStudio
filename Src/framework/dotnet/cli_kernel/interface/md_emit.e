note
	description: "Summary description for {MD_EMIT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_EMIT

inherit
	MD_TOKEN_TYPES

feature -- Status report

	is_successful: BOOLEAN
			-- Was last call successful?	
		deferred
		end

	appending_to_file_supported: BOOLEAN
			-- Is `append_to_file` supported?
		deferred
		end

feature -- Access

	save_size: INTEGER
			-- Size of Current emitted assembly in memory if we were to emit it now.
		deferred
		ensure
			result_positive: Result >= 0
		end

feature -- Save

	prepare_to_save
			-- Prepare data to be save
		do
			-- To redefine if needed
		end

	save (f_name: CLI_STRING)
			-- Save current assembly to file `f_name'.
		require
			f_name_not_void: f_name /= Void
			f_name_not_empty: not f_name.is_empty
		deferred
		end

	append_to_file (f: FILE)
			-- Append current assembly to file `f`.
		require
			writable: f.is_open_write
			appending_to_file_supported
		deferred
		end

feature -- Definition: access

	define_assembly_ref (assembly_name: CLI_STRING; assembly_info: MD_ASSEMBLY_INFO;
			public_key_token: detachable MD_PUBLIC_KEY_TOKEN): INTEGER
			-- Get token reference on referenced assembly `assembly_name'.
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_name_not_empty: not assembly_name.is_empty
			assembly_info_not_void: assembly_info /= Void
		deferred
		ensure
			valid_result: Result > 0
		end

	define_type_ref (type_name: CLI_STRING; resolution_scope: INTEGER): INTEGER
			-- Compute new token for `type_name' located in `resolution_scope'.
		require
			type_name_not_void: type_name /= Void
			type_name_not_empty: not type_name.is_empty
			resolution_scope_valid:
				(resolution_scope = 0) or
				(resolution_scope & Md_mask = Md_module_ref) or
				(resolution_scope & Md_mask = Md_assembly_ref) or
				(resolution_scope & Md_mask = Md_type_ref)
		deferred
		ensure
			is_successful
			result_valid: Result & Md_mask = Md_type_ref
		end

	define_member_ref (method_name: CLI_STRING; in_class_token: INTEGER;
			a_signature: MD_SIGNATURE): INTEGER

			-- Create reference to member in class `in_class_token'.
		require
			method_name_not_void: method_name /= Void
			method_name_not_empty: not method_name.is_empty
			in_class_token_valid: in_class_token & Md_mask = Md_type_ref or
				in_class_token & Md_mask = Md_type_def or
				in_class_token & md_mask = md_type_spec
			signature_not_void: a_signature /= Void
		deferred
		ensure
			is_successful
			result_valid: Result & Md_mask = Md_member_ref
		end

	define_module_ref (a_name: CLI_STRING): INTEGER
			-- Define a reference to a module of name `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		deferred
		ensure
			is_successful
			result_valid: Result & Md_mask = Md_module_ref
		end

feature -- Definition: Creation

	define_assembly (assembly_name: CLI_STRING; assembly_flags: INTEGER;
			assembly_info: MD_ASSEMBLY_INFO; public_key: detachable MD_PUBLIC_KEY): INTEGER
			-- Add assembly metadata information to the metadata tables.
			--| the public key could be null.
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_name_not_empty: not assembly_name.is_empty
			assembly_info_not_void: assembly_info /= Void
			valid_flags: public_key /= Void implies assembly_flags &
				{MD_ASSEMBLY_FLAGS}.public_key = {MD_ASSEMBLY_FLAGS}.public_key
		deferred
		ensure
			valid_result: Result & Md_mask = Md_assembly
		end

	define_manifest_resource (resource_name: CLI_STRING; implementation_token: INTEGER;
			offset, resource_flags: INTEGER): INTEGER

			-- Define a new assembly.
		require
			resource_name_not_void: resource_name /= Void
			resource_name_not_empty: not resource_name.is_empty
			valid_flags:
				(resource_flags & {MD_RESOURCE_FLAGS}.public =
						{MD_RESOURCE_FLAGS}.public) or
				(resource_flags & {MD_RESOURCE_FLAGS}.private =
						{MD_RESOURCE_FLAGS}.private)
		deferred
		ensure
			valid_result: Result & Md_mask = Md_manifest_resource
		end

	define_type (type_name: CLI_STRING; flags: INTEGER; extend_token: INTEGER; implements: detachable ARRAY [INTEGER]): INTEGER
			-- Define a new type in the metadata.
		require
			type_name_not_void: type_name /= Void
			type_name_not_empty: not type_name.is_empty
			extend_token_valid:
				(extend_token & Md_mask = Md_type_def) or
				(extend_token & Md_mask = Md_type_ref) or
				(extend_token & Md_mask = Md_type_spec) or
				extend_token = 0
		deferred
		ensure
			is_successful
			result_valid: Result & Md_mask = Md_type_def
		end

	define_type_spec (a_signature: MD_TYPE_SIGNATURE): INTEGER
			-- Define a new token of TypeSpec for a type represented by `a_signature'.
			-- To be used to define different type for .NET arrays.
		require
			signature_not_void: a_signature /= Void
		deferred
		ensure
			is_successful
			result_valid: Result & Md_mask = Md_type_spec
		end

	define_exported_type (type_name: CLI_STRING; implementation_token: INTEGER;
			type_def_token: INTEGER; type_flags: INTEGER): INTEGER
			-- Create a row in ExportedType table.
		require
			type_name_not_void: type_name /= Void
			type_name_not_empty: not type_name.is_empty
			implementation_token_valid:
				(implementation_token & Md_mask = Md_file) or
				(implementation_token & Md_mask = md_assembly_ref) or
				(implementation_token & Md_mask = Md_exported_type)
			type_def_token_valid: type_def_token = 0 or (type_def_token & Md_mask = Md_type_def)
		deferred
		ensure
			valid_result: Result & Md_mask = Md_exported_type
		end

	define_file (file_name: CLI_STRING; hash_value: MANAGED_POINTER; file_flags: INTEGER): INTEGER
			-- Create a row in File table
		require
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.is_empty
			hash_value_not_void: hash_value /= Void
			hash_value_not_empty: hash_value.count > 0
			valid_file_flags:
				(file_flags = 0) or
				(file_flags = {MD_FILE_FLAGS}.has_no_meta_data)
		deferred
		ensure
			valid_result: Result & Md_mask = Md_file
		end

	define_method (method_name: CLI_STRING; in_class_token: INTEGER; method_flags: INTEGER;
			a_signature: MD_METHOD_SIGNATURE; impl_flags: INTEGER): INTEGER
			-- Create reference to method in class `in_class_token`.
		require
			method_name_not_void: method_name /= Void
			method_name_not_empty: not method_name.is_empty
			in_class_token_valid: in_class_token & Md_mask = Md_type_ref or
				in_class_token & Md_mask = Md_type_def or
				in_class_token & md_mask = md_type_spec
			signature_not_void: a_signature /= Void
		deferred
		ensure
			is_successful
			result_valid: Result & Md_mask = Md_method_def
		end

	define_method_impl (in_class_token, method_token, used_method_declaration_token: INTEGER)
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
		deferred
		ensure
			is_successful
		end

	define_property (type_token: INTEGER; name: CLI_STRING; flags: NATURAL_32;
			signature: MD_PROPERTY_SIGNATURE; setter_token: INTEGER; getter_token: INTEGER): INTEGER
			-- Define property `name' for a type `type_token'.
		require
			valid_type_token: type_token & Md_mask = Md_type_def
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			signature_not_void: signature /= Void
			signature_not_empty: signature.count > 0
			setter_token_valid: setter_token & Md_mask = Md_method_def
			getter_token_valid: getter_token & Md_mask = Md_method_def
		deferred
		ensure
			is_successful
		end

	define_pinvoke_map (method_token, mapping_flags: INTEGER;
			import_name: CLI_STRING; module_ref: INTEGER)

			-- Further specification of a pinvoke method location defined by `method_token'.
		require
			method_token_valid:
				(method_token & Md_mask = Md_field_def) or
				(method_token & Md_mask = Md_method_def)
			import_name_not_void: import_name /= Void
			import_name_not_empty: not import_name.is_empty
			module_ref_valid: module_ref & Md_mask = Md_module_ref
		deferred
		ensure
			is_successful
		end

	define_parameter (in_method_token: INTEGER; param_name: CLI_STRING;
			param_pos: INTEGER; param_flags: INTEGER): INTEGER

			-- Create a new parameter specification token for method `in_method_token'.
		require
			in_method_token_valid: in_method_token & Md_mask = Md_method_def
			param_name_not_void: param_name /= Void
			param_name_not_empty: not param_name.is_empty
			pos_valid: param_pos >= 0
		deferred
		ensure
			result_valid: Result & Md_mask = Md_param_def
		end

	set_field_marshal (a_token: INTEGER; a_native_type_sig: MD_NATIVE_TYPE_SIGNATURE)
			-- Set a particular marshaling for `a_token'. Limited to parameter token for the moment.
		require
			a_token_valid: a_token & Md_mask = md_param_def
			a_native_type_sig_not_void: a_native_type_sig /= Void
		deferred
		ensure
			is_successful
		end

	define_field (field_name: CLI_STRING; in_class_token: INTEGER; field_flags: INTEGER; a_signature: MD_FIELD_SIGNATURE): INTEGER
			-- Create a new field in class `in_class_token'.
		require
			field_name_not_void: field_name /= Void
			field_name_not_empty: not field_name.is_empty
			in_class_token_valid: in_class_token & Md_mask = Md_type_def
			signature_not_void: a_signature /= Void
		deferred
		ensure
			is_successful
			result_valid: Result & Md_mask = Md_field_def
		end

	define_signature (a_signature: MD_LOCAL_SIGNATURE): INTEGER
			-- Define a new token for `a_signature'. To be used only for
			-- local signature.
		require
			signature_not_void: a_signature /= Void
		deferred
		ensure
			is_successful
			result_valid: Result & Md_mask = Md_signature
		end

	define_string_constant (field_name: CLI_STRING; in_class_token: INTEGER;
			field_flags: INTEGER; a_string: STRING): INTEGER

			-- Create a new field in class `in_class_token'.
		require
			field_name_not_void: field_name /= Void
			field_name_not_empty: not field_name.is_empty
			in_class_token_valid: in_class_token & Md_mask = Md_type_def
			a_string_not_void: a_string /= Void
		deferred
		ensure
			is_successful
			result_valid: Result & Md_mask = Md_field_def
		end

	define_string (str: CLI_STRING): INTEGER
			-- Define a new token for `str'.
		require
			str_not_void: str /= Void
		deferred
		ensure
			is_successful
			result_valid: Result & Md_mask = Md_string
		end

	define_custom_attribute (owner, constructor: INTEGER; ca: MD_CUSTOM_ATTRIBUTE): INTEGER
			-- Define a new token for `ca' applied on token `owner' with using `constructor'
			-- as creation procedure.
		require
			owner_valid: (owner & Md_mask) /= Md_custom_attribute -- Any type of token except mdCustomAttribute is accepted.
			constructor_valid:
				(constructor & Md_mask = Md_member_ref) or
				(constructor & Md_mask = Md_method_def)
			ca_not_void_implies_not_empty: ca /= Void implies ca.count >= 4
		deferred
		ensure
			is_successful
			result_valid: Result & Md_mask = Md_custom_attribute
		end

feature -- Settings

	set_module_name (a_name: CLI_STRING)
			-- Set name of current generated module to `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		deferred
		ensure
			is_successful
		end

	set_method_rva (method_token, rva: INTEGER)
			-- Set RVA of `method_token' to `rva'.
		require
			method_token_valid: method_token & Md_mask = Md_method_def
			rvas_valid: rva >= 0
		deferred
		ensure
			is_successful
		end

end
