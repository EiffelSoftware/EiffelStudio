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
			
create
	make
	
feature {NONE} -- Initialisation

	make (a_icd: ICOR_DEBUG_VALUE) is
			-- Initialize `Current'
		require
			argument_not_void: a_icd /= Void
		do
			icor_debug_value := a_icd
			prepared_icor_debug_value := Debug_value_formatter.prepared_debug_value (icor_debug_value)
			if not Debug_value_formatter.last_strip_references_call_succeed then
				print ("ERROR dereferencing ... %N")
			end
			init
		end

	init is
			-- Set the main information
		do
			if not is_error then
				type := prepared_icor_debug_value.get_type
				address := prepared_icor_debug_value.get_address

				inspect type
				when feature {MD_SIGNATURE_CONSTANTS}.Element_type_char then
					is_character_type := True	
				when
					feature {MD_SIGNATURE_CONSTANTS}.element_type_string
				then
					is_reference_type := True
					is_string := (type = feature {MD_SIGNATURE_CONSTANTS}.element_type_string)
				when
					feature {MD_SIGNATURE_CONSTANTS}.element_type_szarray,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_array
				then
					is_special_type := True
					is_array_type := (type = feature {MD_SIGNATURE_CONSTANTS}.element_type_szarray)					
									or (type = feature {MD_SIGNATURE_CONSTANTS}.element_type_array)
				when 
					feature {MD_SIGNATURE_CONSTANTS}.element_type_class,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_object,
					feature {MD_SIGNATURE_CONSTANTS}.element_type_valuetype
				then
					is_reference_type := True
					is_class := (type = feature {MD_SIGNATURE_CONSTANTS}.element_type_class)
					is_object := (type = feature {MD_SIGNATURE_CONSTANTS}.element_type_class)
					is_valuetype := (type =	feature {MD_SIGNATURE_CONSTANTS}.element_type_valuetype)
					if interface_debug_reference_value /= Void then
						is_null := interface_debug_reference_value.is_null
					end

					if is_reference_type or else is_class or else is_valuetype or else is_object then
						is_object_interface := (interface_debug_object_value /= Void)
					end
				end
			end
		rescue
			is_error := True
			retry
		end

feature -- Error

	is_error: BOOLEAN

feature -- Access

	type: INTEGER
			-- Dotnet type of `icor_debug_value'

	address: INTEGER_64
			-- Address of `icor_debug_value'

	size: INTEGER
			-- Size of `icor_debug_value'

feature -- Properties

--	value: EIFNET_DEBUG_VALUE

feature -- Nature Reference

	is_null: BOOLEAN

	is_array_type: BOOLEAN

	is_reference_type: BOOLEAN

	is_basic_type: BOOLEAN

	is_special_type: BOOLEAN

	is_class: BOOLEAN

	is_object: BOOLEAN

	is_valuetype: BOOLEAN

	is_string: BOOLEAN

	is_object_interface: BOOLEAN
	
feature -- Type nature

	is_character_type: BOOLEAN
	
	is_boolean_type: BOOLEAN
		
feature -- Queries

--	address_as_string: STRING is
--		do
--			Result := address.out
--		end

	address_as_hex_string: STRING is
		do
			Result := "0x" + address.to_integer.to_hex_string
		end

--	type_as_string: STRING is
--		do
--			Result := Debug_value_formatter.cor_element_type_to_string (type)
--		end

	value_to_string: STRING is
			-- 	
		do
			if is_string then
				Result := Debug_value_formatter.prepared_icor_debug_value_as_string (prepared_icor_debug_value)
			else
				Result := Debug_value_formatter.prepared_icor_debug_value_to_string (prepared_icor_debug_value)
			end
		end
		
--	value_to_any: ANY is
--			-- 	
--		do
--			Result := Debug_value_formatter.prepared_icor_debug_value (prepared_icor_debug_value)
--		end		
	
feature -- Queries on ICOR_DEBUG_OBJECT_VALUE

	value_class_token: INTEGER is
		require
			is_object_interface --is_reference_type or else is_class or else is_object or else is_valuetype
		local
		do
			Result := interface_debug_object_value.get_class.get_token
		end

	value_class_name: STRING is
		require
			is_object_interface -- is_reference_type or else is_class or else is_object or else is_valuetype
		do
			Result := Il_debug_info_recorder.class_name_for_class_token_and_module (value_class_token, value_module_file_name)
		end		

	value_module_file_name: STRING is
		require
			is_object_interface -- is_reference_type or else is_class or else is_object or else is_valuetype
		do
			Result := interface_debug_object_value.get_class.get_module.get_name			
		end

feature -- Interface Access

	interface_debug_object_value: like once_interface_debug_object_value is
		require
			valid_object_type: is_reference_type or else is_class or else is_object or else is_valuetype
		do
			if once_interface_debug_object_value /= Void then
				Result := once_interface_debug_object_value
			else
				Result := prepared_icor_debug_value.query_interface_icor_debug_object_value
			end
		end
		
	interface_debug_reference_value: like once_interface_debug_reference_value is
		require
			is_reference_type 
		do
			if once_interface_debug_reference_value /= Void then
				Result := once_interface_debug_reference_value
			else
				Result := prepared_icor_debug_value.query_interface_icor_debug_reference_value
			end
		end
		
	interface_debug_array_value: like once_interface_debug_array_value is
		require
			is_array_type 
		do
			if once_interface_debug_array_value /= Void then
				Result := once_interface_debug_array_value
			else
				Result := prepared_icor_debug_value.query_interface_icor_debug_array_value
			end
		end		

feature {NONE} -- Interface Implementation		
		
	once_interface_debug_object_value: ICOR_DEBUG_OBJECT_VALUE

	once_interface_debug_reference_value: ICOR_DEBUG_REFERENCE_VALUE
	
	once_interface_debug_array_value: ICOR_DEBUG_ARRAY_VALUE
	

	
feature {NONE} -- Implementation

	icor_debug_value: ICOR_DEBUG_VALUE
			-- Object encapsulated by Current

	prepared_icor_debug_value: ICOR_DEBUG_VALUE
			-- prepared Object encapsulated by Current

	Debug_value_formatter: EIFNET_DEBUG_VALUE_FORMATTER is
			-- Formatter of data contained in ICOR_DEBUG_VALUE objects
		once
			create Result
		end

invariant

	icor_debug_value_not_void : icor_debug_value /= Void
	prepared_icor_debug_value_not_void : prepared_icor_debug_value /= Void

	
end -- class EIFNET_DEBUG_VALUE_INFO
