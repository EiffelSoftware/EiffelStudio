class TYPES 

feature -- Status Report : Basic types

	is_integer(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_integer : INTEGER
		do
			Result := has_same_type(one_integer,object)
		end -- is_integer

	is_real(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_real : REAL
		do
	        	Result := has_same_type(one_real,object)
	    	end -- is_real

	is_double(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
 		local
			one_double : DOUBLE
		do
			Result := has_same_type(one_double,object)
		end -- is_double

	is_character(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_character : CHARACTER
		do
			Result := has_same_type(one_character,object)
		end -- is_character

	is_string(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_string : STRING
		do
			!!one_string.make(0)
			Result := has_same_type(one_string,object)
		end -- is_string

feature -- Status Report : ARRAY 

	is_array_any(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_array : ARRAY[ANY]
		do
			!!one_array.make(0,0)
			Result := has_same_type(one_array,object)
		end -- is_array_any

	is_array_integer(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_array : ARRAY[INTEGER]
		do
			!!one_array.make(0,0)
			Result := has_same_type(one_array,object)
		end -- is_integer

	is_array_double(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_array : ARRAY[DOUBLE]
		do
			!!one_array.make(0,0)
			Result := has_same_type(one_array,object)
		end -- is_array_double

	is_array_real(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_array : ARRAY[REAL]
		do
			!!one_array.make(0,0)
			Result := has_same_type(one_array,object)
		end -- is_array_real

	is_array_string(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_array : ARRAY[STRING]
		do
			!!one_array.make(0,0)
			Result := has_same_type(one_array,object)
		end -- is_array_string

feature -- Status Report : LINKED_LIST

	is_linked_list_any(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_linked_list : LINKED_LIST[ANY]
		do
			!!one_linked_list.make
			Result := has_same_type(one_linked_list,object)
		end -- is_linked_list_any

	is_linked_list_integer(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_linked_list : LINKED_LIST[INTEGER]
		do
			!!one_linked_list.make
			Result := has_same_type(one_linked_list,object)
		end -- is_linked_list_integer

	is_linked_list_double(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_linked_list : LINKED_LIST[DOUBLE]
		do
			!!one_linked_list.make
			Result := has_same_type(one_linked_list,object)
		end -- is_linked_list_double

	is_linked_list_real(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_linked_list : LINKED_LIST[REAL]
		do
			!!one_linked_list.make
			Result := has_same_type(one_linked_list,object)
		end -- is_linked_list_real

	is_linked_list_string(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_linked_list : LINKED_LIST[STRING]
		do
			!!one_linked_list.make
			Result := has_same_type(one_linked_list,object)
		end -- is_linked_list_string

	is_linked_list(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_linked_list : LINKED_LIST[ANY]
		do
			one_linked_list ?= object
 			Result := one_linked_list /= Void
		end -- is_linked_list

feature {NONE} -- Externals

	has_same_type(arg1,arg2 : ANY) : BOOLEAN is
		do
			Result :=  c_same_type($arg1,$arg2)
	end -- has_same_type

end -- class TYPES
