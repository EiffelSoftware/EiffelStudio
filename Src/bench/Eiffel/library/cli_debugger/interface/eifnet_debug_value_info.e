indexing
	description: "Object used to get information on ICOR_DEBUG_VALUE"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUG_VALUE_INFO

inherit
	ICOR_EXPORTER
		export
			{NONE} all
		end
	
	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
		end

	SHARED_EIFNET_DEBUG_VALUE_FORMATTER
		export
			{NONE} all
		end

	SHARED_EIFNET_DEBUG_VALUE_FACTORY
		export
			{NONE} all
		end
		
	SHARED_EIFFEL_PROJECT		
		export
			{NONE} all
		end
		
create
	make, make_from_prepared_value
	
feature {NONE} -- Initialisation

	make (a_referenced_value: ICOR_DEBUG_VALUE) is
			-- Initialize `Current' with the referenced value
			-- this referenced is the value we got directly from the dotnet debugger
			-- with no processing on it.
		require
			argument_not_void: a_referenced_value /= Void
		do
			icd_referenced_value := a_referenced_value
			icd_prepared_value := Edv_formatter.prepared_debug_value (a_referenced_value)
			init
		end

	make_from_prepared_value (a_referenced_value: ICOR_DEBUG_VALUE; a_prepared_value: ICOR_DEBUG_VALUE) is
			-- Initialize `Current' from a prepared value
			-- a prepared value is an dereferenced, and unboxed dotnet value
		require
			argument_not_void: a_referenced_value /= Void and then a_prepared_value /= Void
		do
			icd_referenced_value := a_referenced_value
			icd_prepared_value := a_prepared_value
			init
		end
		
feature {NONE} -- Internal Initialisation

	init is
			-- Set the main information
		local
			l_type: INTEGER
		do
			if not error_occurred then
				referenced_address := icd_referenced_value.get_address
				object_address := icd_prepared_value.get_address					
				
--				if referenced_address = 0 then
-- FIXME jfiat: 20040316 : null address for non null object : Check this
-- why sometime the referenced value has null address but is not null !!!
-- so for now let's use the icd_prepared_value when it occurs ..
-- ANSWER: If the value is at least partly in registers, 
--         the address value is 0
--				end
				
				l_type := icd_prepared_value.get_type		

				is_reference_type := True			
				inspect l_type
				when
					feature {MD_SIGNATURE_CONSTANTS}.element_type_string
				then
					is_string_type := (l_type = feature {MD_SIGNATURE_CONSTANTS}.element_type_string)
				when
					feature {MD_SIGNATURE_CONSTANTS}.element_type_szarray,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_array
				then
					is_array_type := True
				when 
					feature {MD_SIGNATURE_CONSTANTS}.element_type_class,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_object,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_valuetype,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_byref
				then
					is_class := (l_type = feature {MD_SIGNATURE_CONSTANTS}.element_type_class)
					is_object := (l_type = feature {MD_SIGNATURE_CONSTANTS}.element_type_object)
					is_valuetype := (l_type =	feature {MD_SIGNATURE_CONSTANTS}.element_type_valuetype)
					is_byref := (l_type =	feature {MD_SIGNATURE_CONSTANTS}.element_type_byref)
				else
					is_reference_type := False
				end
				
				if is_reference_type and then interface_debug_reference_value /= Void then
					is_null := interface_debug_reference_value.is_null
				end

				if is_reference_type or else is_class or else is_valuetype or else is_object then
					has_object_interface := (interface_debug_object_value /= Void)
				end				
			end
		rescue
			error_occurred := True
			retry
		end

feature -- Access

	referenced_address: INTEGER_64
			-- Address of `icd_referenced_value'

	object_address: INTEGER_64
			-- Address of `icd_prepared_value'
			-- or physical address

feature -- Queries

	address_as_hex_string: STRING is
			-- hexadecimal representation for `address'
		do
			Result := "0x" + object_address.to_integer.to_hex_string
		end

	value_to_string: STRING is
			-- String output for the Current value
		do
			if is_string_type then
				Result := Edv_formatter.prepared_icor_debug_value_as_string (icd_prepared_value)
			else
				Result := Edv_formatter.prepared_icor_debug_value_to_string (icd_prepared_value)
			end
		end

feature -- Nature Reference

	is_null: BOOLEAN
			-- Is this object representing a NULL value ?

	has_object_interface: BOOLEAN
			-- In ICorDebugObjectValue interface supported ?

	is_array_type: BOOLEAN
			-- Is this object a ARRAY type value ?

	is_reference_type: BOOLEAN
			-- Is this object a reference type value ?

	is_basic_type: BOOLEAN
			-- Is this object a basic type value ?

	is_class: BOOLEAN
			-- Is this object a class type value ?

	is_object: BOOLEAN
			-- Is this object an object type value ?

	is_valuetype: BOOLEAN
			-- Is this object a valuetype value ?

	is_byref: BOOLEAN
			-- Is this object a byref value ?

	is_string_type: BOOLEAN
			-- Is this object a String type value ?

feature -- Queries

	eifnet_debug_value: EIFNET_ABSTRACT_DEBUG_VALUE is
			-- Debug value corresponding to dotnet debug value
		do
			Result := debug_value_from_prepared_icdv (icd_referenced_value, icd_prepared_value)
		end

	value_icd_class: ICOR_DEBUG_CLASS is
			-- ICOR_DEBUG_CLASS related to this Current value
		require
			has_object_interface: has_object_interface	
		local
		do
			Result := once_value_icd_class
			if Result = Void then
				Result := interface_debug_object_value.get_class
				once_value_icd_class := Result
			end
		end		
		
	value_class_type: CLASS_TYPE is
			-- CLASS_TYPE related to this Current value
		require
			has_object_interface: has_object_interface	
			value_module_file_name_valid: value_module_file_name /= Void
			value_class_token_valid: value_class_token > 0			
		do
			Result := once_value_class_type
			if Result = Void then
				if has_object_interface then
					Result := Il_debug_info_recorder.class_type_for_module_class_token (value_module_file_name, value_class_token)
				else
--				end
--				if Result = Void then
					Result := Eiffel_system.System.system_object_class.compiled_class.types.first
					--| FIXME jfiat 2004/03/29 : Any smarter way to find the real type ?
					-- even in case of external type ?
				end
				once_value_class_type := Result
			end
--		ensure
--			result_not_void: Result /= Void
		end
		
	value_class_c: CLASS_C is
			-- CLASS_C related to this Current value
		require
			has_object_interface: has_object_interface	
			value_module_file_name_valid: value_module_file_name /= Void
			value_class_token_valid: value_class_token > 0
		local
			ct: CLASS_TYPE
			an: STRING -- assembly name
			ci: CLASS_I
			ctok: INTEGER -- class token
			cn: STRING  -- class name
		do
			ct := value_class_type
			if ct /= Void then
				Result := ct.associated_class
			else
				ctok := value_class_token
				cn := value_icd_module.interface_md_import.get_typedef_props (ctok)
				an := value_icd_module.get_assembly.get_name
				an := only_file_name_without_extension (an)
					--| FIXME jfiat 2004/04/02 : maybe having 
					--| eiffel_universe.class_from_assembly_filename (...
				ci := eiffel_universe.class_from_assembly (an, cn)
				if ci = Void then
						-- FIXME JFIAT: Ugly .. but for now .. far enought
					ci := Eiffel_system.System.system_object_class
				end
				Result := ci.compiled_class
			end
		end
		
	only_file_name_without_extension (f: STRING): STRING is
			-- Return only the filename part of the absolute filename `f'
			-- Not very nice, but how could we do otherwise ?
		local
			pos: INTEGER
			sep: CHARACTER
		do
			sep := (create {OPERATING_ENVIRONMENT}).Directory_separator
			Result := f.twin
			pos := Result.last_index_of (sep, Result.count)
			if pos > 0 then
				Result := Result.substring (pos + 1, Result.count)
			end
			pos := Result.last_index_of ('.', Result.count)
			if pos > 0 then
				Result := Result.substring (1, pos - 1)
			end			
		end	

feature -- Queries on ICOR_DEBUG_OBJECT_VALUE

	value_class_token: INTEGER is
			-- Dotnet class token for this ICorDebugObjectValue value
		require
			has_object_interface
		do
			Result := value_icd_class.get_token
		end

	value_class_name: STRING is
			-- class name for this ICorDebugObjectValue value
		require
			has_object_interface
		local
			l_ct: INTEGER			
		do
			l_ct := value_class_token
			if il_debug_info_recorder.has_class_info_about_module_class_token (value_module_file_name, l_ct) then
				Result := Il_debug_info_recorder.class_name_for_class_token_and_module (l_ct, value_module_file_name)			
			else
				Result := value_icd_module.interface_md_import.get_typedef_props (l_ct)
			end
		end

	value_module_file_name: STRING is
			-- module filename for this ICorDebugObjectValue value
		require
			has_object_interface
		do
			Result := value_icd_module.get_name
		end
		
	value_icd_module: ICOR_DEBUG_MODULE is
			-- ICorDebugModule for this ICorDebugObjectValue value
		require
			has_object_interface
		do
			Result := once_value_icd_module
			if Result = Void then
				Result := value_icd_class.get_module
				once_value_icd_module := Result
			end
		end

feature -- Interface queries for feature

	feature_token_for_feature_name (a_feat_name: STRING): INTEGER is
			-- feature token for feature named by `a_feat_name'
		local
			l_feat_i: FEATURE_I
		do
			l_feat_i := value_class_c.feature_named (a_feat_name)
			if l_feat_i /= Void then
				Result := feature_token_for_feature (l_feat_i)
			end
		end
		
	feature_token_for_feature (a_feat_i: FEATURE_I): INTEGER is
			-- feature token for `a_feat_i'
		do
			Result := il_debug_info_recorder.feature_token_for_feat_and_class_type (a_feat_i, value_class_type)
		end	

feature -- Interface Access

	interface_debug_object_value: like once_interface_debug_object_value is
			-- ICorDebugObjectValue interface
		require
			valid_object_type: is_reference_type or else is_class or else is_object or else is_valuetype
		do
			Result := once_interface_debug_object_value
			if Result = Void then
				Result := icd_prepared_value.query_interface_icor_debug_object_value
				once_interface_debug_object_value := Result
			end
		end
		
	interface_debug_reference_value: like once_interface_debug_reference_value is
			-- ICorDebugReferenceValue interface
		require
			is_reference_type 
		do
			Result := once_interface_debug_reference_value
			if Result = Void then
				Result := icd_prepared_value.query_interface_icor_debug_reference_value
				once_interface_debug_reference_value := Result
			end
		end

	interface_debug_array_value: like once_interface_debug_array_value is
			-- ICorDebugArrayValue interface
		require
			is_array_type 
		do
			Result := once_interface_debug_array_value
			if Result = Void then
				Result := icd_prepared_value.query_interface_icor_debug_array_value
				once_interface_debug_array_value := Result
			end
		end

	interface_debug_string_value: like once_interface_debug_string_value is
			-- ICorDebugStringValue interface
		require
			is_string_type 
		do
			Result := once_interface_debug_string_value
			if Result = Void then
				Result := icd_prepared_value.query_interface_icor_debug_string_value
				once_interface_debug_string_value := Result
			end
		end

feature {NONE} -- Implementation		

	once_value_class_type: CLASS_TYPE
			-- Once per instance for `value_class_type'

	once_value_icd_class: ICOR_DEBUG_CLASS
			-- Once per instance for `value_icd_class'
			
	once_value_icd_module: ICOR_DEBUG_MODULE
			-- Once per instance for `value_icd_module'			
		
	once_interface_debug_object_value: ICOR_DEBUG_OBJECT_VALUE
			-- Once per instance for `interface_debug_object_value'

	once_interface_debug_reference_value: ICOR_DEBUG_REFERENCE_VALUE
			-- Once per instance for `interface_debug_reference_value'

	once_interface_debug_array_value: ICOR_DEBUG_ARRAY_VALUE
			-- Once per instance for `interface_debug_array_value'

	once_interface_debug_string_value: ICOR_DEBUG_STRING_VALUE
			-- Once per instance for `interface_debug_string_value'

	icd_referenced_value: ICOR_DEBUG_VALUE
			-- Object encapsulated by Current

	icd_prepared_value: ICOR_DEBUG_VALUE
			-- prepared Object encapsulated by Current

	error_occurred: BOOLEAN
			-- Did an error occurred ?

invariant

	icd_referenced_value_not_void : icd_referenced_value /= Void
	icd_prepared_value_not_void : icd_prepared_value /= Void
	
end -- class EIFNET_DEBUG_VALUE_INFO
