indexing
	description: "External methods for class MT_ATTRIBUTE."

class 
	MT_ATTRIBUTE_EXTERNAL 

feature {NONE} -- Implementation MT_ATTRIBUTE

	c_get_attribute (name: POINTER): INTEGER is
			-- Use MtGetAttrinute.
		external 
			"C"
		end

	c_get_attribute_from_names (name, class_name: POINTER): INTEGER is
			-- Use MtGetClassAttrinute.
		external 
			"C"
		end

	c_check_attribute (aid, oid: INTEGER)  is
			-- Use Mt_CheckAttribute.
		external 
			"C"
		end

	c_get_dimension (oid, aid, rank: INTEGER): INTEGER is
			-- Use Mt_GetDimension.
		external 
			"C"
		end

	c_get_value (oid, aid: INTEGER)  is
			-- Use Mt_GetValue.
		external 
			"C"
		end

	c_value_type: INTEGER is
		external 
			"C"
		end

	c_get_byte_value: INTEGER is
		external 
			"C"
		end
	
	-- MT_S32 --
	c_get_integer_value: INTEGER is
		external 
			"C"
		end
	
	-- MT_U32 --
	c_get_unsigned_int_value: INTEGER is
		external 
			"C"
		end

	-- MT_S16 --
	c_get_short_value: INTEGER is
		external 
			"C"
		end
	
	-- MT__U16 --
	c_get_unsigned_short_value: INTEGER is
		external 
			"C"
		end
	
	c_get_double_value: DOUBLE is
		external 
			"C"
		end

	c_get_real_value: REAL is
		external 
			"C"
		end

	c_get_char_value: CHARACTER is
		external 
			"C"
		end

	c_get_string_value: POINTER is
		external 
			"C"
		end

	c_get_boolean_value: BOOLEAN is
		external 
			"C"
		end -- c_get_string_value
	
	-- MT_DATE --
	c_get_date_year: INTEGER is
		external 
			"C"
		end
	
	c_get_date_month: INTEGER is
		external 
			"C"
		end
	
	c_get_date_day: INTEGER is
		external 
			"C"
		end

	c_get_date_comp_days: INTEGER is
		external 
			"C"
		end
		
	-- MT_TIMESTAMP --
	c_get_timestamp_hour: INTEGER is
		external 
			"C"
		end

	c_get_timestamp_minute: INTEGER is
		external 
			"C"
		end
	
	c_get_timestamp_second: INTEGER is
		external 
			"C"
		end

	c_get_timestamp_comp_seconds: INTEGER is
		external 
			"C"
		end
		
	c_get_timestamp_microsecs: INTEGER is
		external 
			"C"
		end
	
	-- MT_TIMEINTERVAL --
	c_get_time_interval_days: INTEGER is
		external 
			"C"
		end
	
	c_get_time_interval_millisecs: INTEGER is
		external 
			"C"
		end
	
	c_get_time_interval_fine_seconds: DOUBLE is
		external 
			"C"
		end
	
	c_free_value is
		external 
			"C"
		end -- c_free_value
	
	c_ith_list_character (i:INTEGER): CHARACTER is
		external 
			"C"
		end

	c_ith_list_integer (i:INTEGER): INTEGER is
			-- MT_S32
		external 
			"C"
		end
	
	c_ith_list_unsigned_int (i:INTEGER): INTEGER is
			-- MT_U32
		external 
			"C"
		end

	c_ith_list_short (i:INTEGER): INTEGER is
			-- MT_S16
		external 
			"C"
		end

	c_ith_list_unsigned_short (i:INTEGER): INTEGER is
			-- MT_U16
		external 
			"C"
		end

	c_ith_list_double (i:INTEGER): DOUBLE is
		external 
			"C"
		end

	c_ith_list_real (i:INTEGER): REAL is
		external 
			"C"
		end

	c_ith_list_string (i:INTEGER): POINTER is
		external 
			"C"
		end

	c_set_value_integer (oid, aid, type, value, rank: INTEGER) is
		external 
			"C"
		end

	c_set_value_u8 (oid, aid, value: INTEGER) is
		external 
			"C"
		end
	
	c_set_value_s16 (oid, aid, value: INTEGER) is
		external 
			"C"
		end
	
	c_set_value_u16 (oid, aid, value: INTEGER) is
		external 
			"C"
		end
	
	c_set_value_u32 (oid, aid, value: INTEGER) is
		external 
			"C"
		end
		
	c_set_value_double (oid, aid, type: INTEGER; value: DOUBLE; rank: INTEGER) is
		external 
			"C"
		end 

	c_set_value_real (oid, aid, type: INTEGER; value: REAL; rank: INTEGER) is
		external 
			"C"
		end 

	c_set_value_char (oid, aid, type: INTEGER; value: CHARACTER; rank: INTEGER) is
		external 
			"C"
		end
	
	c_set_value_boolean (oid, aid: INTEGER; value: BOOLEAN) is
		external 
			"C"
		end
	
	c_set_value_date (oid, aid: INTEGER; year, month, day: INTEGER) is
		external 
			"C"
		end
	
	c_set_value_timestamp (oid, aid, year, month, day, hour, minute, second, microsec: INTEGER) is
		external 
			"C"
		end
	
	c_set_value_time_interval (oid, aid: INTEGER; days: INTEGER; fine_second: DOUBLE) is
		external 
			"C"
		end
	
	c_set_value_string (oid, aid, type: INTEGER; value: POINTER; rank: INTEGER) is
		external 
			"C"
		end

	c_set_value_array_numeric (oid, aid, type: INTEGER; value: POINTER; rank: INTEGER) is
		external 
			"C"
		end 

--	c_set_value_byte_array (oid, aid, type: INTEGER; value: POINTER; rank: INTEGER) is
--		external 
--			"C"
--		end 

	c_set_value_short_array (oid, aid, type: INTEGER; value: POINTER; rank: INTEGER) is
		external 
			"C"
		end 
	
	c_set_value_unsigned_short_array (oid, aid, type: INTEGER; value: POINTER; rank: INTEGER) is
		external 
			"C"
		end 
	
	c_set_value_void (oid, aid, type: INTEGER; value: POINTER; rank: INTEGER) is
		external 
			"C"
		end 

	c_type_value (aid: INTEGER): INTEGER is
		external 
			"C"
		end

	c_get_num_and_types (aid: INTEGER): INTEGER is
		external 
			"C"
		end
	
	c_set_value_byte_list_elements (oid, aid, type: INTEGER; buffer: POINTER; 
			count, offset: INTEGER; discard_after: BOOLEAN) is
		external 
			"C"
		end
	
	c_get_byte_list_elements (oid, aid: INTEGER; buffer: POINTER; count, offset: INTEGER): INTEGER is
		external 
			"C"
		end
	
end -- class MT_ATTRIBUTE_EXTERNAL
