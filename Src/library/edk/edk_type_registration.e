note
	description: "Summary description for {EDK_TYPE_REGISTRATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_TYPE_REGISTRATION


create
	make

feature {NONE}

	make (a_type: TYPE [EDK_WINDOW])
			-- Create registration object for `a_type'
		do
			create type_meta_data.make (default_structure_size)
			create name_to_type_index.make (default_structure_size)

			create default_boolean_list.make (default_structure_size)
			create default_integer_8_list.make (default_structure_size)
			create default_integer_16_list.make (default_structure_size)
			create default_integer_32_list.make (default_structure_size)
			create default_natural_8_list.make (default_structure_size)
			create default_natural_16_list.make (default_structure_size)
			create default_natural_32_list.make (default_structure_size)
			create default_reference_list.make (default_structure_size)
		end

feature -- Access

	default_data_structure: SPECIAL [detachable SPECIAL [detachable ANY]]
			-- Return a newly initialized data structure for `Current'.
		do
			create Result.make_empty (8)
			add_to_structure (Result, default_boolean_list.area)
			add_to_structure (Result, default_integer_8_list.area)
			add_to_structure (Result, default_integer_16_list.area)
			add_to_structure (Result, default_integer_32_list.area)
			add_to_structure (Result, default_natural_8_list.area)
			add_to_structure (Result, default_natural_16_list.area)
			add_to_structure (Result, default_natural_32_list.area)
			add_to_structure (Result, default_reference_list.area)
		end

feature {NONE} -- Implementation

	add_to_structure (a_structure: like default_data_structure; a_list: SPECIAL [detachable ANY])
			-- Add `a_list' to `a_structure' if not empty, else add Void.
		do
			if a_list.count > 0 then
				a_structure.extend (a_list.resized_area (a_list.count))
			else
				a_structure.extend (Void)
			end
		end

feature {EDK_WINDOW} -- Status setting

	register_message_data (a_name: STRING_8; data_type: TYPE [detachable ANY]; meta_data_type: TYPE [detachable ANY])
		require
			has_default: data_type.has_default
				-- FIXME IEK Integrate a default value implementation for non-default types.
		do
			register_type_meta_data (a_name, False, False, data_type, meta_data_type)
		end

	register_property_data (a_name: STRING_8; data_type: TYPE [detachable ANY]; meta_data_type: TYPE [detachable ANY]; a_read_only: BOOLEAN)
		require
			has_default: data_type.has_default
		do
			register_type_meta_data (a_name, True, a_read_only, data_type, meta_data_type)
		end

feature {NONE} -- Implementation

	default_boolean_list: ARRAYED_LIST [BOOLEAN]
	default_integer_8_list: ARRAYED_LIST [INTEGER_8]
	default_integer_16_list: ARRAYED_LIST [INTEGER_16]
	default_integer_32_list: ARRAYED_LIST [INTEGER_32]
	default_natural_8_list: ARRAYED_LIST [NATURAL_8]
	default_natural_16_list: ARRAYED_LIST [NATURAL_16]
	default_natural_32_list: ARRAYED_LIST [NATURAL_32]
	default_reference_list: ARRAYED_LIST [detachable ANY]

	default_boolean_list_position: NATURAL_8 = 0
	default_integer_8_list_position: NATURAL_8 = 1
	default_integer_16_list_position: NATURAL_8 = 2
	default_integer_32_list_position: NATURAL_8 = 3
	default_natural_8_list_position: NATURAL_8 = 4
	default_natural_16_list_position: NATURAL_8 = 5
	default_natural_32_list_position: NATURAL_8 = 6
	default_reference_list_position: NATURAL_8 = 7

	default_list_count: NATURAL_8 = 8
		-- Number of default lists to store in structure

	default_structure_size: NATURAL_8 = 5
		-- Default size of data structures.

	register_type_meta_data (property_name: STRING_8; a_is_property: BOOLEAN; a_read_only: BOOLEAN; data_type: TYPE [detachable ANY]; meta_data_type: TYPE [detachable ANY])
		local
			l_type_index: NATURAL_16
		do
			if a_is_property then
				if data_type ~ {BOOLEAN} then
					l_type_index := default_boolean_list.count.as_natural_16
					default_boolean_list.force (({BOOLEAN}).default)
				elseif data_type ~ {INTEGER_8} then
					l_type_index := default_integer_8_list.count.as_natural_16
					default_integer_8_list.force (({INTEGER_8}).default)
				elseif data_type ~ {INTEGER_16} then
					l_type_index := default_integer_16_list.count.as_natural_16
					default_integer_16_list.force (({INTEGER_16}).default)
				elseif data_type ~ {INTEGER_32} then
					l_type_index := default_integer_32_list.count.as_natural_16
					default_integer_32_list.force (({INTEGER_32}).default)
				elseif data_type ~ {NATURAL_8} then
					l_type_index := default_natural_8_list.count.as_natural_16
					default_natural_8_list.force (({NATURAL_8}).default)
				elseif data_type ~ {NATURAL_16} then
					l_type_index := default_natural_16_list.count.as_natural_16
					default_natural_16_list.force (({NATURAL_16}).default)
				elseif data_type ~ {NATURAL_32} then
					l_type_index := default_natural_32_list.count.as_natural_16
					default_natural_32_list.force (({NATURAL_32}).default)
				else
					l_type_index := default_reference_list.count.as_natural_16
					default_reference_list.force (data_type.default)
				end
				name_to_type_index.put (l_type_index, property_name)
			end
			type_meta_data.put (create {EDK_PROPERTY_ATTRIBUTES}.make (property_name, a_is_property, a_read_only, data_type, meta_data_type), property_name)
		end

	name_to_type_index: HASH_TABLE [NATURAL_16, STRING_8]

	type_meta_data: HASH_TABLE [EDK_PROPERTY_ATTRIBUTES, STRING_8]

end
