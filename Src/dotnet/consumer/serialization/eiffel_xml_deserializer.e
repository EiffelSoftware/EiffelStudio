indexing
	description: "[
					Simple XML deserializer for Eiffel for .NET objects.
					Does not process reference cycles.
					Does not deserialize expanded references.
					Does not deserialize attributes of type INTEGER_64,
					INTEGER_16, INTEGER_8 and BIT.
				]"

class
	EIFFEL_XML_DESERIALIZER

inherit
	EIFFEL_XML_SERIALIZATION_ERRORS
	
	EIFFEL_XML_SERIALIZATION_CONSTANTS
		export
			{NONE} all
		end

	INTERNAL
		export
			{NONE} all
		end

feature -- Access

	deserialized_object: ANY
			-- Last deserialized object

feature -- Basic Operations

	deserialize (path: STRING) is
			-- Deserialize object previously serialized in `path'.
		require
			non_void_path: path /= Void
			valid_path: (create {RAW_FILE}.make (path)).exists
		local
			b, retried: BOOLEAN
			name: STRING
			dt: INTEGER
			name_att: SYSTEM_STRING
		do
			if not retried then		
				last_error := No_error
				last_error_context := Void
				create xml_reader.make_system_xml_xml_text_reader_10 (path.to_cil)
				xml_reader.set_whitespace_handling (feature {SYSTEM_XML_WHITESPACE_HANDLING}.none)
				read_next
				if successful and xml_reader.get_node_type = feature {SYSTEM_XML_XML_NODE_TYPE}.xml_declaration then
					read_next
					deserialized_object := reference_from_xml
				else
					last_error := Invalid_xml_file_error
					last_error_context := clone (path)
				end
				xml_reader.close
			end
		ensure
			deserialized_object_set_if_no_error: successful implies deserialized_object /= Void
		rescue
			if not retried then
				last_error := Generic_error
				if xml_reader /= Void then
					last_error_context := "At line " + xml_reader.get_line_number.out
					xml_reader.close
				else
					last_error_context := "Cannot create XML reader"
				end
				retried := True
				retry
			end
		end

feature {NONE} -- Implementation

	initialize_object (obj: ANY) is
			-- Initialize `obj''s fields with content of `xml_reader'.
		require
			non_void_object: obj /= Void
			non_void_reader: xml_reader /= Void
			valid_reader: xml_reader.get_node_type = feature {SYSTEM_XML_XML_NODE_TYPE}.element and xml_reader.get_name.equals (Reference_node)
		local
			done: BOOLEAN
			i, ft: INTEGER
			f_table: HASH_TABLE [INTEGER, STRING]
		do
			f_table := field_table (obj)
			from
				read_next
			until
				xml_reader.get_node_type = feature {SYSTEM_XML_XML_NODE_TYPE}.end_element or not successful
			loop
				if xml_reader.get_node_type = feature {SYSTEM_XML_XML_NODE_TYPE}.element then
					f_table.search (create {STRING}.make_from_cil (xml_reader.get_attribute (Field_name_xml_attribute)))
					if f_table.found then
						i := f_table.found_item
						ft := field_type (i, obj)
						inspect
							ft
						when Integer_type then
							read_next
							set_integer_field (i, obj, feature {CONVERT}.to_int32_string (xml_reader.get_value))
							read_next
						when Real_type then
							read_next
							set_real_field (i, obj, feature {CONVERT}.to_single_string (xml_reader.get_value))
							read_next
						when Double_type then
							read_next
							set_double_field (i, obj, feature {CONVERT}.to_double_string (xml_reader.get_value))
							read_next
						when Character_type then
							read_next
							set_character_field (i, obj, feature {CONVERT}.to_char_string (xml_reader.get_value))
							read_next
						when Boolean_type then
							read_next
							set_boolean_field (i, obj, feature {CONVERT}.to_boolean_string (xml_reader.get_value))
							read_next
						when Pointer_type then
							read_next
							set_pointer_field (i, obj, default_pointer + feature {CONVERT}.to_int32_string (xml_reader.get_value))
							read_next
						when Reference_type then
							if xml_reader.get_name.equals (String_node) then
								read_next
								set_reference_field (i, obj, create {STRING}.make_from_cil (xml_reader.get_value))
								read_next
							elseif xml_reader.get_name.equals (Array_node) then
								set_reference_field (i, obj, array_from_xml)
							elseif xml_reader.get_name.equals (None_node) then
								read_next
							else
								set_reference_field (i, obj, reference_from_xml)
							end
						else
						end
					else
						last_error := Type_xml_mismatch_error
						last_error_context := "For field " + create {STRING}.make_from_cil (xml_reader.get_attribute (Field_name_xml_attribute))
					end
				end
				read_next
			end
		ensure
			deserialized_object_set_if_no_error: successful implies deserialized_object /= Void
		end

	field_table (obj: ANY): HASH_TABLE [INTEGER, STRING] is
			-- Table of field indices keyed by field names
		require
			non_void_obj: obj /= Void
		local
			i: INTEGER
		do
			create Result.make (field_count (obj))
			from
				i := 1
			until
				i > field_count (obj)
			loop
				Result.put (i, field_name (i, obj))
				i := i + 1
			end
		ensure
			non_void_table: Result /= Void
			valid_table: Result.count = field_count (obj)
		end
			
	array_from_xml: ANY is
			-- Instance of array as described in XML
		require
			non_void_xml_reader: xml_reader /= Void
			valid_xml_reader: xml_reader.get_node_type = feature {SYSTEM_XML_XML_NODE_TYPE}.element and xml_reader.get_name.equals (Array_node)
		local
			lower, count: INTEGER
			s: SYSTEM_STRING
		do
			s := xml_reader.get_attribute (Array_lower_bound_xml_attribute)
			if s/= Void then
				lower := feature {CONVERT}.to_int32_string (s)
				s := xml_reader.get_attribute (Array_count_xml_attribute)
				if s /= Void then
					count := feature {CONVERT}.to_int32_string (s)
					s := xml_reader.get_attribute (Type_xml_attribute)
					if s/= Void then
						if s.equals (Integer_node) then
							Result := integer_array_from_xml (lower, lower + count - 1)								
						elseif s.equals (Real_node) then
							Result := real_array_from_xml (lower, lower + count - 1)
						elseif s.equals (Double_node) then
							Result := double_array_from_xml (lower, lower + count - 1)
						elseif s.equals (Character_node) then
							Result := character_array_from_xml (lower, lower + count - 1)
						elseif s.equals (Boolean_node) then
							Result := boolean_array_from_xml (lower, lower + count - 1)
						elseif s.equals (Pointer_node) then
							Result := pointer_array_from_xml (lower, lower + count - 1)
						elseif s.equals (String_node) then
							Result := string_array_from_xml (lower, lower + count - 1)
						elseif s.equals (None_node) then
							create {ARRAY [ANY]} Result.make (1, 0)
							read_next
						else
							Result := reference_array_from_xml (lower, lower + count - 1)
						end
					else
						last_error := Missing_array_generic_type_error
						last_error_context := "At line " + xml_reader.get_line_number.out
					end
				else
					last_error := Missing_array_count_error
					last_error_context := "At line " + xml_reader.get_line_number.out
				end
			else
				last_error := Missing_array_lower_bound_error
				last_error_context := "At line " + xml_reader.get_line_number.out
			end
		ensure
			array_initialized: successful implies Result /= Void
			non_void_xml_reader: xml_reader /= Void
			valid_xml_reader: xml_reader.get_node_type = feature {SYSTEM_XML_XML_NODE_TYPE}.end_element and xml_reader.get_name.equals (Array_node)
		end

	reference_from_xml: ANY is
			-- Instantiate object described in XML
		require
			non_void_xml_reader: xml_reader /= Void
			valid_xml_reader: xml_reader.get_name.equals (Reference_node)
		local
			name: STRING
			name_att: SYSTEM_STRING
			dt: INTEGER
		do
			name_att := xml_reader.get_attribute (Type_xml_attribute)
			if name_att /= Void then
				create name.make_from_cil (name_att)
	-- FIXME: Hardcoded "Impl." Should really use {INTERNAL}.namespace when implemented
				dt := dynamic_type_from_string ("ISE.Cache.Impl." + name)
				if dt = -1 then
					last_error := Type_not_in_system_error
					last_error_context := name
				else
					Result := new_instance_of (dt)
					initialize_object (Result)
				end
			else
				last_error := Missing_reference_type_error
				last_error_context := "Line " + xml_reader.get_line_number.out
			end
		ensure
			object_initialized: successful implies Result /= Void
			non_void_xml_reader: xml_reader /= Void
			valid_xml_reader: xml_reader.get_node_type = feature {SYSTEM_XML_XML_NODE_TYPE}.end_element and xml_reader.get_name.equals (Reference_node)
		end

	read_next is
			-- Read next XML item
		require
			non_void_xml_reader: xml_reader /= Void
		do
			if not xml_reader.read then
				last_error := Invalid_xml_file_error
				last_error_context := "At line " + xml_reader.get_line_number.out
			end
		end
	
	parse_array (item_processor: ROUTINE [ANY, TUPLE [ANY, INTEGER]]) is
			-- Parse array in XML and call `item_processor' for each item.
			-- Arguments or `item_processor' are item value and item index.
			-- Item value is a string for basic types.
		require
			non_void_item_processor: item_processor /= Void
			non_void_xml_reader: xml_reader /= Void
			valid_xml_reader: xml_reader.get_node_type = feature {SYSTEM_XML_XML_NODE_TYPE}.element and xml_reader.get_name.equals (Array_node)
		local
			index: INTEGER
		do
			from
				read_next
			until
				xml_reader.get_node_type = feature {SYSTEM_XML_XML_NODE_TYPE}.end_element or not successful
			loop
				index := feature {CONVERT}.to_int32_string (xml_reader.get_attribute (Field_name_xml_attribute))
				if xml_reader.get_name.equals (Reference_node) then
					item_processor.call ([reference_from_xml, index])
				elseif xml_reader.get_name.equals (Array_node) then
					item_processor.call ([array_from_xml, index])
				else
					read_next
					item_processor.call ([create {STRING}.make_from_cil (xml_reader.get_value), index])
					read_next
				end
				read_next
			end
		end
		
	integer_array_from_xml (lower, upper: INTEGER): ARRAY [INTEGER] is
			-- Integer array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (agent put_integer (Result, ?, ?))
		ensure
			non_void_array: successful implies Result /= Void
			valid_array: successful implies Result.lower = lower and Result.upper = upper
		end
	
	real_array_from_xml (lower, upper: INTEGER): ARRAY [REAL] is
			-- Real array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (agent put_real (Result, ?, ?))
		ensure
			non_void_array: successful implies Result /= Void
			valid_array: successful implies Result.lower = lower and Result.upper = upper
		end
	
	double_array_from_xml (lower, upper: INTEGER): ARRAY [DOUBLE] is
			-- Real array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (agent put_double (Result, ?, ?))
		ensure
			non_void_array: successful implies Result /= Void
			valid_array: successful implies Result.lower = lower and Result.upper = upper
		end
	
	character_array_from_xml (lower, upper: INTEGER): ARRAY [CHARACTER] is
			-- Character array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (agent put_character (Result, ?, ?))
		ensure
			non_void_array: successful implies Result /= Void
			valid_array: successful implies Result.lower = lower and Result.upper = upper
		end
	
	boolean_array_from_xml (lower, upper: INTEGER): ARRAY [BOOLEAN] is
			-- Boolean array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (agent put_boolean (Result, ?, ?))
		ensure
			non_void_array: successful implies Result /= Void
			valid_array: successful implies Result.lower = lower and Result.upper = upper
		end
	
	pointer_array_from_xml (lower, upper: INTEGER): ARRAY [POINTER] is
			-- Pointer array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (agent put_pointer (Result, ?, ?))
		ensure
			non_void_array: successful implies Result /= Void
			valid_array: successful implies Result.lower = lower and Result.upper = upper
		end
		
	string_array_from_xml (lower, upper: INTEGER): ARRAY [STRING] is
			-- Integer array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (agent Result.put (?, ?))
		ensure
			non_void_array: successful implies Result /= Void
			valid_array: successful implies Result.lower = lower and Result.upper = upper
		end
		
	reference_array_from_xml (lower, upper: INTEGER): ARRAY [ANY] is
			-- Integer array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (agent Result.put (?, ?))
		ensure
			non_void_array: successful implies Result /= Void
			valid_array: successful implies Result.lower = lower and Result.upper = upper
		end

	put_integer (array: ARRAY [INTEGER]; value: STRING; index: INTEGER) is
			-- Put `value' in `array' at index `index'.
		require
			non_void_array: array /= Void
			non_void_value: value /= Void
			valid_index: index <= array.upper
			valid_value: value.is_integer
		do
			array.put (value.to_integer, index)
		ensure
			put: array.item (index) = value.to_integer
		end

	put_real (array: ARRAY [REAL]; value: STRING; index: INTEGER) is
			-- Put `value' in `array' at index `index'.
		require
			non_void_array: array /= Void
			non_void_value: value /= Void
			valid_value: value.is_real
			valid_index: index <= array.upper
		do
			array.put (value.to_real, index)
		ensure
			put: array.item (index) = value.to_real
		end

	put_double (array: ARRAY [DOUBLE]; value: STRING; index: INTEGER) is
			-- Put `value' in `array' at index `index'.
		require
			non_void_array: array /= Void
			non_void_value: value /= Void
			valid_value: value.is_double
			valid_index: index <= array.upper
		do
			array.put (value.to_double, index)
		ensure
			put: array.item (index) = value.to_double
		end

	put_character (array: ARRAY [CHARACTER]; value: STRING; index: INTEGER) is
			-- Put `value' in `array' at index `index'.
		require
			non_void_array: array /= Void
			non_void_value: value /= Void
			valid_value: value.count = 1
			valid_index: index <= array.upper
		do
			array.put (value.item (1), index)
		ensure
			put: array.item (index) = value.item (1)
		end

	put_boolean (array: ARRAY [BOOLEAN]; value: STRING; index: INTEGER) is
			-- Put `value' in `array' at index `index'.
		require
			non_void_array: array /= Void
			non_void_value: value /= Void
			valid_value: value.is_boolean
			valid_index: index <= array.upper
		do
			array.put (value.to_boolean, index)
		ensure
			put: array.item (index) = value.to_boolean
		end

	put_pointer (array: ARRAY [POINTER]; value: STRING; index: INTEGER) is
			-- Put `value' in `array' at index `index'.
		require
			non_void_array: array /= Void
			non_void_value: value /= Void
			valid_value: value.is_integer
			valid_index: index <= array.upper
		do
			array.put (default_pointer + value.to_integer, index)
		ensure
			put: array.item (index) = default_pointer + value.to_integer
		end

	xml_reader: SYSTEM_XML_XML_TEXT_READER
			-- XML reader

end -- class EIFFEL_XML_DESERIALIZER
