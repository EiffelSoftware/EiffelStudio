class 
	MT_ATTRIBUTE

inherit 
	MT_PROPERTY
		rename 
			id as aid
		redefine 
			predefined_eif_field
		end

	MT_EXCEPTIONS
		export
			{NONE}	all;
			{ANY}	Mt_Nil, Mt_s32, Mt_Double, Mt_Float, Mt_Char, Mt_Asciichar,
				Mt_String, Mt_Asciistring, 
				Mt_S32_List, Mt_Double_List, Mt_Float_List, Mt_String_List, Mt_Asciistring_List,
				Mt_S32_Array, Mt_Double_Array, Mt_Float_Array, Mt_String_Array,
				Mt_Asciistring_Array, Mt_U8_Array,
				Mt_Date, Mt_Timestamp, Mt_Time_Interval
		undefine 
			is_equal
		end

	MT_ATTRIBUTE_EXTERNAL
		undefine 
			is_equal
		end
	
creation
	make, make_from_names, make_from_id

feature {NONE} -- Initialization

	make (attribute_name: STRING) is
			-- Get attribute from database.
			-- If `attribute_name' not unique, an error is raised.
		require
			attribute_not_void: attribute_name /= Void
			attribute_not_empty: not attribute_name.is_empty
		local
			c_attribute_name: ANY
		do
			c_attribute_name := attribute_name.to_c
			oid := c_get_attribute ($c_attribute_name)
		end

	make_from_names (attribute_name, cl_name: STRING) is
			-- Get attribute from database.
		require
			attribute_not_void: attribute_name /= Void
			attribute_not_empty: not attribute_name.is_empty
			cl_not_void: cl_name /= Void
			cl_not_empty: not cl_name.is_empty
		local
			c_attribute_name: ANY
			c_cl_name: ANY
		do
			c_attribute_name := attribute_name.to_c
			c_cl_name := cl_name.to_c
			oid := c_get_attribute_from_names ($c_attribute_name, $c_cl_name)
		end

feature {NONE} -- Initialization

	make_from_id (attribute_id: INTEGER) is
			-- Create attribute with its id. 
		do
			oid := attribute_id
		end

feature -- Access

	dimension (one_object: MT_OBJECT; rank: INTEGER): INTEGER is
			-- Dimension of current attribute.
			-- When the value of the attribute is an array, returns the size of the
			-- array for the dimension rank.
			-- If the attribute value is a list, rank must be equal to 0 and dimension 
			-- gives the number of elements in the list.
		require
			rank_positive_or_null: rank >= 0
		do
			Result := c_get_dimension (one_object.oid, oid, rank)
		end

	get_value (an_obj: MT_OBJECT): ANY is
		do
			if mt_type = 0 then 
				-- Attribute type could be any, i.e. type is unspecified
				c_get_value (an_obj.oid, oid)
				Result := get_value_of_mt_type (an_obj, c_value_type)
			else
				Result := get_value_of_mt_type (an_obj, mt_type)
			end
		end
	
	get_value_of_mt_type (an_obj: MT_OBJECT; a_type: INTEGER): ANY is
		do
			inspect a_type
			when Mt_Boolean then
				Result := get_boolean (an_obj)
			when Mt_Timestamp then
				Result := get_timestamp (an_obj)
			when Mt_Date then
				Result := get_date (an_obj)
			when Mt_Time_Interval then
				Result := Void
			when Mt_u8 then
				Result := get_byte (an_obj)
			when Mt_u8_list  then
				Result := get_byte_list (an_obj)
			when Mt_s16  then
				Result := get_short (an_obj)
			when Mt_s16_list then
				Result := get_short_list (an_obj)
			when Mt_u16  then
				Result := get_unsigned_short (an_obj)
			when Mt_u16_list then
				Result := get_unsigned_short_list (an_obj)
			when Mt_s32  then
				Result := get_integer (an_obj)
			when Mt_u32  then
				Result := get_unsigned_int (an_obj)
			when Mt_u32_list then
				Result := get_unsigned_int_list (an_obj)
			when Mt_Asciichar  then
				Result := get_character (an_obj)
			when Mt_Char  then
				Result := get_character (an_obj)
			when Mt_Double  then
				Result := get_double (an_obj)
			when Mt_Nil  then
				Result := Void
			when Mt_S32_List  then
				Result := get_integer_list (an_obj)
			when Mt_Double_List  then
				Result := get_double_list (an_obj)
			when Mt_Asciistring_List  then
				Result := get_string_list (an_obj)
			when Mt_String_List  then
				Result := get_string_list (an_obj)
			when Mt_Asciistring  then
				Result := get_string (an_obj)
			when Mt_String  then
				Result := get_string (an_obj)
			when Mt_U8_Array  then
				Result := get_byte_array (an_obj)
			when Mt_S16_Array  then
				Result := get_short_array (an_obj)
			when Mt_U16_Array  then
				Result := get_unsigned_short_array (an_obj)
			when Mt_S32_Array  then
				Result := get_integer_array (an_obj)
			when Mt_u32_array  then
				Result := get_unsigned_int_array (an_obj)
			when Mt_Double_Array  then
				Result := get_double_array (an_obj)
			when Mt_String_Array  then
				Result := get_string_array (an_obj)
			when Mt_Asciistring_Array  then
				Result := get_string_array (an_obj)
			when Mt_Float_Array  then
				Result := get_real_array (an_obj)
			when Mt_Float  then
				Result := get_real (an_obj)
			when Mt_Float_List  then
				Result := get_real_list (an_obj)
			else
			end
		end

feature -- Status Report

	check_attribute (one_object: MT_OBJECT): BOOLEAN is
			-- Check if attribute is correct in 'one_object'.
		do
			c_check_attribute (oid, one_object.oid)
		end -- check

	type: INTEGER is
			-- Attribute type in Matisse (see MT_CONSTANTS).
		do
			Result := c_type_value (oid)
		end -- type

	dynamic_att_type (an_obj: MT_OBJECT): INTEGER is
			-- This is useful when the current attribute has multiple available types.
			-- Result is one of the MATISSE attribute types.
		do
			c_get_value (an_obj.oid, oid)
			Result := c_value_type
		end
	
feature -- Element Change

	set_value_not_default (an_object: MT_STORABLE) is
			-- If the field value is not default value, store the value to the database.
		local
			a_value: ANY
			default_real: REAL
		do
			if an_object.want_to_set_value (Current) then
				an_object.set_value_of_attribute (Current)
			else
				a_value := field (eif_field_index, an_object)
				if a_value /= Void then
					inspect mt_type
					when Mt_Boolean then
						set_boolean (an_object)
					when Mt_Timestamp then
						set_timestamp (an_object)
					when Mt_Date then
						set_date (an_object)
					when Mt_Time_Interval then
						set_time_interval (an_object)
					when Mt_u8 then
						set_byte (an_object)
					when Mt_U8_List  then
						set_byte_list (an_object)
					when Mt_s16  then
						set_short (an_object)
					when Mt_S16_List then
						set_short_list (an_object)
					when Mt_u16  then
						set_unsigned_short (an_object)
					when Mt_U16_List then
						set_unsigned_short_list (an_object)
					when Mt_s32  then
						set_integer (an_object)
					when Mt_u32  then
						set_unsigned_integer (an_object)
					when Mt_u32_list then
						set_unsigned_integer_list (an_object)
					when Mt_Asciichar  then
						set_ascii_character (an_object)
					when Mt_Char  then
						set_character (an_object)
					when Mt_Double  then
						set_double (an_object)
					when Mt_Nil  then
					when Mt_S32_List  then
						set_integer_list (an_object)
					when Mt_Double_List  then
						set_double_list (an_object)
					when Mt_Asciistring_List  then
						set_string_list (an_object, Mt_Asciistring_List)
					when Mt_String_List  then
						set_string_list (an_object, Mt_String_List)
					when Mt_Asciistring  then
						set_string (an_object, Mt_Asciistring)
					when Mt_String  then
						set_string (an_object, Mt_String)
					when Mt_U8_Array  then
						set_byte_array (an_object)
					when Mt_S16_Array  then
						set_short_array (an_object)
					when Mt_U16_Array  then
						set_unsigned_short_array (an_object)
					when Mt_S32_Array  then
						set_integer_array (an_object)
					when Mt_U32_Array  then
						set_unsigned_integer_array (an_object)
					when Mt_Double_Array  then
						set_double_array (an_object)
					when Mt_String_Array  then
						set_string_array (an_object, Mt_String_Array)
					when Mt_Asciistring_Array  then
						set_string_array (an_object, Mt_Asciistring_Array)
					when Mt_Float_Array  then
						set_real_array (an_object)
					when Mt_Float  then
						set_real (an_object)
					when Mt_Float_List  then
						set_real_list (an_object)
					end -- inspect
				end -- if a_value /= Void
			end
		end
	
	set_dynamic_value (an_object: MT_STORABLE; value: ANY) is
		local
			an_int: INTEGER_REF
			a_real: REAL_REF
			a_double: DOUBLE_REF
			a_boolean: BOOLEAN_REF
			a_string: STRING
			int_array: ARRAY [INTEGER]
			real_array: ARRAY [REAL]
			double_array: ARRAY [DOUBLE]
			string_array: ARRAY [STRING]
			int_list: LINKED_LIST [INTEGER]
			real_list: LINKED_LIST [REAL]
			double_list: LINKED_LIST [DOUBLE]
			string_list: LINKED_LIST [STRING]
			a_date: DATE
			a_date_time: DATE_TIME
			a_duration: DATE_TIME_DURATION
			value_type: INTEGER
		do
			if an_object.want_to_set_value (Current) then
				an_object.set_value_of_attribute (Current)
			else
				value_type := dynamic_type (value)
				if value_type = Eif_integer_type then
					an_int ?= value
					set_integer_value (an_object, an_int.item)
				elseif value_type = Eif_real_type then
					a_real ?= value
					set_real_value (an_object, a_real.item)
				elseif value_type = Eif_double_type then
					a_double ?= value
					set_double_value (an_object, a_double.item)
				elseif value_type = Eif_string_type then
					a_string ?= value
					set_string_value (an_object, Mt_String, a_string)
				elseif value_type = Eif_boolean_type then
					a_boolean ?= value
					set_boolean_value (an_object, a_boolean.item)
				elseif value_type = Eif_integer_array_type then
					int_array ?= value
					inspect dynamic_att_type (an_object)
					when Mt_U16_Array then
						set_unsigned_short_array_value (an_object, int_array)
					when Mt_S16_Array then
						set_short_array_value (an_object, int_array)
					when Mt_U32_Array then
						set_unsigned_integer_array_value (an_object, int_array)
					when Mt_S32_Array then
						set_integer_array_value (an_object, int_array)
					else
						set_integer_array_value (an_object, int_array)
					end
				elseif value_type = Eif_real_array_type then
					real_array ?= value
					set_real_array_value (an_object, real_array)
				elseif value_type = Eif_double_array_type then
					double_array ?= value
					set_double_array_value (an_object, double_array)
				elseif value_type = Eif_string_array_type then
					string_array ?= value
					set_string_array_value (an_object, Mt_String_Array, string_array)
				elseif value_type = Eif_integer_list_type then
					int_list ?= value
					set_integer_list_value (an_object, int_list)
				elseif value_type = Eif_real_list_type then
					real_list ?= value
					set_real_list_value (an_object, real_list)
				elseif value_type = Eif_double_list_type then
					double_list ?= value
					set_double_list_value (an_object, double_list)
				elseif value_type = Eif_string_list_type then
					string_list ?= value
					set_string_list_value (an_object, Mt_String_List, string_list)
				elseif value_type = Eif_date_type then
					a_date ?= value
					set_date_value (an_object, a_date)
				elseif value_type = Eif_date_time_type then -- Mt_Timestamp
					a_date_time ?= value
					set_timestamp_value (an_object, a_date_time)
				elseif value_type = Eif_date_time_duration_type then -- Mt_Time_Interval
					a_duration ?= value
					set_time_interval_value (an_object, a_duration)
				else
					trigger_dev_exception (100000012, "")
				end

			end
		end
	
	set_value (an_object: MT_STORABLE) is
		do
			if an_object.want_to_set_value (Current) then
				an_object.set_value_of_attribute (Current)
			else
				inspect mt_type
				when Mt_Boolean then
					set_boolean (an_object)
				when Mt_Timestamp then
					set_timestamp (an_object)
				when Mt_Date then
					set_date (an_object)
				when Mt_Time_Interval then
					set_time_interval (an_object)
				when Mt_U8 then
					set_byte (an_object)
				when Mt_U8_list  then
					set_byte_list (an_object)
				when Mt_s16  then
					set_short (an_object)
				when Mt_S16_List then
					set_short_list (an_object)
				when Mt_u16  then
					set_unsigned_short (an_object)
				when Mt_U16_List then
					set_unsigned_short_list (an_object)
				when Mt_s32  then
					set_integer (an_object)
				when Mt_u32  then
					set_unsigned_integer (an_object)
				when Mt_u32_list then
					set_unsigned_integer_list (an_object)
				when Mt_Asciichar  then
					set_ascii_character (an_object)
				when Mt_Char  then
					set_character (an_object)
				when Mt_Double  then
					set_double (an_object)
				when Mt_Nil  then
				when Mt_S32_List  then
					set_integer_list (an_object)
				when Mt_Double_List  then
					set_double_list (an_object)
				when Mt_Asciistring_List  then
					set_string_list (an_object, Mt_Asciistring_List)
				when Mt_String_List  then
					set_string_list (an_object, Mt_String_List)
				when Mt_Asciistring  then
					set_string (an_object, Mt_Asciistring)
				when Mt_String  then
					set_string (an_object, Mt_String)
				when Mt_U8_array  then
					set_byte_array (an_object)
				when Mt_S16_Array  then
					set_short_array (an_object)
				when Mt_U16_Array  then
					set_unsigned_short_array (an_object)
				when Mt_S32_Array  then
					set_integer_array (an_object)
				when Mt_U32_Array  then
					set_unsigned_integer_array (an_object)
				when Mt_Double_Array  then
					set_double_array (an_object)
				when Mt_String_Array  then
					set_string_array (an_object, Mt_String_Array)
				when Mt_Asciistring_Array  then
					set_string_array (an_object, Mt_Asciistring_Array)
				when Mt_Float_Array  then
					set_real_array (an_object)
				when Mt_Float  then
					set_real (an_object)
				when Mt_Float_List  then
					set_real_list (an_object)
				else
				end -- inspect
			end
		end

	set_character (an_object: MT_STORABLE) is
		local
			new_value: CHARACTER
		do
			new_value := character_field (eif_field_index, an_object)
			c_set_value_char (an_object.oid, oid, Mt_Char, new_value, 0)
		end
		
	set_ascii_character (an_object: MT_STORABLE) is
		local
			new_value: CHARACTER
		do
			new_value := character_field (eif_field_index, an_object)
			c_set_value_char (an_object.oid, oid, Mt_Asciichar, new_value, 0)
		end
	
	set_boolean (an_object: MT_STORABLE) is
		local
			new_value: BOOLEAN
		do
			new_value := boolean_field (eif_field_index, an_object)
			c_set_value_boolean (an_object.oid, oid, new_value)
		end

	set_boolean_value (an_object: MT_STORABLE; new_value: BOOLEAN) is
		do
			c_set_value_boolean (an_object.oid, oid, new_value)
		end
	
	set_date (an_object: MT_STORABLE) is
		local
			new_date: DATE
		do
			new_date ?= field (eif_field_index, an_object)
			set_date_value (an_object, new_date)
		end
	
	set_date_value (an_object: MT_STORABLE; new_date: DATE) is
		do
			if new_date = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				c_set_value_date (an_object.oid, oid, new_date.year, new_date.month, new_date.day)
			end
		end
	
	set_timestamp (an_object: MT_STORABLE) is
		local
			new_time: DATE_TIME
		do
			new_time ?= field (eif_field_index, an_object)
			set_timestamp_value (an_object, new_time)
		end

	set_timestamp_value (an_object: MT_STORABLE; new_time: DATE_TIME) is
		local
			microsecond: INTEGER
		do
			if new_time = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				microsecond := (new_time.fractional_second * 1000000).floor
				c_set_value_timestamp (an_object.oid, oid, 
						new_time.year, new_time.month, new_time.day,
						new_time.hour, new_time.minute, new_time.second,
						microsecond)
			end
		end
	
	set_time_interval (an_object: MT_STORABLE) is
		local
			new_interval: DATE_TIME_DURATION
		do
			new_interval ?= field (eif_field_index, an_object)
			set_time_interval_value (an_object, new_interval)
		end
	
	set_time_interval_value (an_object: MT_STORABLE; new_interval: DATE_TIME_DURATION) is
		local
			days: INTEGER
			fine_seconds: DOUBLE
		do
			if new_interval = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				days := new_interval.day
				fine_seconds := new_interval.fine_seconds_count
	
				if days > 0 and fine_seconds < 0 then
					days := days - 1
					fine_seconds := fine_seconds + (3600 * 24)
				elseif days < 0 and fine_seconds > 0 then
					days := days + 1
					fine_seconds := fine_seconds - (3600 * 24)
				end
					check days * fine_seconds >= 0 end
				
				c_set_value_time_interval (an_object.oid, oid, days, fine_seconds)
			end
		end
	
	set_byte (an_object: MT_STORABLE) is
		local
			new_value: INTEGER
		do
			new_value := integer_field (eif_field_index, an_object)
			c_set_value_u8 (an_object.oid, oid, new_value)
		end
	
	set_byte_array (an_object: MT_STORABLE) is
		local
			an_array: ARRAY [CHARACTER]
		do
			an_array ?= field (eif_field_index, an_object)
			if an_array = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if an_array.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_U8_array, $Void, 0)
				else
					c_set_value_array_numeric (an_object.oid, oid, Mt_U8_array, $an_array, 1)
				end
			end
		end
	
	set_byte_list (an_object: MT_STORABLE) is
		local
			a_byte_array: ARRAY [CHARACTER]
			a_byte_list: LINKED_LIST [CHARACTER]
			i: INTEGER
		do
			a_byte_list ?= field (eif_field_index, an_object)
			if a_byte_list = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if a_byte_list.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_U8_List, $Void, 0)
				else
					!! a_byte_array.make (1, a_byte_list.count)
					from 
						a_byte_list.start  
						i := 1
					until 
						a_byte_list.off
					loop
						a_byte_array.put (a_byte_list.item, i)
						a_byte_list.forth
						i := i + 1
					end
					c_set_value_array_numeric (an_object.oid, oid, Mt_U8_List, $a_byte_array, 1)
				end
			end
		end
	
	set_byte_list_elements (an_object: MT_STORABLE; buffer: ARRAY [CHARACTER]; 
			buffer_size: INTEGER; offset: INTEGER; discard_after: BOOLEAN) is
		local
			i: INTEGER
			to_c: ANY
		do
			if buffer = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if buffer.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_U8_List, $Void, 0)
				else
					to_c := buffer.to_c
					c_set_value_byte_list_elements (an_object.oid, oid, Mt_U8_List, 
						$to_c, buffer_size, offset, discard_after)
				end
			end
		end
	
	set_short (an_object: MT_STORABLE) is
		local
			new_value: INTEGER
		do
			new_value := integer_field (eif_field_index, an_object)
			c_set_value_s16 (an_object.oid, oid, new_value)
		end
	
	set_short_array (an_object: MT_STORABLE) is
		local
			an_array: ARRAY [INTEGER]
		do
			an_array ?= field (eif_field_index, an_object)
			set_short_array_value (an_object, an_array)
		end
	
	set_short_array_value (an_object: MT_STORABLE; an_array: ARRAY [INTEGER]) is
		do
			if an_array = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if an_array.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_S16_Array, $Void, 0)
				else
					c_set_value_short_array (an_object.oid, oid, Mt_S16_Array, $an_array, 1)
				end
			end
		end
	
	set_short_list (an_object: MT_STORABLE) is
		local
			a_short_array: ARRAY [INTEGER]
			a_short_list: LINKED_LIST [INTEGER]
			i: INTEGER
		do
			a_short_list ?= field (eif_field_index, an_object)
			if a_short_list = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if a_short_list.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_S16_List, $Void, 0)
				else
					!! a_short_array.make (1, a_short_list.count)
					from 
						a_short_list.start  
						i := 1
					until 
						a_short_list.off
					loop
						a_short_array.put (a_short_list.item, i)
						a_short_list.forth
						i := i + 1
					end
					c_set_value_short_array (an_object.oid, oid, Mt_S16_List, $a_short_array, 1)
				end
			end
		end
	
	set_unsigned_short (an_object: MT_STORABLE) is
		local
			new_value: INTEGER
		do
			new_value := integer_field (eif_field_index, an_object)
			c_set_value_u16 (an_object.oid, oid, new_value)
		end

	set_unsigned_short_array (an_object: MT_STORABLE) is
		local
			an_array: ARRAY [INTEGER]
		do
			an_array ?= field (eif_field_index, an_object)
			set_unsigned_short_array_value (an_object, an_array)
		end
	
	set_unsigned_short_array_value (an_object: MT_STORABLE; an_array: ARRAY [INTEGER]) is
		do
			if an_array = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if an_array.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_U16_Array, $Void, 0)
				else
					c_set_value_unsigned_short_array (an_object.oid, oid, Mt_U16_Array, $an_array, 1)
				end
			end
		end
	
	set_unsigned_short_list (an_object: MT_STORABLE) is
		local
			an_integer_array: ARRAY [INTEGER]
			an_integer_list: LINKED_LIST [INTEGER]
			i: INTEGER
		do
			an_integer_list ?= field (eif_field_index, an_object)
			if an_integer_list = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if an_integer_list.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_U16_List, $Void, 0)
				else
					!! an_integer_array.make (1, an_integer_list.count)
					from 
						an_integer_list.start 
						i := 1
					until 
						an_integer_list.off
					loop
						an_integer_array.put (an_integer_list.item, i)
						an_integer_list.forth
						i := i + 1
					end
					c_set_value_unsigned_short_array (an_object.oid, oid, Mt_U16_List, $an_integer_array, 1)
				end
			end
		end

	set_integer (an_object: MT_STORABLE) is
		local
			new_value: INTEGER
		do
			new_value := integer_field (eif_field_index, an_object)
			c_set_value_integer (an_object.oid, oid, Mt_s32, new_value, 0)
		end
	
	set_integer_value (an_object: MT_STORABLE; value: INTEGER) is
		do
			c_set_value_integer (an_object.oid, oid, Mt_s32, value, 0)
		end
	
	set_integer_array (an_object: MT_STORABLE) is
		local
			an_array: ARRAY [INTEGER]
		do
			an_array ?= field (eif_field_index, an_object)
			set_integer_array_value (an_object, an_array)
		end
	
	set_integer_array_value (an_object: MT_STORABLE; value: ARRAY [INTEGER]) is
		do
			if value = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if value.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_S32_Array, $Void, 0)
				else
					c_set_value_array_numeric (an_object.oid, oid, Mt_S32_Array, $value, 1)
				end
			end
		end
		
	set_integer_list (an_object: MT_STORABLE) is
		local
			an_integer_array: ARRAY [INTEGER]
			an_integer_list: LINKED_LIST [INTEGER]
			i: INTEGER
		do
			an_integer_list ?= field (eif_field_index, an_object)
			set_integer_list_value (an_object, an_integer_list)
		end
	
	set_integer_list_value (an_object: MT_STORABLE; value: LINKED_LIST [INTEGER]) is
		local
			an_integer_array: ARRAY [INTEGER]
			i: INTEGER
		do
			if value = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if value.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_S32_List, $Void, 0)
				else
					!! an_integer_array.make (1, value.count)
					from 
						value.start  
						i := 1
					until 
						value.off
					loop
						an_integer_array.put (value.item, i)
						value.forth
						i := i + 1
					end
					c_set_value_array_numeric (an_object.oid, oid, Mt_S32_List, $an_integer_array, 1)
				end
			end
		end
	set_unsigned_integer (an_object: MT_STORABLE) is
		local
			new_value: INTEGER
		do
			new_value := integer_field (eif_field_index, an_object)
			c_set_value_u32 (an_object.oid, oid, new_value)
		end
	
	set_unsigned_integer_array (an_object: MT_STORABLE) is
		local
			an_array: ARRAY [INTEGER]
		do
			an_array ?= field (eif_field_index, an_object)
			set_unsigned_integer_array_value (an_object, an_array)
		end
	
	set_unsigned_integer_array_value (an_object: MT_STORABLE; an_array: ARRAY [INTEGER]) is
		do
			if an_array = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if an_array.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_U32_Array, $Void, 0)
				else
					c_set_value_array_numeric (an_object.oid, oid, Mt_U32_Array, $an_array, 1)
				end
			end
		end
	
	set_unsigned_integer_list (an_object: MT_STORABLE) is
		local
			an_integer_array: ARRAY [INTEGER]
			an_integer_list: LINKED_LIST [INTEGER]
			i: INTEGER
		do
			an_integer_list ?= field (eif_field_index, an_object)
			if an_integer_list = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if an_integer_list.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_u32_list, $Void, 0)
				else
					!! an_integer_array.make (1, an_integer_list.count)
					from 
						an_integer_list.start  
						i := 1
					until 
						an_integer_list.off
					loop
						an_integer_array.put (an_integer_list.item, i)
						an_integer_list.forth
						i := i + 1
					end
					c_set_value_array_numeric (an_object.oid, oid, Mt_u32_list, $an_integer_array, 1)
				end
			end
		end
	
	set_string (an_object: MT_STORABLE; a_mt_type: INTEGER) is
		require
			mt_type: a_mt_type = Mt_Asciistring or a_mt_type = Mt_String
		local
			new_value: STRING
		do
			new_value ?= field (eif_field_index, an_object)
			set_string_value (an_object, a_mt_type, new_value)
		end
	
	set_string_value (an_object: MT_STORABLE; a_mt_type: INTEGER; value: STRING) is
		require
			mt_type: a_mt_type = Mt_Asciistring or a_mt_type = Mt_String
		local
			c_string: ANY
		do
			if value = Void then
				c_set_value_string (an_object.oid, oid, a_mt_type, $Void, 0)
			else
				c_string := value.to_c
				c_set_value_string (an_object.oid, oid, a_mt_type, $c_string, 0)
			end
		end
	
	set_string_array (an_object: MT_STORABLE; a_mt_type: INTEGER) is
		require
			mt_type: a_mt_type = Mt_Asciistring_Array or a_mt_type = Mt_String_Array
		local
			c_string: ANY
			an_array_pointer: ARRAY [POINTER]
			a_string_array: ARRAY [STRING]
			i: INTEGER
			is_gc_on: BOOLEAN
		do
			a_string_array ?= field (eif_field_index, an_object)
			set_string_array_value (an_object, a_mt_type, a_string_array)
		end
	
	set_string_array_value (an_object: MT_STORABLE; a_mt_type: INTEGER; a_string_array: ARRAY [STRING]) is
		require
			mt_type: a_mt_type = Mt_Asciistring_Array or a_mt_type = Mt_String_Array
		local
			c_string: ANY
			an_array_pointer: ARRAY [POINTER]
			i: INTEGER
			is_gc_on: BOOLEAN
		do
			if a_string_array = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if a_string_array.count = 0 then
					c_set_value_void (an_object.oid, oid, a_mt_type, $Void, 0)
				else
					!! an_array_pointer.make (1, a_string_array.count)  
					from 
						i := a_string_array.lower
					until 
						i > a_string_array.upper
					loop
						if a_string_array.item (i) = Void then
							an_array_pointer.put ($Void, i)
						else
							c_string := a_string_array.item (i).to_c
							an_array_pointer.put ($c_string, i)
						end
						i:= i + 1
					end
					c_set_value_array_numeric (an_object.oid, oid, a_mt_type, $an_array_pointer, 1)
				end
			end
		end
	
	set_string_list (an_object: MT_STORABLE; a_mt_type: INTEGER) is
		require
			mt_type: a_mt_type = Mt_Asciistring_List or a_mt_type = Mt_String_List
		local
			c_string: ANY
			an_array_pointer: ARRAY [POINTER]
			a_string_list: LINKED_LIST [STRING]
			i: INTEGER
			is_gc_on: BOOLEAN
		do
			a_string_list ?= field (eif_field_index, an_object)
			set_string_list_value (an_object, a_mt_type, a_string_list)
		end
	
	set_string_list_value (an_object: MT_STORABLE; a_mt_type: INTEGER; a_string_list: LINKED_LIST [STRING]) is
		require
			mt_type: a_mt_type = Mt_Asciistring_List or a_mt_type = Mt_String_List
		local
			c_string: ANY
			an_array_pointer: ARRAY [POINTER]
			i: INTEGER
			is_gc_on: BOOLEAN
		do
			if a_string_list = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if a_string_list.count = 0 then
					c_set_value_void (an_object.oid, oid, a_mt_type, $Void, 0)
				else
					!! an_array_pointer.make (1, a_string_list.count)  
					from 
						a_string_list.start  
						i := 1
					until 
						a_string_list.off
					loop
						if a_string_list.item = Void then
							an_array_pointer.put ($Void, i)
						else
							c_string := a_string_list.item.to_c
							an_array_pointer.put ($c_string, i)
						end
						a_string_list.forth
						i := i + 1
					end
					c_set_value_array_numeric (an_object.oid, oid, a_mt_type, $an_array_pointer, 1)
				end
			end
		end
	
	set_double (an_object: MT_STORABLE) is
		local
			a_double: DOUBLE
		do
			a_double := double_field (eif_field_index, an_object)
			c_set_value_double (an_object.oid, oid, Mt_Double, a_double, 0)
		end
	
	set_double_value (an_object: MT_STORABLE; value: DOUBLE) is
		do
			c_set_value_double (an_object.oid, oid, Mt_Double, value, 0)
		end
		
	set_double_array (an_object: MT_STORABLE) is
		local
			a_double_array: ARRAY [DOUBLE]
		do
			a_double_array ?= field (eif_field_index, an_object)
			set_double_array_value (an_object, a_double_array)
		end
	
	set_double_array_value (an_object: MT_STORABLE; a_double_array: ARRAY [DOUBLE]) is
		do
			if a_double_array = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if a_double_array.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_Double_Array, $Void, 0)
				else
					c_set_value_array_numeric (an_object.oid, oid, Mt_Double_Array, $a_double_array, 1)
				end
			end
		end
		
	set_double_list (an_object: MT_STORABLE) is
		local
			a_double_array: ARRAY [DOUBLE]
			a_double_list: LINKED_LIST [DOUBLE]
			i: INTEGER
		do
			a_double_list ?= field (eif_field_index, an_object)
			set_double_list_value (an_object, a_double_list)
		end
	
	set_double_list_value (an_object: MT_STORABLE; a_double_list: LINKED_LIST [DOUBLE]) is
		local
			a_double_array: ARRAY [DOUBLE]
			i: INTEGER
		do
			if a_double_list = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if a_double_list.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_Double_List, $Void, 0)
				else
					!! a_double_array.make (1, a_double_list.count)
					from 
						a_double_list.start  
						i := 1
					until 
						a_double_list.off
					loop
						a_double_array.put (a_double_list.item, i)
						a_double_list.forth
						i := i + 1
					end
					c_set_value_array_numeric (an_object.oid, oid, Mt_Double_List, $a_double_array, 1)
				end
			end
		end
	
	set_real (an_object: MT_STORABLE) is
		local
			a_real: REAL
		do
			a_real := real_field (eif_field_index, an_object)
			c_set_value_real (an_object.oid, oid, Mt_Float, a_real, 0)
		end
	
	set_real_value (an_object: MT_STORABLE; value: REAL) is
		do
			c_set_value_real (an_object.oid, oid, Mt_Float, value, 0)
		end
		
	set_real_array (an_object: MT_STORABLE) is
		local
			a_real_array: ARRAY [REAL]
		do
			a_real_array ?= field (eif_field_index, an_object)
			set_real_array_value (an_object, a_real_array)
		end

	set_real_array_value (an_object: MT_STORABLE; value: ARRAY [REAL]) is
		do
			if value = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if value.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_Float_Array, $Void, 0)
				else
					c_set_value_array_numeric (an_object.oid, oid, Mt_Float_Array, $value, 1)
				end
			end
		end

	
	set_real_list (an_object: MT_STORABLE) is
		local
			a_real_array: ARRAY [REAL]
			a_real_list: LINKED_LIST [REAL]
			i: INTEGER
		do
			a_real_list ?= field (eif_field_index, an_object)
			set_real_list_value (an_object, a_real_list)
		end

	set_real_list_value (an_object: MT_STORABLE; a_real_list: LINKED_LIST [REAL]) is
		local
			a_real_array: ARRAY [REAL]
			i: INTEGER
		do
			if a_real_list = Void then
				c_set_value_void (an_object.oid, oid, Mt_Nil, $Void, 0)
			else
				if a_real_list.count = 0 then
					c_set_value_void (an_object.oid, oid, Mt_Float_List, $Void, 0)
				else
					!! a_real_array.make (1, a_real_list.count)
					from 
						a_real_list.start  
						i := 1
					until 
						a_real_list.off
					loop
						a_real_array.put (a_real_list.item, i)
						a_real_list.forth
						i := i + 1
					end
					c_set_value_array_numeric (an_object.oid, oid, Mt_Float_List, $a_real_array, 1)
				end
			end
		end
		
feature
	remove_value (an_obj: MT_STORABLE) is
		do
			c_remove_value (an_obj.oid, oid)
		end

feature {MT_CLASS, MATISSE}-- Schema

	eif_field_type: INTEGER
		-- Field type of eiffel object field corresponding to Current 
	
	mt_type: INTEGER
		-- MATISSE attribute type
		
	set_field_type (i: INTEGER) is
		do
			eif_field_type := i
		end

	set_mt_type (i: INTEGER) is
		do
			mt_type := i
		end

	predefined_eif_field (a_field_name: STRING): BOOLEAN is
			-- Is a_field_name an attribute defined in this class?
		do
			Result := a_field_name.is_equal ("oid") or
					a_field_name.is_equal ("db") or
					a_field_name.is_equal ("attributes_loaded") or
					a_field_name.is_equal ("relationships_loaded") or
					a_field_name.is_equal ("eif_field_index") or
					a_field_name.is_equal ("eif_field_type") 
		end

	setup_field (field_index: INTEGER; sample_obj: MT_STORABLE; a_db: MATISSE) is
			-- Initialize current as an attribute  for a speicif class, 
			-- which is the class of sample_obj.
		local
			num_types, i: INTEGER
			type_matched: BOOLEAN
			excp: MT_EXCEPTIONS
			message: STRING
		do
			database := a_db
			eif_field_index := field_index
			eif_field_type := (field_type (field_index, sample_obj))

			num_types := c_get_num_and_types (oid)
			if num_types = 0 then
				type_matched := True
			end
			
			from
				i := 1
			until
				type_matched or i > num_types
			loop
				if conform_to_field_type (c_ith_list_integer (i)) then
					mt_type := c_ith_list_integer (i)
					type_matched := True
				end
				i := i + 1
				-- This should be changed so that it consider Eiffel class field type
			end
			if not type_matched then
				!! excp
				message := clone ("Eiffel field '")
				message.append (eiffel_name)
				message.append ("' of class '")
				message.append (sample_obj.generator)
				message.append ("' does not conform to MATISSE attribute type.")
				excp.trigger (excp.Developer_exception, 100002, message)
			end
			c_free_value
		end

feature {NONE} -- Implementation

	conform_to_field_type (a_mt_type: INTEGER): BOOLEAN is
			-- Does a_mt_type conform to field type of object field 
			-- specified by current?
		do
			inspect a_mt_type
			when Mt_Nil then Result := False
			when Mt_Boolean then Result := eif_field_type = Boolean_type
			when Mt_Timestamp then Result := eif_field_type = Reference_type
			when Mt_Date then Result := eif_field_type = Reference_type
			when Mt_Time_Interval then Result := eif_field_type = Reference_type
			when Mt_U8 then Result := eif_field_type = Integer_type
			when Mt_U8_List then Result := eif_field_type = Reference_type
			when Mt_s16 then Result := eif_field_type = Integer_type
			when Mt_S16_List then Result := eif_field_type = Reference_type
			when Mt_u16 then Result := eif_field_type = Integer_type
			when Mt_U16_List then Result := eif_field_type = Reference_type
			when Mt_s32 then Result := eif_field_type = Integer_type
			when Mt_u32 then Result := eif_field_type = Integer_type
			when Mt_u32_list then Result := eif_field_type = Reference_type
			when Mt_U32_Array then Result := eif_field_type = Reference_type
			when Mt_Double then Result := eif_field_type = Double_type
			when Mt_Float then Result := eif_field_type = Real_type
			when Mt_Char then Result := eif_field_type = Character_type
			when Mt_String then Result := eif_field_type = Reference_type
			when Mt_Asciichar then Result := eif_field_type = Character_type
			when Mt_Asciistring then Result := eif_field_type = Reference_type
			when Mt_S32_List then Result := eif_field_type = Reference_type
			when Mt_Double_List then Result := eif_field_type = Reference_type
			when Mt_Float_List then Result := eif_field_type = Reference_type
			when Mt_String_List then Result := eif_field_type = Reference_type
			when Mt_Asciistring_List then Result := eif_field_type = Reference_type
			when Mt_S32_Array then Result := eif_field_type = Reference_type
			when Mt_U8_Array then Result := eif_field_type = Reference_type
			when Mt_S16_Array then Result := eif_field_type = Reference_type
			when Mt_U16_Array then Result := eif_field_type = Reference_type
			when Mt_Double_Array then Result := eif_field_type = Reference_type
			when Mt_Float_Array then Result := eif_field_type = Reference_type
			when Mt_String_Array then Result := eif_field_type = Reference_type
			when Mt_Asciistring_Array then Result := eif_field_type = Reference_type
			else Result := False
			end
		end

feature -- Value by type

	-- MT_U8 --
	get_byte (an_object: MT_OBJECT): INTEGER is
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				Result := c_get_byte_value;
			end
			c_free_value
		end

	get_byte_array (an_object: MT_OBJECT): ARRAY [CHARACTER] is
		local
			array_size, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				array_size := dimension (an_object, 0)
				!! Result.make (1, array_size)
				from 
					count := 1
				until 
					count = array_size + 1
				loop
					Result.put (c_ith_list_character (count), count)
					count := count + 1
				end
				c_free_value
			end
		end

	get_byte_list (an_object: MT_OBJECT): LINKED_LIST [CHARACTER] is
		local
			list_count, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				list_count := dimension (an_object, 0)
				!! Result.make
				from 
					count := 1
				until 
					count = list_count + 1
				loop
					Result.extend (c_ith_list_character (count))
					count := count + 1
				end
				c_free_value
			end
		end
	
	get_byte_list_elements (an_object: MT_OBJECT; buffer: ARRAY [CHARACTER]; 
			count, offset: INTEGER): INTEGER is
		local
			to_c: ANY
		do
			to_c := buffer.to_c
			Result := c_get_byte_list_elements (an_object.oid, oid, $to_c, count, offset)
		end
	
	-- MT_S32 --
	get_integer (an_object: MT_OBJECT): INTEGER is
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				Result := c_get_integer_value;
			end
			c_free_value
		end

	get_integer_list (an_object: MT_OBJECT): LINKED_LIST [INTEGER] is
		local
			list_count, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				list_count := dimension (an_object, 0)
				!! Result.make
				from 
					count := 1
				until 
					count = list_count + 1
				loop
					Result.extend (c_ith_list_integer (count))
					count := count + 1
				end
				c_free_value
			end
		end

	get_integer_array (an_object: MT_OBJECT): ARRAY [INTEGER] is
		local
			array_size, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				array_size:= dimension (an_object, 0)
				!! Result.make (1, array_size)
				from 
					count := 1
				until 
					count = array_size + 1
				loop
					Result.put (c_ith_list_integer (count), count)
					count := count + 1
				end
				c_free_value
			end
		end

	-- MT_U32 --
	get_unsigned_int (an_object: MT_OBJECT): INTEGER is
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				Result := c_get_unsigned_int_value;
			end
			c_free_value
		end
	
	get_unsigned_int_list (an_object: MT_OBJECT): LINKED_LIST [INTEGER] is
		local
			list_count, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				list_count := dimension (an_object, 0)
				!! Result.make
				from 
					count := 1
				until 
					count = list_count + 1
				loop
					Result.extend (c_ith_list_unsigned_int (count))
					count := count + 1
				end
				c_free_value
			end
		end

	get_unsigned_int_array (an_object: MT_OBJECT): ARRAY [INTEGER] is
		local
			array_size, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				array_size := dimension (an_object, 0)
				!! Result.make (1, array_size)
				from 
					count := 1
				until 
					count = array_size + 1
				loop
					Result.put (c_ith_list_unsigned_int (count), count)
					count := count + 1
				end
				c_free_value
			end
		end
	
	-- MT_S16 --
	get_short (an_object: MT_OBJECT): INTEGER is
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				Result := c_get_short_value;
			end
			c_free_value
		end
	
	get_short_list (an_object: MT_OBJECT): LINKED_LIST [INTEGER] is
		local
			list_count, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				list_count := dimension (an_object, 0)
				!! Result.make
				from 
					count := 1
				until 
					count = list_count + 1
				loop
					Result.extend (c_ith_list_short (count))
					count := count + 1
				end
				c_free_value
			end
		end

	get_short_array (an_object: MT_OBJECT): ARRAY [INTEGER] is
		local
			array_size, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				array_size := dimension (an_object, 0)
				!! Result.make (1, array_size)
				from 
					count := 1
				until 
					count = array_size + 1
				loop
					Result.put (c_ith_list_short (count), count)
					count := count + 1
				end
				c_free_value
			end
		end
	
	-- MT_U16 --
	get_unsigned_short (an_object: MT_OBJECT): INTEGER is
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				Result := c_get_unsigned_short_value;
			end
			c_free_value
		end
	
	get_unsigned_short_list (an_object: MT_OBJECT): LINKED_LIST [INTEGER] is
		local
			list_count, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				list_count := dimension (an_object, 0)
				!! Result.make
				from 
					count := 1
				until 
					count = list_count + 1
				loop
					Result.extend (c_ith_list_unsigned_short (count))
					count := count + 1
				end
				c_free_value
			end
		end

	get_unsigned_short_array (an_object: MT_OBJECT): ARRAY [INTEGER] is
		local
			array_size, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				array_size := dimension (an_object, 0)
				!! Result.make (1, array_size)
				from 
					count := 1
				until 
					count = array_size + 1
				loop
					Result.put (c_ith_list_unsigned_short (count), count)
					count := count + 1
				end
				c_free_value
			end
		end
	
	get_integer_type_value (an_object: MT_OBJECT): INTEGER is
		-- MATISSE type is MT_S32, MT_U32, MT_S16 or MT_U16.
		do
			inspect mt_type
			when Mt_U8 then
				Result := get_byte (an_object)
			when Mt_s16 then
				Result := get_short (an_object)
			when Mt_u16 then
				Result := get_unsigned_short (an_object)
			when Mt_s32 then
				Result := get_integer (an_object)
			when Mt_u32 then
				Result := get_unsigned_int (an_object)
			else
			end
		end

	-- MT_REAL --	
	get_real (an_object: MT_OBJECT): REAL is
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				Result := c_get_real_value;
			end
			c_free_value
		end

	get_real_list (an_object: MT_OBJECT): LINKED_LIST [REAL] is
		local
			list_count, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				list_count := dimension (an_object, 0)
				!! Result.make
				from 
					count := 1
				until 
					count = list_count + 1
				loop
					Result.extend (c_ith_list_real (count))
					count := count + 1
				end
				c_free_value
			end
		end
	
	get_real_array (an_object: MT_OBJECT): ARRAY [REAL] is
		local
			array_size, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				array_size := dimension (an_object, 0)
				!! Result.make (1, array_size)
				from 
					count := 1
				until 
					count = array_size + 1
				loop
					Result.put (c_ith_list_real (count), count)
					count := count + 1
				end
				c_free_value
			end
		end
	
	-- MT_DOUBLE --
	get_double (an_object: MT_OBJECT): DOUBLE is
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				Result := c_get_double_value;
			end
			c_free_value
		end

	get_double_list (an_object: MT_OBJECT): LINKED_LIST [DOUBLE] is
		local
			list_count, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				list_count := dimension (an_object, 0)
				!! Result.make
				from 
					count := 1
				until 
					count = list_count + 1
				loop
					Result.extend (c_ith_list_double (count))
					count := count + 1
				end
				c_free_value
			end
		end
	
	get_double_array (an_object: MT_OBJECT): ARRAY [DOUBLE] is
		local
			list_count, count: INTEGER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				list_count := dimension (an_object, 0)
				!! Result.make (1, list_count)
				from 
					count := 1
				until 
					count = list_count + 1
				loop
					Result.put (c_ith_list_double (count), count)
					count := count + 1
				end
				c_free_value
			end
		end

	get_character (an_object: MT_OBJECT): CHARACTER is
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				Result := c_get_char_value;
			end
			c_free_value
		end

	get_string (an_object: MT_OBJECT): STRING is
		local
			a_string: STRING
			a_pointer: POINTER
		do
			c_get_value (an_object.oid, oid);
			if c_value_type /= Mt_Nil then
				a_pointer := c_get_string_value
				if a_pointer /= default_pointer then
					!! Result.make (0);
					Result.from_c (a_pointer);
				end
			end
			c_free_value
		end

	get_string_list (an_object: MT_OBJECT): LINKED_LIST [STRING] is
		local
			list_size, count: INTEGER
			a_string: STRING
		do
			c_get_value (an_object.oid, oid)
			if c_value_type /= Mt_Nil then
				list_size := dimension (an_object, 0)
				!! Result.make
				from 
					count := 1
				until 
					count = list_size + 1
				loop 
					if c_ith_list_string (count) /= default_pointer then
						!! a_string.make (0)
						a_string.from_c (c_ith_list_string (count))
						Result.extend (a_string)
					else
						Result.extend (Void)
					end
					count := count + 1
				end
				c_free_value
			end
		end

	get_string_array (an_object: MT_OBJECT): ARRAY [STRING] is
		-- Note: support one-dimensional array only
		local
			array_size, count: INTEGER
			a_string: STRING
		do
			c_get_value (an_object.oid, oid)
			if c_value_type /= Mt_Nil then
				array_size := dimension (an_object, 0) 
				!! Result.make (1, array_size)
				from 
					count := 1  
				until 
					count = array_size + 1 
				loop 
					if c_ith_list_string (count) /= default_pointer then
						!! a_string.make (0)
						a_string.from_c (c_ith_list_string (count))
						Result.put (a_string, count)
					else
						Result.put (Void, count)
					end
					count := count + 1
				end
				c_free_value
			end
		end

	-- MT_BOOLEAN --
	get_boolean (an_object: MT_OBJECT): BOOLEAN is
		do
			c_get_value (an_object.oid, oid)
			Result := c_get_boolean_value
			c_free_value
		end

	-- MT_DATE --
	get_date (an_object: MT_OBJECT): DATE is
		-- Type of result is still subject to change
		local
			yr, mh, dy, comp_days, tmp: INTEGER
		do
			c_get_value (an_object.oid, oid)
			if c_value_type /= Mt_nil then
				yr := c_get_date_year
				mh := c_get_date_month
				dy := c_get_date_day
				!! Result.make (yr, mh, dy)	
				c_free_value
			end
		end

	-- MT_TIMESTAMP --
	get_timestamp (an_object: MT_OBJECT): DATE_TIME is
		-- Type of result is still subject to change
		local
			yr, mh, dy, hr, me, sd, msd: INTEGER
			comp_days, seconds, tmp: INTEGER
			fine_sec: DOUBLE
		do
			c_get_value (an_object.oid, oid)
			comp_days := c_get_date_comp_days
			yr := comp_days // 10000
			tmp := comp_days - (yr * 10000)
			mh := tmp // 100
			dy := tmp - (mh * 100)
			
			seconds := c_get_timestamp_comp_seconds
			hr := seconds // 3600
			tmp := seconds - (hr * 3600)
			me := tmp // 60
			sd := tmp - (me * 60)
			msd := c_get_timestamp_microsecs
			c_free_value
			fine_sec := sd + (msd / 1000000)
			!! Result.make_fine (yr, mh, dy, hr, me, fine_sec)
		end
		
	-- MT_TIME_INTERVAL --
	get_time_interval (an_object: MT_OBJECT): DATE_TIME_DURATION is
		-- Type of result is still subject to change
		local
			date: DATE_DURATION
			time: TIME_DURATION
		do
			c_get_value (an_object.oid, oid)
			!! date.make_by_days (c_get_time_interval_days)
			!! time.make_by_fine_seconds (c_get_time_interval_fine_seconds)
			!! Result.make_by_date_time (date, time)
		end
	
feature {MATISSE} -- Object life cycle

	revert_to_unloaded (an_obj: MT_STORABLE) is
		local
			a_type: INTEGER
		do
			if mt_type = 0 then
				c_get_value (an_obj.oid, oid)
				a_type := c_value_type
			else
				a_type := mt_type
			end
			
			inspect a_type
			when Mt_Boolean then set_boolean_field (eif_field_index, an_obj, False)
			when Mt_U8 then set_integer_field (eif_field_index, an_obj, 0)
			when Mt_S16  then set_integer_field (eif_field_index, an_obj, 0)
			when Mt_U16  then set_integer_field (eif_field_index, an_obj, 0)
			when Mt_S32  then set_integer_field (eif_field_index, an_obj, 0)
			when Mt_U32  then set_integer_field (eif_field_index, an_obj, 0)
			when Mt_Asciichar  then set_character_field (eif_field_index, an_obj, '%U')
			when Mt_Char  then set_character_field (eif_field_index, an_obj, '%U')
			when Mt_Double  then set_double_field (eif_field_index, an_obj, Double_default_value)
			when Mt_Float  then set_real_field (eif_field_index, an_obj, Real_default_value)
			else
				set_reference_field (eif_field_index, an_obj, Void)
			end
		end

end -- class MT_ATTRIBUTE
