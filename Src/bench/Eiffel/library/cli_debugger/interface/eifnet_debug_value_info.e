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
		
create
	make, make_from_prepared_value
	
feature {NONE} -- Initialisation

	make (a_referenced_value: ICOR_DEBUG_VALUE) is
			-- Initialize `Current'
		require
			argument_not_void: a_referenced_value /= Void
		do
			icd_referenced_value := a_referenced_value
			icd_prepared_value := Edv_formatter.prepared_debug_value (a_referenced_value)
			init
		end

	make_from_prepared_value (a_referenced_value: ICOR_DEBUG_VALUE; a_prepared_value: ICOR_DEBUG_VALUE) is
			-- Initialize `Current'
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
			if not error_occured then
				address := icd_prepared_value.get_address
				l_type := icd_prepared_value.get_type
				inspect l_type
				when
					feature {MD_SIGNATURE_CONSTANTS}.element_type_string
				then
					is_reference_type := True
					is_string_type := (l_type = feature {MD_SIGNATURE_CONSTANTS}.element_type_string)
				when
					feature {MD_SIGNATURE_CONSTANTS}.element_type_szarray,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_array
				then
--					is_special_type := True
					is_array_type := (l_type = feature {MD_SIGNATURE_CONSTANTS}.element_type_szarray)					
									or (l_type = feature {MD_SIGNATURE_CONSTANTS}.element_type_array)
				when 
					feature {MD_SIGNATURE_CONSTANTS}.element_type_class,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_object,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_valuetype,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_byref
				then
					is_reference_type := True
					is_class := (l_type = feature {MD_SIGNATURE_CONSTANTS}.element_type_class)
					is_object := (l_type = feature {MD_SIGNATURE_CONSTANTS}.element_type_object)
					is_valuetype := (l_type =	feature {MD_SIGNATURE_CONSTANTS}.element_type_valuetype)
					is_byref := (l_type =	feature {MD_SIGNATURE_CONSTANTS}.element_type_byref)
					if interface_debug_reference_value /= Void then
						is_null := interface_debug_reference_value.is_null
					end

					if is_reference_type or else is_class or else is_valuetype or else is_object then
						has_object_interface := (interface_debug_object_value /= Void)
					end
				else
					do_nothing
				end
			end
		rescue
			error_occured := True
			retry
		end

feature -- Access

	address: INTEGER_64
			-- Address of `icd_referenced_value'

feature -- Queries

	address_as_hex_string: STRING is
		do
			Result := "0x" + address.to_integer.to_hex_string
		end

	value_to_string: STRING is
			-- 	
		do
			if is_string_type then
				Result := Edv_formatter.prepared_icor_debug_value_as_string (icd_prepared_value)
			else
				Result := Edv_formatter.prepared_icor_debug_value_to_string (icd_prepared_value)
			end
		end

feature -- Nature Reference

	is_null: BOOLEAN

	has_object_interface: BOOLEAN

	is_array_type: BOOLEAN

	is_reference_type: BOOLEAN

	is_basic_type: BOOLEAN

--	is_special_type: BOOLEAN

	is_class: BOOLEAN

	is_object: BOOLEAN

	is_valuetype: BOOLEAN

	is_byref: BOOLEAN

	is_string_type: BOOLEAN


feature -- Queries

	eifnet_debug_value: EIFNET_ABSTRACT_DEBUG_VALUE is
		do
			Result := debug_value_from_prepared_icdv (icd_referenced_value, icd_prepared_value)
		end
		
	value_class_type: CLASS_TYPE is
			-- 
		require
			has_object_interface: has_object_interface	
			value_module_file_name_valid: value_module_file_name /= Void
			value_class_token_valid: value_class_token > 0			
		do
			if once_value_class_type = Void then
				if has_object_interface then
					once_value_class_type := Il_debug_info_recorder.class_type_for_module_class_token (value_module_file_name, value_class_token)			
				else
					once_value_class_type := eifnet_debug_value.dynamic_class.types.first 
--FIXME jfiat [02/01/2004]
-- 
				end	
			end
			Result := once_value_class_type
		end
	
feature -- Queries on ICOR_DEBUG_OBJECT_VALUE

	value_class_token: INTEGER is
		require
			has_object_interface
		do
			Result := interface_debug_object_value.get_class.get_token
		end

	value_class_name: STRING is
		require
			has_object_interface
		do
			if il_debug_info_recorder.has_class_info_about_module_class_token (value_module_file_name, value_class_token) then
				Result := Il_debug_info_recorder.class_name_for_class_token_and_module (value_class_token, value_module_file_name)			
			else
				Result := value_icd_module.interface_md_import.get_typedef_props (value_class_token)
			end
		end		

	value_module_file_name: STRING is
		require
			has_object_interface
		do
			Result := value_icd_module.get_name			
		end
		
	value_icd_module: ICOR_DEBUG_MODULE is
		require
			has_object_interface
		do
			Result := interface_debug_object_value.get_class.get_module			
		end

feature -- Interface queries for feature

	feature_token_for_feature_name (a_feat_name: STRING): INTEGER is
			-- feature token
		local
			l_class_type: CLASS_TYPE
			l_feat_i: FEATURE_I
		do
			l_class_type := value_class_type
			l_feat_i := l_class_type.associated_class.feature_named (a_feat_name)					
			if l_feat_i /= Void then
				Result := feature_token_for_feature (l_feat_i)
			end
		end
		
	feature_token_for_feature (a_feat_i: FEATURE_I): INTEGER is
			-- feature token
		do
			Result := il_debug_info_recorder.feature_token_for_feat_and_class_type (a_feat_i, value_class_type)
		end	

feature -- Interface Access

	interface_debug_object_value: like once_interface_debug_object_value is
		require
			valid_object_type: is_reference_type or else is_class or else is_object or else is_valuetype
		do
			if once_interface_debug_object_value /= Void then
				Result := once_interface_debug_object_value
			else
				Result := icd_prepared_value.query_interface_icor_debug_object_value
			end
		end
		
	interface_debug_reference_value: like once_interface_debug_reference_value is
		require
			is_reference_type 
		do
			if once_interface_debug_reference_value /= Void then
				Result := once_interface_debug_reference_value
			else
				Result := icd_prepared_value.query_interface_icor_debug_reference_value
			end
		end

	interface_debug_array_value: like once_interface_debug_array_value is
		require
			is_array_type 
		do
			if once_interface_debug_array_value /= Void then
				Result := once_interface_debug_array_value
			else
				Result := icd_prepared_value.query_interface_icor_debug_array_value
			end
		end

	interface_debug_string_value: like once_interface_debug_string_value is
		require
			is_string_type 
		do
			if once_interface_debug_string_value /= Void then
				Result := once_interface_debug_string_value
			else
				Result := icd_prepared_value.query_interface_icor_debug_string_value
			end
		end

feature {NONE} -- Implementation		

	once_value_class_type: CLASS_TYPE
		
	once_interface_debug_object_value: ICOR_DEBUG_OBJECT_VALUE

	once_interface_debug_reference_value: ICOR_DEBUG_REFERENCE_VALUE

	once_interface_debug_array_value: ICOR_DEBUG_ARRAY_VALUE

	once_interface_debug_string_value: ICOR_DEBUG_STRING_VALUE

	icd_referenced_value: ICOR_DEBUG_VALUE
			-- Object encapsulated by Current

	icd_prepared_value: ICOR_DEBUG_VALUE
			-- prepared Object encapsulated by Current

	error_occured: BOOLEAN

invariant

	icd_referenced_value_not_void : icd_referenced_value /= Void
	icd_prepared_value_not_void : icd_prepared_value /= Void
	
end -- class EIFNET_DEBUG_VALUE_INFO
