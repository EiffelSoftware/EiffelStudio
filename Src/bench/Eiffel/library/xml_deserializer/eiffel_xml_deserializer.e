indexing
	description: "[
					Simple XML deserializer using the eXML library.
					Does not process reference cycles.
					Does not deserialize expanded references.
					Does not deserialize attributes of type INTEGER_64,
					INTEGER_16, INTEGER_8, REAL, DOUBLE, POINTER and BIT.
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_XML_DESERIALIZER

inherit
	INTERNAL
		rename
			dynamic_type_from_string as internal_dynamic_type_from_string
		export
			{NONE} all
		end
		
	ANY

create
	default_create

feature -- Query

	new_object_from_file (a_file_name: STRING): ANY is
			-- Given XML file located at `a_file_name' read it and create
			-- a corresponding Eiffel object.
		require
			a_file_name_not_void: a_file_name /= Void
		local			
			l_xml_tree_parser: XML_TREE_PARSER
			l_file_name: STRING
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			
			if l_file.exists and l_file.is_readable then
				create l_file_name.make_from_string (a_file_name)
				l_file.open_read
				l_file.readstream (l_file.count)
				l_file.close

				create l_xml_tree_parser.make
				l_xml_tree_parser.parse_string (l_file.last_string)
				l_xml_tree_parser.set_end_of_file
				
				if l_xml_tree_parser.is_correct then
					Result := reference_from_xml (l_xml_tree_parser.root_element)
				else
					print ("Error ")
					print (l_xml_tree_parser.last_error_extended_description)
					print ("%N")
				end
			end
		end
		
feature {NONE} -- Object retrieval from node.

	reference_from_xml (a_xml_element: like xml_element): ANY is
			-- Instantiate object described in `a_xml_element'.
		require
			a_xml_element_not_void: a_xml_element /= Void
			a_xml_element_valid_count: a_xml_element.count >= 2
			valid_array_element: a_xml_element.name.is_equal (Reference_node)
		local
			name: STRING
			dt: INTEGER
			l_xml_attribute: like xml_attribute
		do
			l_xml_attribute := a_xml_element.attributes.item (Type_attr)
			name := l_xml_attribute.value.out
			
			dt := dynamic_type_from_string (name)
			if dt = -1 then
			else
				Result := new_instance_of (dt)
				if a_xml_element.attributes.count = 2 then
					initialize_object (a_xml_element, Result)				
				end
			end
		end
		
	array_from_xml (a_xml_element: like xml_element): ANY is
			-- Instantiate object described in `a_xml_element'.
		require
			a_xml_element_not_void: a_xml_element /= Void
			a_xml_element_valid_count: a_xml_element.attributes.count = 4
			valid_array_element: a_xml_element.name.is_equal (Array_node)
		local
			l_lower, l_count: INTEGER
			l_element_type_name: STRING
			l_attr: like xml_attribute
		do
				-- We get `lower'.
			l_attr := a_xml_element.attributes.item (lower_attr)
			l_lower := l_attr.value.to_integer

				-- We get `count'.
			l_attr := a_xml_element.attributes.item (count_attr)
			l_count := l_attr.value.to_integer
			
				-- we get `type'.
			l_attr ?= a_xml_element.attributes.item (type_attr)
			l_element_type_name := l_attr.value.out

			inspect abstract_types (l_element_type_name)
			when Boolean_type then
				Result := boolean_array_from_xml (a_xml_element, l_lower, l_lower + l_count - 1)
			when Character_type then
				Result := character_array_from_xml (a_xml_element, l_lower, l_lower + l_count - 1)
			when Integer_32_type then
				Result := integer_array_from_xml (a_xml_element, l_lower, l_lower + l_count - 1)
			when String_type then
				Result := string_array_from_xml (a_xml_element, l_lower, l_lower + l_count - 1)
			else
				Result := reference_array_from_xml (a_xml_element, l_lower, l_lower + l_count - 1)
			end
		end

	initialize_object (a_xml_element: like xml_element; obj: ANY) is
			-- Initialize `obj''s fields with content of `xml_reader'.
		require
			object_not_void: obj /= Void
			a_xml_element_not_void: a_xml_element /= Void
			valid_count: a_xml_element.attributes.count = 2
		local
			l_field_table: HASH_TABLE [INTEGER, STRING]
			l_field_element: like xml_element
			l_attr: like xml_attribute
			l_data: like xml_character_data
			i, l_field_type: INTEGER
			dtype: INTEGER
			l_node_name, l_field_name: STRING
			l_string_content: STRING
		do
			from
					-- We know it is a reference node, so we can skip
					-- until we reach the next element.
				a_xml_element.start
				dtype := dynamic_type (obj)
				l_field_table := field_table (dtype)
			until
				a_xml_element.after
			loop
				from
					l_field_element := Void
				until
					l_field_element /= Void or a_xml_element.after
				loop
					l_field_element ?= a_xml_element.item_for_iteration
					a_xml_element.forth
				end

				if not a_xml_element.after then
					l_field_element.start
					l_attr := l_field_element.attributes.item (Name_attr)
					l_field_name := l_attr.value
					
						-- Lookup to see that field belongs to `obj'.
					l_field_table.search (l_field_name.out)
					if l_field_table.found then
						i := l_field_table.found_item
						l_field_type := field_type_of_type (i, dtype)

						
						inspect l_field_type
						when Boolean_type then
							l_data ?= l_field_element.item_for_iteration
							check l_data /= Void end
							set_boolean_field (i, obj, l_data.content.out.to_boolean)
						when Character_type then
							l_data ?= l_field_element.item_for_iteration
							check l_data /= Void end
							set_character_field (i, obj, l_data.content.out.item (1))
						when Integer_32_type then
							l_data ?= l_field_element.item_for_iteration
							check l_data /= Void end
							set_integer_field (i, obj, l_data.content.out.to_integer)
						when Reference_type then
							l_node_name := l_field_element.name
							if l_node_name.is_equal (Reference_node) then
								set_reference_field (i, obj, reference_from_xml (l_field_element))
							elseif l_node_name.is_equal (String_node) then
								from
									l_data ?= l_field_element.item_for_iteration
									l_string_content := l_data.content.out
									l_field_element.forth
								until
									l_field_element.after
								loop
									l_data ?= l_field_element.item_for_iteration
									l_string_content.append (l_data.content.out)
									l_field_element.forth
								end
								set_reference_field (i, obj, l_string_content)
							elseif l_node_name.is_equal (Array_node) then
								set_reference_field (i, obj, array_from_xml (l_field_element))
							else
								check
									l_node_name.is_equal (None_node)
								end
							end
						else
							check
								type_not_handled: False
							end
						end
					end
				end
			end
		end

feature {NONE} -- Node constants

	type_attr: STRING is "T"
	name_attr: STRING is "N"
	count_attr: STRING is "C"
	lower_attr: STRING is "L"
	
	reference_node: STRING is "R"
	array_node: STRING is "A"
	string_node: STRING is "S"
	integer_node: STRING is "I"
	character_node: STRING is "C"
	boolean_node: STRING is "B"

	none_node: STRING is "NONE"
		
feature {NONE} -- Internal speedup

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

	dynamic_type_from_string (name: STRING): INTEGER is
			-- Given a type name `name' retrieves its corresponding 
			-- dynamic type.
		local
			l_table: like internal_dynamic_types
		do
			l_table := internal_dynamic_types
			l_table.search (name)
			if l_table.found then
				Result := l_table.found_item
			else
				Result := internal_dynamic_type_from_string (name)
				l_table.put (Result, name)
			end
		end

	abstract_types (name: STRING): INTEGER is
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

	internal_field_table: HASH_TABLE [HASH_TABLE [INTEGER, STRING], INTEGER] is
			-- To quickly find where attributes are located.
		once
			create Result.make (10)
		end

	internal_dynamic_types: HASH_TABLE [INTEGER, STRING] is
			-- List of correspondance between type names and their
			-- corresponding dynamic types.
		once
			create Result.make (10)
		end

	String_type: INTEGER is -1
			-- Constant type for STRING.
			-- Negative so that we are sure to never have a conflict with existing
			-- type values.

feature {NONE} -- Array manipulations

	parse_array (a_xml_element: like xml_element; item_processor: ROUTINE [ANY, TUPLE [ANY, INTEGER]]) is
			-- Automatically update array referenced by `item_processor' using data
			-- from `a_xml_element'.
		require
			a_xml_element_not_void: a_xml_element /= Void
			item_processor_not_void: item_processor /= Void
		local
			l_field_element: like xml_element
			l_attr: like xml_attribute
			l_index: INTEGER
			l_type: STRING
			l_data: like xml_character_data
		do
			from
				a_xml_element.start
			until
				a_xml_element.after
			loop
				from
					l_field_element := Void
				until
					l_field_element /= Void or a_xml_element.after
				loop
					l_field_element ?= a_xml_element.item_for_iteration
					a_xml_element.forth
				end

				if not a_xml_element.after then
					l_field_element.start
					l_type := l_field_element.name
				
					l_attr ?= l_field_element.attributes.item (Name_attr)
					l_index := l_attr.value.to_integer

					if l_type.is_equal (Reference_node) then
						item_processor.call ([reference_from_xml (l_field_element), l_index])
					elseif l_type.is_equal (Array_node) then
						item_processor.call ([array_from_xml (l_field_element), l_index])
					else
						l_data ?= l_field_element.item_for_iteration
						item_processor.call ([l_data.content.out, l_index])
					end
				end
			end
		end

	integer_array_from_xml (a_xml_element: like xml_element; lower, upper: INTEGER): ARRAY [INTEGER] is
			-- Integer array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (a_xml_element, agent put_integer (Result, ?, ?))
		ensure
			non_void_array: Result /= Void
			valid_array: Result.lower = lower and Result.upper = upper
		end
	
	character_array_from_xml (a_xml_element: like xml_element; lower, upper: INTEGER): ARRAY [CHARACTER] is
			-- Character array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (a_xml_element, agent put_character (Result, ?, ?))
		ensure
			non_void_array: Result /= Void
			valid_array: Result.lower = lower and Result.upper = upper
		end
	
	boolean_array_from_xml (a_xml_element: like xml_element; lower, upper: INTEGER): ARRAY [BOOLEAN] is
			-- Boolean array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (a_xml_element, agent put_boolean (Result, ?, ?))
		ensure
			non_void_array: Result /= Void
			valid_array: Result.lower = lower and Result.upper = upper
		end

	string_array_from_xml (a_xml_element: like xml_element; lower, upper: INTEGER): ARRAY [STRING] is
			-- Integer array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (a_xml_element, agent Result.put (?, ?))
		ensure
			non_void_array: Result /= Void
			valid_array: Result.lower = lower and Result.upper = upper
		end
		
	reference_array_from_xml (a_xml_element: like xml_element; lower, upper: INTEGER): ARRAY [ANY] is
			-- Integer array as described in XML file
		require
			valid_bounds: lower <= upper + 1
		do
			create Result.make (lower, upper)
			parse_array (a_xml_element, agent Result.put (?, ?))
		ensure
			non_void_array: Result /= Void
			valid_array: Result.lower = lower and Result.upper = upper
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

feature {NONE} -- Type specification

	xml_attribute: XML_ATTRIBUTE is
			-- To get proper type so that code can be easily modified back
			-- and forth between New/old
		do
		end

	xml_element: XML_ELEMENT is
			-- To get proper type so that code can be easily modified back
			-- and forth between New/old
		do
		end

	xml_character_data: XML_CHARACTER_DATA is
			-- To get proper type so that code can be easily modified back
			-- and forth between New/old
		do
		end

end -- class ROOT_CLASS
