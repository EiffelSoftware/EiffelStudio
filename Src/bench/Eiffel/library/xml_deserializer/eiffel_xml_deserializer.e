indexing
	description: "[
					Simple XML deserializer using the Gobo library.
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
		export
			{NONE} all
		end

	TYPE_NAME_ID

	ANY

create
	default_create

feature {NONE} -- Initialization

	xml_parser: XM_EIFFEL_PARSER is
			-- Create a unique XML parser.
		once
			create Result.make
			Result.set_callbacks (pipe_callback.start)
		end

	pipe_callback: XM_TREE_CALLBACKS_PIPE is
			-- Create unique callback pipe.
		once
			create Result.make
		end

feature -- Query

	new_object_from_file (a_file_name: STRING): ANY is
			-- Given XML file located at `a_file_name' read it and create
			-- a corresponding Eiffel object.
		require
			a_file_name_not_void: a_file_name /= Void
		local
			l_xml_parser: like xml_parser
			l_file: KL_TEXT_INPUT_FILE
			l_bool: BOOLEAN
			l_object_root: like xml_element
		do
			Result := retrieve_binary_file (a_file_name)
			
			if Result = Void then
				create l_file.make (a_file_name)
				if l_file.exists and l_file.is_readable then
					l_xml_parser := Xml_parser
					l_file.open_read
					debug ("disable_assertions")
						l_bool := {ISE_RUNTIME}.check_assert (False)
					end
					l_xml_parser.parse_from_stream (l_file)
					debug ("disable_assertions")
						l_bool := {ISE_RUNTIME}.check_assert (l_bool)
					end
					l_file.close
	
					if l_xml_parser.is_correct then
						l_object_root ?= Pipe_callback.document.root_element.item (3)
						if l_object_root /= Void then
							Result := reference_from_xml (l_object_root)
							store_binary_file (a_file_name, Result)	
						end
					end			
				end
			end
		end

feature {NONE} -- Object retrieval from node.

	retrieve_binary_file (a_file_name: STRING): ANY is
			-- Given XML file located at `a_file_name', tries to read its binary
			-- counterpart and create a corresponding Eiffel object.
		require
			a_file_name_not_void: a_file_name /= Void
		local
			retried, l_is_open: BOOLEAN
			l_raw_file: RAW_FILE
			l_file_name: STRING
		do
			if not retried then
				create l_file_name.make (a_file_name.count + 1)
				l_file_name.append (a_file_name)
				l_file_name.append_character ('b')
				create l_raw_file.make (l_file_name)
				if l_raw_file.exists and l_raw_file.is_readable then
					l_raw_file.open_read
					l_is_open := True
					Result := l_raw_file.retrieved
					l_raw_file.close
				end
			else
				if l_is_open then
					l_raw_file.close
				end
			end
		rescue
			retried := True
			retry
		end
		
	store_binary_file (a_file_name: STRING; an_obj: ANY) is
			-- Store binary file associated to XML file `a_file_name'.
		require
			a_file_name_not_void: a_file_name /= Void
		local
			retried, l_is_open: BOOLEAN
			l_raw_file: RAW_FILE
			l_file_name: STRING
		do
			if not retried then
				create l_file_name.make (a_file_name.count + 1)
				l_file_name.append (a_file_name)
				l_file_name.append_character ('b')
				create l_raw_file.make_open_write (l_file_name)
				l_is_open := True
				l_raw_file.independent_store (an_obj)
				l_raw_file.close
			else
				if l_is_open then
					l_raw_file.close
				end
			end
		rescue
			retried := True
			retry
		end
		
	reference_from_xml (a_xml_element: like xml_element): ANY is
			-- Instantiate object described in `a_xml_element'.
		require
			a_xml_element_not_void: a_xml_element /= Void
			a_xml_element_valid_count: a_xml_element.count >= 2
			valid_array_element: a_xml_element.name.is_equal (Reference_node)
		local
			dt: INTEGER
			l_xml_attribute: like xml_attribute
		do
			l_xml_attribute ?= a_xml_element.item (2)

			dt := dynamic_type_from_id (l_xml_attribute.value.to_integer)
			if dt = -1 then
			else
				Result := new_instance_of (dt)
				if a_xml_element.count >= 3 then
					initialize_object (a_xml_element, Result)				
				end
			end
		end

	array_from_xml (a_xml_element: like xml_element): ANY is
			-- Instantiate object described in `a_xml_element'.
		require
			a_xml_element_not_void: a_xml_element /= Void
			a_xml_element_valid_count: a_xml_element.count >= 4
			valid_array_element: a_xml_element.name.is_equal (Array_node)
		local
			l_lower, l_count: INTEGER
			l_attr: like xml_attribute
			l_compare_objects: BOOLEAN
			l_ar: ARRAY [ANY]
		do
			a_xml_element.start

				-- We skip `name'.
			a_xml_element.forth

				-- We get `lower'.
			l_attr ?= a_xml_element.item_for_iteration
			a_xml_element.forth
			l_lower := l_attr.value.to_integer

				-- We get `count'.
			l_attr ?= a_xml_element.item_for_iteration
			a_xml_element.forth
			l_count := l_attr.value.to_integer

				-- we get `object_comparison'.
			l_attr ?= a_xml_element.item_for_iteration
			l_compare_objects := l_attr.value.to_boolean
			a_xml_element.forth

				-- we get `type'.
			l_attr ?= a_xml_element.item_for_iteration
			a_xml_element.forth

			inspect abstract_types (l_attr.value)
			when Boolean_type then
				Result := boolean_array_from_xml (a_xml_element, l_lower, l_lower + l_count - 1)
			when Character_type then
				Result := character_array_from_xml (a_xml_element, l_lower, l_lower + l_count - 1)
			when Integer_32_type then
				Result := integer_array_from_xml (a_xml_element, l_lower, l_lower + l_count - 1)
			when String_type then
				Result := string_array_from_xml (a_xml_element, l_lower, l_lower + l_count - 1)
			else
				Result := reference_array_from_xml (l_attr.value,
					a_xml_element, l_lower, l_lower + l_count - 1)
			end
			if Result /= Void then
				l_ar ?= Result
				if l_ar /= Void and then l_compare_objects then
					l_ar.compare_objects
				end
			end
		end

	initialize_object (a_xml_element: like xml_element; obj: ANY) is
			-- Initialize `obj''s fields with content of `xml_reader'.
		require
			object_not_void: obj /= Void
			a_xml_element_not_void: a_xml_element /= Void
			valid_count: a_xml_element.count >= 3
		local
			l_field_table: HASH_TABLE [INTEGER, STRING]
			l_field_element: like xml_element
			l_attr: like xml_attribute
			l_string_content: STRING
			i, l_field_type: INTEGER
			dtype: INTEGER
			l_node_name: STRING
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
					l_attr ?= l_field_element.item_for_iteration
					l_field_element.forth

						-- Lookup to see that field belongs to `obj'.
					l_field_table.search (l_attr.value)
					if l_field_table.found then
						i := l_field_table.found_item
						l_field_type := field_type_of_type (i, dtype)

						inspect l_field_type
						when Boolean_type then
							l_string_content := retrieve_text (l_field_element)
							set_boolean_field (i, obj, l_string_content.to_boolean)
						when Character_type then
							l_string_content := retrieve_text (l_field_element)
							set_character_field (i, obj, l_string_content.item (1))
						when Integer_32_type then
							l_string_content := retrieve_text (l_field_element)
							set_integer_field (i, obj, l_string_content.to_integer)
						when Reference_type then
							l_node_name := l_field_element.name
							if l_node_name.is_equal (Reference_node) then
								set_reference_field (i, obj, reference_from_xml (l_field_element))
							elseif l_node_name.is_equal (String_node) then
								if l_field_element.after then
									l_string_content := Void
								else
									l_string_content := retrieve_text (l_field_element)
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

	internal_dynamic_types: ARRAY [INTEGER] is
			-- List of correspondance between type names and their
			-- corresponding dynamic types.
		once
			create Result.make (1, 19)
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
			l_data_content: STRING
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
					l_attr ?= l_field_element.item_for_iteration
					l_field_element.forth
					l_index := l_attr.value.to_integer

					if l_type.is_equal (Reference_node) then
						item_processor.call ([reference_from_xml (l_field_element), l_index])
					elseif l_type.is_equal (Array_node) then
						item_processor.call ([array_from_xml (l_field_element), l_index])
					else
						l_data_content := retrieve_text (l_field_element)
						item_processor.call ([l_data_content, l_index])
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

	reference_array_from_xml (a_array_element_type: STRING; a_xml_element: like xml_element; lower, upper: INTEGER): ARRAY [ANY] is
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
				parse_array (a_xml_element, agent Result.put (?, ?))
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

feature {NONE} -- Implementation

	retrieve_text (a_field_element: like xml_element): STRING is
			-- Retrieve text
		require
			non_void_element: a_field_element /= Void
			element_is_character_data: is_character_data (a_field_element)
		local
			l_data: XM_CHARACTER_DATA
		do
			l_data ?= a_field_element.item_for_iteration
			check l_data /= Void end
			create Result.make_from_string (l_data.content)
			from
				a_field_element.forth
			until
				a_field_element.after or l_data = Void
			loop
				l_data ?= a_field_element.item_for_iteration
				if l_data /= Void then
					Result.append (l_data.content)
				end
				a_field_element.forth
			end
		ensure
			non_void_retrieve_text: Result /= Void
		end

	is_character_data (a_field_element: like xml_element): BOOLEAN is
			-- Is `a_field_element' a XM_CHARACTER_DATA?
		local
			l_data: XM_CHARACTER_DATA
		do
			l_data ?= a_field_element.item_for_iteration
			Result := l_data /= Void
		end
	
feature {NONE} -- Type specification

	xml_attribute: XM_ATTRIBUTE is
			-- To get proper type so that code can be easily modified back
			-- and forth between New/old
		do
		end

	xml_element: XM_ELEMENT is
			-- To get proper type so that code can be easily modified back
			-- and forth between New/old
		do
		end

	xml_character_data: XM_CHARACTER_DATA is
			-- To get proper type so that code can be easily modified back
			-- and forth between New/old
		do
		end

end -- class ROOT_CLASS
