indexing
	description: "Define all the constants used for the Matisse binding."

class 
	MT_CONSTANTS 

inherit
	INTERNAL
		export 
			{NONE} all
		end

feature {NONE} -- MATISSE Data Types

	Mt_Boolean: INTEGER is 1
	Mt_Timestamp: INTEGER is 3
	Mt_Date: INTEGER is 4
	Mt_Time_Interval: INTEGER is 5
	Mt_U8: INTEGER is 12
	Mt_U8_List: INTEGER is 13
	Mt_S16: INTEGER is 14
	Mt_S16_List: INTEGER is 15
	Mt_U16: INTEGER is 16
	Mt_U16_List: INTEGER is 17
	Mt_S32: INTEGER is 18
	Mt_U32: INTEGER is 19
	Mt_U32_List: INTEGER is 20
	Mt_Asciichar: INTEGER is 22
	Mt_Char: INTEGER is 23
	Mt_Double: INTEGER is 26
	Mt_Nil: INTEGER is 27
	Mt_S32_List: INTEGER is 28
	Mt_Double_List: INTEGER is 29
	Mt_Asciistring_List: INTEGER is 30
	Mt_String_List: INTEGER is 31
	Mt_Asciistring: INTEGER is 32
	Mt_String: INTEGER is 33
	Mt_U8_Array: INTEGER is 34
	Mt_S16_Array: INTEGER is 35
	Mt_U16_Array: INTEGER is 36
	Mt_S32_Array: INTEGER is 37
	Mt_U32_Array: INTEGER is 38
	Mt_Double_Array: INTEGER is 39
	Mt_String_Array: INTEGER is 40
	Mt_Asciistring_Array: INTEGER is 41
	Mt_Float_Array: INTEGER is 45
	Mt_Float: INTEGER is 46
	Mt_Float_List: INTEGER is 47


feature -- Context
			
	current_db: MATISSE is
			-- Current database.
		do
			Result := current_db_item.item
		end

feature {NONE} -- Eiffel class types

	Eif_character_type: INTEGER is once Result := dynamic_type ('a') end
	Eif_integer_type: INTEGER is once Result := dynamic_type (1) end
	Eif_boolean_type: INTEGER is once Result := dynamic_type (True) end
	Eif_string_type: INTEGER is once Result := dynamic_type ("a") end
	Eif_real_type: INTEGER is 
		local 
			a: REAL
		once 
			a := 1.0 
			Result := dynamic_type (a) 
		end

	Eif_double_type: INTEGER is
		local 
			a: DOUBLE
		once 
			a := 1.0 
			Result := dynamic_type (a) 
		end

	Eif_integer_array_type: INTEGER is
		local 
			a: ARRAY [INTEGER]
		once 
			!! a.make (0, 0) 
			Result := dynamic_type (a) 
		end

	Eif_real_array_type: INTEGER is
		local 
			a: ARRAY [REAL]
		once 
			!! a.make (0, 0) 
			Result := dynamic_type (a) 
		end

	Eif_double_array_type: INTEGER is
		local 
			a: ARRAY [DOUBLE]
		once 
			!! a.make (0, 0) 
			Result := dynamic_type (a) 
		end

	Eif_reference_array_type, Eif_string_array_type: INTEGER is
		local 
			a: ARRAY [STRING]
		once 
			!! a.make (0, 0) 
			Result := dynamic_type (a) 
		end

	Eif_byte_array_type: INTEGER is
		local 
			a: ARRAY [CHARACTER]
		once 
			!! a.make (0, 0) 
			Result := dynamic_type (a) 
		end

	Eif_integer_list_type: INTEGER is
		local 
			a: LINKED_LIST [INTEGER]
		once 
			!! a.make 
			Result := dynamic_type (a) 
		end

	Eif_real_list_type: INTEGER is
		local 
			a: LINKED_LIST [REAL]
		once 
			!! a.make 
			Result := dynamic_type (a) 
		end

	Eif_double_list_type: INTEGER is
		local 
			a: LINKED_LIST [DOUBLE]
		once 
			!! a.make 
			Result := dynamic_type (a) 
		end

	Eif_string_list_type: INTEGER is
		local 
			a: LINKED_LIST [STRING]
		once 
			!! a.make 
			Result := dynamic_type (a) 
		end

	Eif_byte_list_type: INTEGER is
		local 
			a: LINKED_LIST [CHARACTER]
		once 
			!! a.make 
			Result := dynamic_type (a) 
		end
	
	Eif_date_type: INTEGER is
		local 
			a: DATE
		once 
			!! a.make (1, 1, 1) 
			Result := dynamic_type (a) 
		end
	Eif_date_time_type: INTEGER is
		local 
			a: DATE_TIME
		once 
			!! a.make (1, 1, 1, 1, 1, 1) 
			Result := dynamic_type (a) 
		end

	Eif_date_time_duration_type: INTEGER is
		local 
			a: DATE_TIME_DURATION
		once 
			!! a.make (1, 1, 1, 1, 1, 1) 
			Result := dynamic_type (a) 
		end


feature {NONE} -- Implementation context

	current_db_item: CELL [MATISSE] is
		once
			!! Result.put (Void)
		end

	put_current_db (a_db: MATISSE) is
		do
			current_db_item.put (a_db)
		end

feature -- Session State

	Mt_Noconnection: INTEGER is -1
	Mt_Inited: INTEGER is 0
	Mt_Transaction: INTEGER is 1
	Mt_Version: INTEGER is 5

feature -- Lock

	Mt_Read: INTEGER is 1
	Mt_Write: INTEGER is 2

feature -- Direction

	Mt_Direct: INTEGER is 1
	Mt_Reverse: INTEGER is -1

feature -- Ordering

	Mt_Descend: INTEGER is 0
	Mt_Ascend: INTEGER is 1
	
feature -- Server Execution Priority

	Mt_Min_Server_Execution_Priority: INTEGER is 0
	Mt_Normal_Server_Execution_Priority: INTEGER is 1
	Mt_Above_Normal_Server_Execution_Priority: INTEGER is 2
	Mt_Max_Server_Execution_Priority: INTEGER is 3
	
feature -- Wait Time

	Mt_No_Wait: INTEGER is 0
	Mt_Wait_Forever: INTEGER is -1
	
feature -- Data Access Mode

	Mt_Data_Modification: INTEGER is 0
	Mt_Data_Readonly: INTEGER is 1
	Mt_Data_Definition: INTEGER is 2
	
feature -- Error Code

	Matisse_Success: INTEGER is  140148745
	Matisse_Notran:INTEGER is  140149610

feature -- List Elements

	Mt_Begin_Offset: INTEGER is 0
	Mt_Current_Offset: INTEGER is
		once
			Result := c_mt_current_offset
		end
	Mt_End_Offset: INTEGER is
		once
			Result := c_mt_end_offset
		end
	Mt_List_Max_Len: INTEGER is
		once
			Result := c_mt_list_max_len
		end
		
feature {NONE} -- List Elements Implementation

	c_mt_current_offset: INTEGER is
		external 
			"C"
		end
	
	c_mt_end_offset: INTEGER is
		external 
			"C"
		end
		
	c_mt_list_max_len: INTEGER is
		external 
			"C"
		end

end -- class MT_CONSTANTS
