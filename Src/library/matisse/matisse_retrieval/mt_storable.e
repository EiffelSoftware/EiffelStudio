indexing
	description: "Class which gives all its subclasses%
				%the means to be persistent.%
				%All classes which are to be stored in a Matisse%
				%database should inherit from this class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_STORABLE 

inherit
	MT_OBJECT
		rename 
			make as make_from_oid
		end


feature -- Accessing attributes

	mt_load_all_values is
			-- Load values of all attributes of the class.
		local
			c: MT_CLASS
		do
			if not attributes_loaded and then db /= Void then
				c := db.mt_class_from_object (Current)
				c.load_attr_values_of_object (Current)
				loading_attrs_done
			end
		end

	mt_get_value_by_name, mtget_value (attr_name: STRING): ANY is
			-- Return the value of the attribute specified by 'attr_name'.
		do
			if db /= Void then
				Result := db.get_attr_value_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_value_by_position, mt_get_value (index: INTEGER): ANY is
			-- Return the value of the attribute field-positioned at 'index'.
		do
			if db /= Void then
				Result := db.get_attr_value_of_object_by_position (Current, index)
			end
		end

	-- MT_BOOLEAN --	
	mt_get_boolean_by_name, mtget_boolean (attr_name: STRING): BOOLEAN is
		do
			if db /= Void then
				Result := db.get_boolean_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_boolean_by_position, mt_get_boolean (index: INTEGER): BOOLEAN is
		do
			if db /= Void then
				Result := db.get_boolean_of_object_by_position (Current, index)
			end
		end
	
	-- MT_DATE --
	mt_get_date_by_name, mtget_date (attr_name: STRING): DATE is
		do
			if db /= Void then
				Result := db.get_date_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_date_by_position, mt_get_date (index: INTEGER): DATE is
		do
			if db /= Void then
				Result := db.get_date_of_object_by_position (Current, index)
			end
		end
	
	-- MT_TIMESTAMP --
	mt_get_timestamp_by_name, mtget_timestamp (attr_name: STRING): DATE_TIME is
		do
			if db /= Void then
				Result := db.get_timestamp_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_timestamp_by_position, mt_get_timestamp (index: INTEGER): DATE_TIME is
		do
			if db /= Void then
				Result := db.get_timestamp_of_object_by_position (Current, index)
			end
		end
	
	-- MT_TIME_INTERVAL --
	mt_get_time_interval_by_name, mtget_time_interval (attr_name: STRING): DATE_TIME_DURATION is
		do
			if db /= Void then
				Result := db.get_time_interval_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_time_interval_by_position, mt_get_time_interval (index: INTEGER): DATE_TIME_DURATION is
		do
			if db /= Void then
				Result := db.get_time_interval_of_object_by_position (Current, index)
			end
		end
	
	-- MT_S32 --
	mt_get_integer_by_name, mtget_integer (attr_name: STRING): INTEGER is
		do
			if db /= Void then
				Result := db.get_integer_value_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_integer_by_position, mt_get_integer (index: INTEGER): INTEGER is
		do
			if db /= Void then
				Result := db.get_integer_value_of_object_by_position (Current, index)
			end
		end

	mt_get_integer_array_by_name, mtget_integer_array (attr_name: STRING): ARRAY [INTEGER] is
		do
			if db /= Void then
				Result := db.get_integer_array_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_integer_array_by_position, mt_get_integer_array (index: INTEGER): ARRAY [INTEGER] is
		do
			if db /= Void then
				Result := db.get_integer_array_of_object_by_position (Current, index)
			end
		end
	
	mt_get_integer_list_by_name, mtget_integer_list (attr_name: STRING): LINKED_LIST [INTEGER] is
		do
			if db /= Void then
				Result := db.get_integer_list_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_integer_list_by_position, mt_get_integer_list (index: INTEGER): LINKED_LIST [INTEGER] is
		do
			if db /= Void then
				Result := db.get_integer_list_of_object_by_position (Current, index)
			end
		end
	
	-- MT_U32 --
	mt_get_unsigned_integer_by_name, mtget_unsigned_integer (attr_name: STRING): INTEGER is
		do
			if db /= Void then
				Result := db.get_unsigned_int_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_unsigned_integer_by_position, mt_get_unsigned_integer (index: INTEGER): INTEGER is
		do
			if db /= Void then
				Result := db.get_unsigned_int_of_object_by_position (Current, index)
			end
		end

	mt_get_unsigned_integer_array_by_name, mtget_unsigned_integer_array (attr_name: STRING): ARRAY [INTEGER] is
		do
			if db /= Void then
				Result := db.get_unsigned_int_array_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_unsigned_integer_array_by_position, mt_get_unsigned_integer_array (index: INTEGER): ARRAY [INTEGER] is
		do
			if db /= Void then
				Result := db.get_unsigned_int_array_of_object_by_position (Current, index)
			end
		end
	
	mt_get_unsigned_integer_list_by_name, mtget_unsigned_integer_list (attr_name: STRING): LINKED_LIST [INTEGER] is
		do
			if db /= Void then
				Result := db.get_unsigned_int_list_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_unsigned_integer_list_by_position, mt_get_unsigned_integer_list (index: INTEGER): LINKED_LIST [INTEGER] is
		do
			if db /= Void then
				Result := db.get_unsigned_int_list_of_object_by_position (Current, index)
			end
		end

	-- MT_S16 --
	mt_get_short_by_name, mtget_short (attr_name: STRING): INTEGER is
		do
			if db /= Void then
				Result := db.get_short_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_short_by_position, mt_get_short (index: INTEGER): INTEGER is
		do
			if db /= Void then
				Result := db.get_short_of_object_by_position (Current, index)
			end
		end

	mt_get_short_array_by_name, mtget_short_array (attr_name: STRING): ARRAY [INTEGER] is
		do
			if db /= Void then
				Result := db.get_short_array_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_short_array_by_position, mt_get_short_array (index: INTEGER): ARRAY [INTEGER] is
		do
			if db /= Void then
				Result := db.get_short_array_of_object_by_position (Current, index)
			end
		end
	
	mt_get_short_list_by_name, mtget_short_list (attr_name: STRING): LINKED_LIST [INTEGER] is
		do
			if db /= Void then
				Result := db.get_short_list_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_short_list_by_position, mt_get_short_list (index: INTEGER): LINKED_LIST [INTEGER] is
		do
			if db /= Void then
				Result := db.get_short_list_of_object_by_position (Current, index)
			end
		end

	-- MT_U16 --
	mt_get_unsigned_short_by_name, mtget_unsigned_short (attr_name: STRING): INTEGER is
		do
			if db /= Void then
				Result := db.get_unsigned_short_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_unsigned_short_by_position, mt_get_unsigned_short (index: INTEGER): INTEGER is
		do
			if db /= Void then
				Result := db.get_unsigned_short_of_object_by_position (Current, index)
			end
		end

	mt_get_unsigned_short_array_by_name, mtget_unsigned_short_array (attr_name: STRING): ARRAY [INTEGER] is
		do
			if db /= Void then
				Result := db.get_unsigned_short_array_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_unsigned_short_array_by_position, mt_get_unsigned_short_array (index: INTEGER): ARRAY [INTEGER] is
		do
			if db /= Void then
				Result := db.get_unsigned_short_array_of_object_by_position (Current, index)
			end
		end
	
	mt_get_unsigned_short_list_by_name, mtget_unsigned_short_list (attr_name: STRING): LINKED_LIST [INTEGER] is
		do
			if db /= Void then
				Result := db.get_unsigned_short_list_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_unsigned_short_list_by_position, mt_get_unsigned_short_list (index: INTEGER): LINKED_LIST [INTEGER] is
		do
			if db /= Void then
				Result := db.get_unsigned_short_list_of_object_by_position (Current, index)
			end
		end
	
	-- MT_U8 --
	mt_get_byte_by_name, mtget_byte (attr_name: STRING): INTEGER is
		do
			if db /= Void then
				Result := db.get_byte_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_byte_by_position, mt_get_byte (index: INTEGER): INTEGER is
		do
			if db /= Void then
				Result := db.get_byte_of_object_by_position (Current, index)
			end
		end

	mt_get_byte_array_by_name, mtget_byte_array (attr_name: STRING): ARRAY [CHARACTER] is
		do
			if db /= Void then
				Result := db.get_byte_array_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_byte_array_by_position, mt_get_byte_array (index: INTEGER): ARRAY [CHARACTER] is
		do
			if db /= Void then
				Result := db.get_byte_array_of_object_by_position (Current, index)
			end
		end
	
	mt_get_byte_list_by_name, mtget_byte_list (attr_name: STRING): LINKED_LIST [CHARACTER] is
		do
			if db /= Void then
				Result := db.get_byte_list_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_byte_list_by_position, mt_get_byte_list (index: INTEGER): LINKED_LIST [CHARACTER] is
		do
			if db /= Void then
				Result := db.get_byte_list_of_object_by_position (Current, index)
			end
		end
	
	mt_get_byte_list_elements_by_position, mt_get_byte_list_elements (index: INTEGER; 
			buffer: ARRAY [CHARACTER]; count, offset: INTEGER): INTEGER is
			-- This routine eventually uses the MATISSE API MtGetListElts () which
			-- retrieves a subset of the list value of the attribute.
			-- This routine copies the 'count' number of list elements beginning from 
			-- the 'offset' into the 'buffer'. The first element of the stored list has the 
			-- offset 0. You may use as an offset Mt_Begin_Offset or Mt_Current_Offset
			-- which are defined in the class MT_CONSTANTS.
			-- This routine returns the number of elements copied into the 'buffer'.
		do
			if db /= Void then
				Result := db.get_byte_list_elements_of_object_by_position (Current, 
							index, buffer, count, offset)
			end
		end
		
	-- MT_FLOAT --
	mt_get_real_by_name, mtget_real (attr_name: STRING): REAL is
		do
			if db /= Void then
				Result := db.get_real_value_of_object_by_name (Current, attr_name)
			end
		end
	
	mt_get_real_by_position, mt_get_real (index: INTEGER): REAL is
		do
			if db /= Void then
				Result := db.get_real_value_of_object_by_position (Current, index)
			end
		end

	mt_get_real_array_by_name, mtget_real_array (attr_name: STRING): ARRAY [REAL] is
		do
			if db /= Void then
				Result := db.get_real_array_of_object_by_name (Current, attr_name)
			end
		end
	
	mt_get_real_array_by_position, mt_get_real_array (index: INTEGER): ARRAY [REAL] is
		do
			if db /= Void then
				Result := db.get_real_array_of_object_by_position (Current, index)
			end
		end

	mt_get_real_list_by_name, mtget_real_list (attr_name: STRING): LINKED_LIST [REAL] is
		do
			if db /= Void then
				Result := db.get_real_list_of_object_by_name (Current, attr_name)
			end
		end
	
	mt_get_real_list_by_position, mt_get_real_list (index: INTEGER): LINKED_LIST [REAL] is
		do
			if db /= Void then
				Result := db.get_real_list_of_object_by_position (Current, index)
			end
		end
		
	mt_get_double_by_name, mtget_double (attr_name: STRING): DOUBLE is
		do
			if db /= Void then
				Result := db.get_double_value_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_double_by_position, mt_get_double (index: INTEGER): DOUBLE is
		do
			if db /= Void then
				Result := db.get_double_value_of_object_by_position (Current, index)
			end
		end

	mt_get_double_array_by_name, mtget_double_array (attr_name: STRING): ARRAY [DOUBLE] is
		do
			if db /= Void then
				Result := db.get_double_array_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_double_array_by_position, mt_get_double_array (index: INTEGER): ARRAY [DOUBLE] is
		do
			if db /= Void then
				Result := db.get_double_array_of_object_by_position (Current, index)
			end
		end
	
	mt_get_double_list_by_name, mtget_double_list (attr_name: STRING): LINKED_LIST [DOUBLE] is
		do
			if db /= Void then
				Result := db.get_double_list_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_double_list_by_position, mt_get_double_list (index: INTEGER): LINKED_LIST [DOUBLE] is
		do
			if db /= Void then
				Result := db.get_double_list_of_object_by_position (Current, index)
			end
		end

	mt_get_character_by_name, mtget_character (attr_name: STRING): CHARACTER is
		do
			if db /= Void then
				Result := db.get_char_value_of_object_by_name (Current, attr_name)
			end
		end

	mt_get_character_by_position, mt_get_character (index: INTEGER): CHARACTER is
		do
			if db /= Void then
				Result := db.get_char_value_of_object_by_position (Current, index)
			end
		end
		
	mt_get_string_by_name, mtget_string (attr_name: STRING): STRING is
		do
			if db /= Void then
				Result := db.get_string_value_of_object_by_name (Current, attr_name)
			end
		end
	
	mt_get_string_by_position, mt_get_string (index: INTEGER): STRING is
		do
			if db /= Void then
				Result := db.get_string_value_of_object_by_position (Current, index)
			end
		end
	
	mt_get_string_array_by_name, mtget_string_array (attr_name: STRING): ARRAY [STRING] is
		do
			if db /= Void then
				Result := db.get_string_array_of_object_by_name (Current, attr_name)
			end
		end
	
	mt_get_string_array_by_position, mt_get_string_array (index: INTEGER): ARRAY [STRING] is
		do
			if db /= Void then
				Result := db.get_string_array_of_object_by_position (Current, index)
			end
		end
	
	mt_get_string_list_by_name, mtget_string_list (attr_name: STRING): LINKED_LIST [STRING] is
		do
			if db /= Void then
				Result := db.get_string_list_of_object_by_name (Current, attr_name)
			end
		end
	
	mt_get_string_list_by_position, mt_get_string_list (index: INTEGER): LINKED_LIST [STRING] is
		do
			if db /= Void then
				Result := db.get_string_list_of_object_by_position (Current, index)
			end
		end
		
	mt_remove_value_by_name, mtremove_value (attr_name: STRING) is
		do
			if db /= Void then
				db.remove_value_by_name (Current, attr_name)
			end
		end
	
	mt_remove_value_by_position, mt_remove_value (index: INTEGER) is
		local
		do
			if db /= Void then
				db.remove_value_by_position (Current, index)
			end
		end

	property_undefined (index: INTEGER; a_field_name: STRING) is
			-- The index-th field, whose field name is a_field_name, isn't defined
			-- as corresponding attribute/relationship in the current database.
			-- You can redefine this procedure in your own class.
		do
		end

feature {NONE} -- Update attribute

	mt_set_value (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_attribute_value (Current, field_index)
			end
		end
	
	mt_set_character (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_char_by_position (Current, field_index)
			end
		end
	
	mt_set_ascii_character (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_ascii_char_by_position (Current, field_index)
			end
		end
		
	mt_set_boolean (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_boolean_by_position (Current, field_index)
			end
		end
	
	mt_set_date (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_date_by_position (Current, field_index)
			end
		end
	
	mt_set_timestamp (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_timestamp_by_position (Current, field_index)
			end
		end
	
	mt_set_time_interval (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_time_interval_by_position (Current, field_index)
			end
		end
	
	mt_set_byte (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_byte_by_position (Current, field_index)
			end
		end
	
	mt_set_byte_array (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_byte_array_by_position (Current, field_index)
			end
		end

	mt_set_byte_list (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_byte_list_by_position (Current, field_index)
			end
		end
	
	mt_set_byte_list_elements (field_index: INTEGER; buffer: ARRAY [CHARACTER]; 
			buffer_size: INTEGER; offset: INTEGER; discard_after: BOOLEAN) is
			-- 'field_index'-th value is updated. Store the new value
			-- This routine eventually uses the MATISSE API MtSetListElts () which
			-- store the buffer content as a subset of the existing list value of the attribute.
			-- This routine copies the 'buffer_size' number of elements of 'buffer'
			-- into the list value at the offset 'offset'. The first element of the stored list has the 
			-- offset 0. You may use as an offset Mt_Begin_Offset, Mt_Current_Offset or 
			-- Mt_End_Offset which are defined in the class MT_CONSTANTS.
		do
			if db /= Void then
				db.set_byte_list_elements_by_position (Current, field_index, buffer, 
						buffer_size, offset, discard_after)
			end
		end
	
	mt_set_short (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_short_by_position (Current, field_index)
			end
		end
	
	mt_set_short_array (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_short_array_by_position (Current, field_index)
			end
		end

	mt_set_short_list (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_short_list_by_position (Current, field_index)
			end
		end
	
	mt_set_unsigned_short (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_unsigned_short_by_position (Current, field_index)
			end
		end
	
	mt_set_unsigned_short_array (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_unsigned_short_array_by_position (Current, field_index)
			end
		end
	
	mt_set_unsigned_short_list (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_unsigned_short_list_by_position (Current, field_index)
			end
		end

	mt_set_integer (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_integer_by_position (Current, field_index)
			end
		end
	
	mt_set_integer_array (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_integer_array_by_position (Current, field_index)
			end
		end
	
	mt_set_integer_list (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_integer_list_by_position (Current, field_index)
			end
		end
	
	mt_set_unsigned_integer (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_unsigned_integer_by_position (Current, field_index)
			end
		end
	
	mt_set_unsigned_integer_array (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_unsigned_integer_array_by_position (Current, field_index)
			end
		end
	
	mt_set_unsigned_integer_list (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_unsigned_integer_list_by_position (Current, field_index)
			end
		end
	
	mt_set_ascii_string (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_ascii_string_by_position (Current, field_index)
			end
		end
	
	mt_set_string (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_string_by_position (Current, field_index)
			end
		end
	
	mt_set_string_array (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_string_array_by_position (Current, field_index)
			end
		end
	
	mt_set_string_list (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_string_list_by_position (Current, field_index)
			end
		end
	
	mt_set_ascii_string_array (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_ascii_string_array_by_position (Current, field_index)
			end
		end
	
	mt_set_ascii_string_list (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_ascii_string_list_by_position (Current, field_index)
			end
		end
	
	mt_set_double (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_double_by_position (Current, field_index)
			end
		end
		
	mt_set_double_array (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_double_array_by_position (Current, field_index)
			end
		end
	
	mt_set_double_list (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_double_list_by_position (Current, field_index)
			end
		end
	
	mt_set_real (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_real_by_position (Current, field_index)
			end
		end
		
	mt_set_real_array (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_real_array_by_position (Current, field_index)
			end
		end
	
	mt_set_real_list (field_index: INTEGER) is
			-- 'field_index'-th value is updated. Store the new value.
		do
			if db /= Void then
				db.set_real_list_by_position (Current, field_index)
			end
		end
		
feature -- Accessing relationships

	mt_load_all_successors is
			-- Load successors of all relationships of the class.
		local
			c: MT_CLASS
		do
			if not relationships_loaded and then db /= Void then
				c := db.mt_class_from_object (Current)
				c.load_rs_successors_of_object (Current)
				loading_relationships_done
			end
		end		

	mt_get_successors_by_name (rs_name: STRING): MT_RS_CONTAINABLE is
			-- Return an array of successor objects of Current through
			-- the relationship specified by 'rs_name'.
		do
			if db /= Void then
				Result := db.get_rs_successors_by_name (Current, rs_name)
				Result.load_successors
			end
		end
	
	mt_get_successors_by_position (index: INTEGER): MT_RS_CONTAINABLE is
			-- Return an array of successor objects of Current through
			-- the relationship specified by 'rs_name'.
		do
			if db /= Void then
				Result := db.get_rs_successors_by_position (Current, index)
				Result.load_successors
			end
		end
	mt_get_successor_by_name (rs_name: STRING): MT_STORABLE is
			-- Return the first successor object of Current through
			-- the relationship specified by 'rs_name'.
			-- This is usually used to get a successor of 'sigle-relationship'.
		do
			if db /= Void then
				Result := db.get_rs_successor_by_name (Current, rs_name)
			end
		end

	mt_get_successor_by_position (index: INTEGER): MT_STORABLE is
			-- Same as 'mt_get_successor_by_name' except that relationship
			-- is specified by field position.
		do
			if db /= Void then
				Result := db.get_rs_successor_by_position (Current, index)
			end
		end

	mt_load_all_properties is
			-- Load both values of attributes and successors of relationships.
		local
			c: MT_CLASS
		do
			if not attributes_loaded and then db /= Void then
				c := db.mt_class_from_object (Current)
				c.load_attr_values_of_object (Current)
				loading_attrs_done
			end
			
			if not relationships_loaded and then db /= Void then
				if c = Void then
					c := db.mt_class_from_object (Current)
				end
				c.load_rs_successors_of_object (Current)
				loading_relationships_done
			end
		end
	
feature -- Deletion

	mt_remove is
			-- Delete the current object from the database.
		do
			if db /= Void then
				db.delete_object (Current)
			end
		end

feature {NONE} -- Update relationship

	mt_set_successor (field_index: INTEGER) is
			-- 'field_index'-th successor is updated. Store the new successor
		do
			if db /= Void then
				db.set_single_successor (Current, field_index)
			end
		end

	successor_appened (field_index: INTEGER; new_successor: MT_STORABLE) is
		do
			if db /= Void then
				db.append_successor (Current, field_index, new_successor)
			end
		end
	
feature {NONE} -- Implementation

	field_position_of (a_field_name: STRING): INTEGER is
		local
			i, count: INTEGER
		do
			count := field_count (Current)
			from
				i := 1
			until
				i > count or Result > 0
			loop
				if field_name (i, Current).is_equal (a_field_name) then
					Result := i
				end
				i := i + 1
			end
		end

feature {NONE} -- Attributes

	db: MATISSE

feature -- Status report

	attributes_loaded: BOOLEAN
	relationships_loaded: BOOLEAN

feature {MATISSE} -- Attributes

	is_obsolete: BOOLEAN

feature {MATISSE} -- Access from MATISSE

	set_db (a_db: MATISSE) is
		do
			db := a_db
		end
	
	set_oid (an_oid: INTEGER) is
		do
			oid := an_oid
		end
	
	become_obsolete is
		do
			is_obsolete := True
		end
	
	become_up_to_date is
		do
			is_obsolete := False
		end

feature {MT_CLASS, MATISSE} -- Access

	loading_attrs_done is
		do
			attributes_loaded := True
		end

 	loading_relationships_done is
		do
			relationships_loaded := True
		end

	attributes_unloaded is
		do
			attributes_loaded := False
		end

	relationships_unloaded is
		do
			relationships_loaded := False
		end

	predefined_eif_field (a_field_name: STRING): BOOLEAN is
			-- Is a_field_name an attribute defined in this class MT_STORABLE?
		do
			Result := a_field_name.is_equal ("oid") or
					a_field_name.is_equal ("db") or
					a_field_name.is_equal ("attributes_loaded") or
					a_field_name.is_equal ("relationships_loaded")
		end

feature -- Modification Mark

	mark_attrs_modified is
			-- One of the attributes of current object is modified.
			-- Set a mark of all-attributes-modification.
			-- When transaction is committed, the value is saved in a database.
		do
			if db /= Void then
				db.set_current_connection
				write_lock
				db.mark_attrs_modified (oid)
			end
		end

	mark_rls_modified is
			-- One of the relationships of current object is modified.
			-- Set a mark of all-relationships-modification.
			-- When transaction is committed, the successor objects are saved.
			-- in a database.
		do
			if db /= Void then
				db.set_current_connection
				write_lock
				mt_load_all_successors
				db.mark_rls_modified (oid)
			end
		end

feature {MT_ATTRIBUTE} -- Storing value

	want_to_set_value (an_attribute: MT_ATTRIBUTE): BOOLEAN is 
		once 
			Result := False
		end
	
	set_value_of_attribute (an_attribute: MT_ATTRIBUTE) is
			-- Default behavior.
			-- (Do nothing)
		do
		end

feature -- Access

	mt_generator: MT_CLASS is
			-- Class that has generated current object
		local
			all_classes: ARRAY [MT_CLASS]
			i: INTEGER
			found: BOOLEAN
			one_class: MT_CLASS
		do
			if db /= Void then
				Result := db.mt_class_from_object (Current)
			end
		end

feature -- Persistence

	is_persistent: BOOLEAN is
		-- Is the current object a persistent one?
		do
			Result := oid > 0
		end

	check_persistence (an_object: MT_STORABLE) is
			-- Is an_object a persistent object in the current_db?
			-- If yes, do nothing.
			-- If no, create new MATISSE object (using MtCreateObject),
			-- add an_object into cache of current_db, add oid of
			-- an_object into attr_modified_set and rl_modified_set.
		do
			if db /= Void then
				if an_object /= Void and then not db.has (an_object) then
					db.persist (an_object)
				end
			end
		end

	remove_from_cache is
			-- Discard the current object from the object table of current database
		do
			if db /= Void then
				db.safe_wean (Current)
			end
		end

	mt_make (a_class: MT_CLASS) is
			-- Initialize the current object as a persistent object.
			-- Assign an empty container to each multiple-relationship.
			-- This procedrue is called also when a transient object is
			-- promoted into a persistent one.
		require
			class_initiliazed: a_class.properties_initialized
		local
			relationships: ARRAY [MT_RELATIONSHIP]
			a_rs: MT_MULTI_RELATIONSHIP
			i: INTEGER
			a_rs_containable: MT_RS_CONTAINABLE
		do
			relationships := a_class.relationships
			from
				i := relationships.lower
			until
				i > relationships.upper
			loop
				a_rs ?= relationships.item (i)
				if a_rs /= Void and then field (a_rs.eif_field_index, Current) = Void then
					set_reference_field (a_rs.eif_field_index, Current, 
							a_rs.empty_container_for (Current))
				elseif a_rs /= Void then
					-- Added by SM, 04/15/99
					-- Without that, a list which is created in `Current'
					-- is not considered as persistent.
					a_rs_containable ?= field (a_rs.eif_field_index, Current)
					a_rs_containable.set_relationship (a_rs)
 					a_rs_containable.set_predecessor (Current)
				end
				i := i + 1
			end
			post_retrieved
		end

	post_retrieved is
			-- Descendant classes can redefine this procedure so that additional
			-- initialization can be done on some field, especially on "transient" fields.
		do
		end

feature -- Locking

	lock_composite (a_lock: INTEGER) is
		require
			a_lock_is_read_or_is_write: a_lock = Mt_Read or else a_lock = Mt_Write
		do
			if db /= Void then
				db.lock_composite (Current, a_lock)
			end
		end

feature {NONE} -- Constants of default initialization values

	Integer_default_value: INTEGER is 0
	Real_default_value: REAL is 0.0
	Double_default_value: DOUBLE is 0.0
	Character_default_value: CHARACTER is '%U'
	Boolean_default_value: BOOLEAN is False

invariant
	persistence: is_persistent implies db /= Void
		
end -- class MT_STORABLE


