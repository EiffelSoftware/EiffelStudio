indexing
	description: "[
					Simple XML deserializer for Eiffel for .NET objects.
					Does not process reference cycles.
					Does not deserialize expanded references.
					Does not deserialize attributes of type INTEGER_64,
					INTEGER_16, INTEGER_8 and BIT.
				]"
	date: "$Date$"
	revision: "$Revision$"

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

	TYPE_NAME_ID

feature -- Access

	deserialized_object: ANY
			-- Last deserialized object

feature -- Basic Operations

	deserialize (path: STRING; a_use_bin_if_avail: BOOLEAN) is
			-- Deserialize object previously serialized in `path'.
			-- Uses the binary deserialize if `a_use_bin_if_avail' is True and there is a binary
			-- seralized version available.
		require
			non_void_path: path /= Void
			valid_path: (create {RAW_FILE}.make (path)).exists
		local
			retried: BOOLEAN
			bin_des: EIFFEL_BINARY_DESERIALIZER
			ser: EIFFEL_BINARY_SERIALIZER
			l_version: STRING
			l_so: SYSTEM_OBJECT
		do
			if not retried then
				if a_use_bin_if_avail then
					create bin_des
					bin_des.deserialize (path)
					if bin_des.deserialized_object /= void then
						deserialized_object := bin_des.deserialized_object
					end					
				end
				if deserialized_object = Void then
					if feature {SYSTEM_FILE}.exists (path.to_cil) then
						last_error := No_error
						last_error_context := Void
						create xml_reader.make_from_url (path.to_cil)
						xml_reader.set_whitespace_handling (feature {XML_WHITESPACE_HANDLING}.none)
						read_next
						if successful and xml_reader.node_type = feature {XML_XML_NODE_TYPE}.xml_declaration then
							read_next
							if successful and xml_reader.node_type = feature {XML_XML_NODE_TYPE}.element then
								l_so := Current
								l_version := xml_reader.get_attribute (Version_xml_attribute)
								if l_version /= Void and then l_version.is_equal (xmls_ver) then
										-- ensure compatibility
									read_next
									deserialized_object := reference_from_xml
									if a_use_bin_if_avail and deserialized_object /= Void then
										create ser
										ser.serialize (deserialized_object, path)
									end
								else
									last_error := Incompatible_xml_file_error
									last_error_context := path.twin
								end
							end
						else
							last_error := Invalid_xml_file_error
							last_error_context := path.twin
						end
						xml_reader.close
					else
						last_error := Generic_error
						last_error_context := "File " + path + " does not exist."
					end
				end
			end
		ensure
			deserialized_object_set_if_no_error: successful implies deserialized_object /= Void
		rescue
			if not retried then
				last_error := Generic_error
				if xml_reader /= Void then
					last_error_context := "At line " + xml_reader.line_number.out
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
			valid_reader: xml_reader.node_type = feature {XML_XML_NODE_TYPE}.element and xml_reader.name.equals (Reference_node)
		local
			i, ft: INTEGER
			f_table: HASH_TABLE [INTEGER, STRING]
		do
			f_table := field_table (dynamic_type (obj))
			from
				read_next
			until
				xml_reader.node_type = feature {XML_XML_NODE_TYPE}.end_element or not successful
			loop
				if xml_reader.node_type = feature {XML_XML_NODE_TYPE}.element then
					f_table.search (create {STRING}.make_from_cil (xml_reader.get_attribute (Field_name_xml_attribute)))
					if f_table.found then
						i := f_table.found_item
						ft := field_type (i, obj)
						inspect
							ft
						when Integer_type then
							read_next
							set_integer_field (i, obj, feature {SYSTEM_CONVERT}.to_int_32_string (xml_reader.value))
							read_next
						when Real_type then
							read_next
							set_real_field (i, obj, feature {SYSTEM_CONVERT}.to_single_string (xml_reader.value))
							read_next
						when Double_type then
							read_next
							set_double_field (i, obj, feature {SYSTEM_CONVERT}.to_double_string (xml_reader.value))
							read_next
						when Character_type then
							read_next
							set_character_field (i, obj, feature {SYSTEM_CONVERT}.to_char_string (xml_reader.value))
							read_next
						when Boolean_type then
							read_next
							set_boolean_field (i, obj, feature {SYSTEM_CONVERT}.to_boolean_string (xml_reader.value))
							read_next
						when Pointer_type then
							read_next
							set_pointer_field (i, obj, default_pointer + feature {SYSTEM_CONVERT}.to_int_32_string (xml_reader.value))
							read_next
						when Reference_type then
							if xml_reader.name.equals (String_node) then
								read_next
								set_reference_field (i, obj, create {STRING}.make_from_cil (xml_reader.value))
								read_next
							elseif xml_reader.name.equals (Array_node) then
								set_reference_field (i, obj, array_from_xml)
							elseif xml_reader.name.equals (None_node) then
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
		end

	array_from_xml: ANY is
			-- Instance of array as described in XML
		require
			non_void_xml_reader: xml_reader /= Void
			valid_xml_reader: xml_reader.node_type = feature {XML_XML_NODE_TYPE}.element and xml_reader.name.equals (Array_node)
		local
			lower, count: INTEGER
			s: SYSTEM_STRING
			ar: ARRAY [ANY]
			compare_obj: BOOLEAN
		do
			s := xml_reader.get_attribute (Array_lower_bound_xml_attribute)
			if s/= Void then
				lower := feature {SYSTEM_CONVERT}.to_int_32_string (s)
				s := xml_reader.get_attribute (Array_count_xml_attribute)
				if s /= Void then
					count := feature {SYSTEM_CONVERT}.to_int_32_string (s)
					s := xml_reader.get_attribute (Compare_objects_xml_attribute)
					if s /= Void then
						compare_obj := feature {SYSTEM_CONVERT}.to_boolean_string (s)
					end
					s := xml_reader.get_attribute (Type_xml_attribute)
					if s/= Void then
						inspect xml_abstract_types (s)
						when Boolean_type then
							Result := boolean_array_from_xml (lower, lower + count - 1)
						when Character_type then
							Result := character_array_from_xml (lower, lower + count - 1)
						when Integer_32_type then
							Result := integer_array_from_xml (lower, lower + count - 1)
						when String_type then
							Result := string_array_from_xml (lower, lower + count - 1)
						else
							Result := reference_array_from_xml (s, lower, lower + count - 1)
						end
						if Result /= Void and then compare_obj then
							ar ?= Result
							if ar /= Void then
								ar.compare_objects	
							end						
						end
					else
						last_error := Missing_array_generic_type_error
						last_error_context := "At line " + xml_reader.line_number.out
					end
				else
					last_error := Missing_array_count_error
					last_error_context := "At line " + xml_reader.line_number.out
				end
			else
				last_error := Missing_array_lower_bound_error
				last_error_context := "At line " + xml_reader.line_number.out
			end
		ensure
			array_initialized: successful implies Result /= Void
			non_void_xml_reader: xml_reader /= Void
			valid_xml_reader: xml_reader.node_type = feature {XML_XML_NODE_TYPE}.end_element and xml_reader.name.equals (Array_node)
		end

	reference_from_xml: ANY is
			-- Instantiate object described in XML
		require
			non_void_xml_reader: xml_reader /= Void
			valid_xml_reader: xml_reader.name.equals (Reference_node)
		local
			name: STRING
			name_att: SYSTEM_STRING
			dt: INTEGER
		do
			name_att := xml_reader.get_attribute (Type_xml_attribute)
			if name_att /= Void then
				create name.make_from_cil (name_att)
				dt := dynamic_type_from_id (name.to_integer)
				if dt = -1 then
					last_error := Type_not_in_system_error
					last_error_context := name
				else
					Result := new_instance_of (dt)
					initialize_object (Result)
				end
			else
				last_error := Missing_reference_type_error
				last_error_context := "Line " + xml_reader.line_number.out
			end
		ensure
			object_initialized: successful implies Result /= Void
			non_void_xml_reader: xml_reader /= Void
			valid_xml_reader: xml_reader.node_type = feature {XML_XML_NODE_TYPE}.end_element and xml_reader.name.equals (Reference_node)
		end

	read_next is
			-- Read next XML item
		require
			non_void_xml_reader: xml_reader /= Void
		do
			if not xml_reader.read then
				last_error := Invalid_xml_file_error
				last_error_context := "At line " + xml_reader.line_number.out
			end
		end

	parse_array (item_processor: ROUTINE [ANY, TUPLE [ANY, INTEGER]]) is
			-- Parse array in XML and call `item_processor' for each item.
			-- Arguments or `item_processor' are item value and item index.
			-- Item value is a string for basic types.
		require
			non_void_item_processor: item_processor /= Void
			non_void_xml_reader: xml_reader /= Void
			valid_xml_reader: xml_reader.node_type = feature {XML_XML_NODE_TYPE}.element and xml_reader.name.equals (Array_node)
		local
			index: INTEGER
		do
			from
				read_next
			until
				xml_reader.node_type = feature {XML_XML_NODE_TYPE}.end_element or not successful
			loop
				index := feature {SYSTEM_CONVERT}.to_int_32_string (xml_reader.get_attribute (Field_name_xml_attribute))
				if xml_reader.name.equals (Reference_node) then
					item_processor.call ([reference_from_xml, index])
				elseif xml_reader.name.equals (Array_node) then
					item_processor.call ([array_from_xml, index])
				else
					read_next
					item_processor.call ([create {STRING}.make_from_cil (xml_reader.value), index])
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

	reference_array_from_xml (a_array_element_type: STRING; lower, upper: INTEGER): ARRAY [ANY] is
			-- Integer array as described in XML file
		require
			a_array_element_type_not_void: a_array_element_type /= Void
			a_array_element_type_valid: a_array_element_type.is_integer or
				a_array_element_type.is_equal (none_node)
			valid_bounds: lower <= upper + 1
		local
			l_element_type_id: INTEGER
			l_array_type: STRING
		do
			if lower <= upper then
				l_element_type_id := dynamic_type_from_id (a_array_element_type.to_integer)
					-- Create ARRAY
				l_array_type := "ARRAY ["
				l_array_type.append (type_name_of_type (l_element_type_id))
				l_array_type.append_character (']')
				
				Result ?= new_instance_of (dynamic_type_from_string (l_array_type))
				Result.make (lower, upper)
				parse_array (agent Result.put (?, ?))
			end
		ensure
			array_set_if_not_none_type:
				lower <= upper implies
					Result /= Void and then (Result.lower = lower and Result.upper = upper)
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

	xml_reader: XML_XML_TEXT_READER
			-- XML reader

feature {NONE} -- Implementation - internal speedup

	field_table (dtype: INTEGER): HASH_TABLE [INTEGER, STRING] is
			-- Table of field indices keyed by field names
		require
			valid_dtype: dtype > 0
		local
			i, nb: INTEGER
			l_table: like internal_field_table
		do
			l_table := internal_field_table
			Result := l_table.item (dtype)
			if Result = Void then
				nb := field_count_of_type (dtype)
				create Result.make (nb)
				l_table.put (Result, dtype)
				
				from
					i := 1
				until
					i > nb
				loop
					Result.put (i, field_name_of_type (i, dtype))
					i := i + 1
				end
			end
		end

	internal_field_table: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER] is
			-- To quickly find where attributes are located.
		once
			create Result.make (10)
		end

	dynamic_type_from_id (an_id: INTEGER): INTEGER is
			-- Given a type id `an_id' retrieves its corresponding dynamic type.
		local
			l_full_name: STRING
		do
			Result := internal_dynamic_types.item (an_id)
			if Result = 0 then
				l_full_name := types.item (an_id)
				Result := dynamic_type_from_string (l_full_name)
				internal_dynamic_types.put (Result, an_id)
			end
		end

	xml_abstract_types (name: STRING): INTEGER is
			-- Predefined abstract types
		local
			l_table: like internal_abstract_types
		do
			l_table := internal_abstract_types
			l_table.search (name)
			if l_table.found then
				Result := l_table.found_item
			end
		end

	internal_abstract_types: HASH_TABLE [INTEGER, STRING] is
			-- List of correspondance between basic types and ID defined in
			-- INTERNAL.
		once
			create Result.make (15)
			Result.put (Boolean_type, Boolean_node)
			Result.put (Character_type, Character_node)
			Result.put (Integer_32_type, Integer_node)
			Result.put (String_type, String_node)
		end

	internal_dynamic_types: ARRAY [INTEGER] is
			-- List of correspondance between type names and their
			-- corresponding dynamic types.
		once
			create Result.make (types.lower, types.upper)
		end

	String_type: INTEGER is -1
			-- Constant type for STRING.
			-- Negative so that we are sure to never have a conflict with existing
			-- type values.

end
