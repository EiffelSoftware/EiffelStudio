class TYPES 

inherit
	INTERNAL
		export
			{NONE} all
		end

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
other_array: ARRAY[STRING]
one_string:STRING
i:INTEGER
found:BOOLEAN
		do
			!!one_array.make(0,0)
			Result := has_same_type(one_array,object)
-- can't trust this - it returns TRue for a ARRAY[STRING]. Do another (dodgy) check:
other_array ?= object
if other_array /= Void then
    if not other_array.empty then
	-- loop through array to see if any members (nec. for HASH_TABLE arrays)
	from i := other_array.lower until i > other_array.upper or found loop
	    one_string ?= other_array.item(i)
	    found := one_string = Void -- i.e. we don't want to match a STRING
	    i := i + 1
	end
	Result := Result and found
    else
    	-- still can't tell!!!
    end
end
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

	is_array_boolean(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_array : ARRAY[BOOLEAN]
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
other_array: ARRAY[STRING]
one_string:STRING
i:INTEGER
found:BOOLEAN
		do
			!!one_array.make(0,0)
			Result := has_same_type(one_array,object)
-- can't trust this - it returns TRue for a ARRAY[STRING]. Do another (dodgy) check:
other_array ?= object
if other_array /= Void then
    if not other_array.empty then
	-- loop through array to see if any members (nec. for HASH_TABLE arrays)
	from i := other_array.lower until i > other_array.upper or found loop
	    one_string ?= other_array.item(i)
	    found := one_string /= Void
	    i := i + 1
	end
	Result := Result and found
    else
    	-- still can't tell!!!
    end
end
		end -- is_array_string

feature -- Status Report : LINKED_LIST

	is_linked_list_any(object : ANY) : BOOLEAN is
		require 
			not_void : object /= Void
		local
			one_linked_list : LINKED_LIST[ANY]
other_linked_list: LINKED_LIST[STRING]
one_string:STRING
		do
			!!one_linked_list.make
			Result := has_same_type(one_linked_list,object)
-- can't trust this - it returns TRue for a LIST[STRING]. Do another (dodgy) check:
other_linked_list ?= object
if other_linked_list /= Void then
    if not other_linked_list.empty then
	one_string ?= other_linked_list.first
	Result := Result and one_string = Void
    else
    	-- still can't tell!!!
    end
end
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
			one_linked_list: LINKED_LIST[STRING]
other_linked_list: LINKED_LIST[STRING]
one_string:STRING
		do
			!!one_linked_list.make
			Result := has_same_type(one_linked_list,object)

-- can't trust this - it returns TRue for a LIST[ANY]. Do another (dodgy) check:
other_linked_list ?= object
if other_linked_list /= Void then
    if not other_linked_list.empty then
	one_string ?= other_linked_list.first
	Result := Result and one_string /= Void
    else
    	-- still can't tell!!!
    end
end
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

feature -- database mapped types
	OK_is_db_implemented_type(obj_field:ANY):BOOLEAN is
	        -- the following is the correct implementation, but will not work at the 
	        -- moment due to the dynamic type bug in ISE Eiffel 4.1
	    obsolete
			"Use ODB_SCHEMA.is_db_implemented_type"
		do
			Result :=
			is_array_integer(obj_field) or 
			is_array_double(obj_field) or 
			is_array_real(obj_field)  or
			is_linked_list_integer(obj_field)  or 
			is_linked_list_double(obj_field) or 
			is_linked_list_real(obj_field) or
			is_linked_list_string(obj_field) or 
			is_string(obj_field)  
	    end

feature {NONE} -- Externals

	has_same_type(arg1,arg2 : ANY) : BOOLEAN is
		do
			Result :=  c_same_type($arg1,$arg2)
	end -- has_same_type

end -- class TYPES
