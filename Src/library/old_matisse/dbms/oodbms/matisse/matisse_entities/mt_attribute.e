class MT_ATTRIBUTE

inherit 

	MATISSE_CONST 
		export	{NONE}	all;
			{ANY}	mtnil,mts32,mtdouble,mtfloat,mtchar,mtasciichar,mtstring,mtasciistring,
				mts32_list,mtdouble_list,mtfloat_list,mtstring_list,mtasciistring_list,
				mts32_array,mtdouble_array,mtfloat_array,mtstring_array,mtasciistring_array,
mtu8_array
		end

	MT_PROPERTY
		rename id as aid
		redefine is_ok
	end

	MT_ATTRIBUTE_EXTERNAL

	MT_NAME_EXTERNAL

	MEMORY
		export {NONE} all
		end

	DB_DATA

creation

	make, make_from_id

feature {NONE} -- Initialization

	make(attribute_name : STRING) is
		-- Get attribute from database
		require
			attribute_not_void : attribute_name /= Void
			attribute_not_empty : not attribute_name.empty
		local
			c_attribute_name : ANY
		do
			c_attribute_name := attribute_name.to_c
			aid := c_get_attribute($c_attribute_name)
		end -- make

feature {NONE} -- Initialization

	make_from_id(attribute_id : INTEGER) is
		-- Create attribute with its id. 
		do
			aid := attribute_id
		end -- make_from_id

feature -- Access

	dimension(one_object : MT_OBJECT;rank : INTEGER) : INTEGER is
		-- Dimension of current attribute
		-- When the value of the attribute is an array, returns the size of the
		-- array for the dimension rank.
		-- If the attribute value is a list, rank must be equal to 0 and dimension 
		-- gives the number of elements in the list.
		require
			rank_positive_or_null : rank >= 0
		do
			Result := c_get_dimension(one_object.oid,aid,rank)
		end -- dimension

	value(one_object : MT_OBJECT) : ANY is
		-- Value of this attribute in 'one_object'
		-- Correspondance table from Matisse types to Eiffel types :
		-- Basic types 
		-- 	MTNIL -> Void
		-- 	MTS32 -> INTEGER
		-- 	MTDOUBLE -> DOUBLE
		-- 	MTFLOAT -> REAL
		-- 	MTCHAR, MTASCIICHAR -> CHARACTER
		-- 	MTSTRING, MTASCIISTRING -> STRING
		-- Lists
		-- 	MTS32_LIST -> LINKED_LIST[INTEGER]
		-- 	MTDOUBLE_LIST -> LINKED_LIST[DOUBLE]
		-- 	MTFLOAT_LIST -> LINKED_LIST[REAL]
		-- 	MTSTRING_LIST, MTASCIISTRING -> LINKED_LIST[STRING]
		-- Arrays ( 1 dimension only )
		-- 	MTS32_ARRAY -> ARRAY[INTEGER]
		--	 MTDOUBLE_ARRAY -> ARRAY[DOUBLE]
		-- 	MTFLOAT_ARRAY -> ARRAY[REAL]
		--	 MTSTRING_ARRAY, MTASCIISTRING_ARRAY -> ARRAY[STRING]
-- MTU8_ARRAY -> ARRAY[CHARACTER] (really for use as ARRAY[BOOLEAN])
		-- Not available : MTU8_ARRAY, MTU16_ARRAY, MTU32_ARRAY, MTS16_ARRAY
		local
			one_integer,count,list_count,cvt_case,array_count : INTEGER
			one_double : DOUBLE
			one_real : REAL
			one_char : CHARACTER
			one_string : STRING
			one_list_integer : LINKED_LIST[INTEGER]
			one_list_double : LINKED_LIST[DOUBLE]
			one_list_float : LINKED_LIST[REAL]
			one_list_string : LINKED_LIST[STRING]
			one_array_integer : ARRAY[INTEGER]
one_array_character : ARRAY[CHARACTER]
one_array_boolean:ARRAY[BOOLEAN]	-- part of a (hideous) asymmetric attempt to retrieve booleans
			one_array_double : ARRAY[DOUBLE]
			one_array_real : ARRAY[REAL]
			one_array_string : ARRAY[STRING]
		do
debug("matisse") 
	io.putstring("c_get_value(oid=")
	io.put_integer(one_object.oid)
	io.putstring(",aid=")
	io.put_integer(aid)
	io.putstring("	    ")
end
debug("matisse") io.putstring(" (try c_get_value) ") end
			c_get_value(one_object.oid,aid)
debug("matisse") io.putstring(" (try c_cvt_case) ") end
			cvt_case := c_value_type
			if cvt_case=Mtnil then
debug("matisse") io.putstring("Mtnil = Void%N") end
				Result := Void
			elseif cvt_case = Mts32 then
debug("matisse") io.putstring("Mts32 = ") end
				one_integer := c_get_integer_value
				Result := one_integer
debug("matisse") io.put_integer(one_integer) io.new_line end
				c_free_value
			elseif cvt_case = Mtdouble then
debug("matisse") io.putstring("Mtdouble = ") end
				one_double := c_get_double_value
				Result := one_double
debug("matisse") io.put_double(one_double) io.new_line end
				c_free_value
			elseif cvt_case = Mtfloat then
debug("matisse") io.putstring("Mtfloat = ") end
				one_real := c_get_real_value
				Result := one_real
debug("matisse") io.put_real(one_real) io.new_line end
				c_free_value
			elseif cvt_case = Mtchar then
debug("matisse") io.putstring("Mtchar = ") end
				one_char := c_get_char_value
				Result := one_char
debug("matisse") io.put_character(one_char) io.new_line end
				c_free_value
			elseif cvt_case = Mtasciichar then
debug("matisse") io.putstring("Mtasciichar = ") end
				one_char := c_get_char_value
				Result := one_char
debug("matisse") io.put_character(one_char) io.new_line end
				c_free_value
			elseif cvt_case = Mtstring then
debug("matisse") io.putstring("Mtstring = ") end
				!!one_string.make(0)
				one_string.from_c(c_get_string_value)
debug("matisse") io.put_string(one_string) io.new_line end
debug("matisse") io.put_string("    try clone(string)") io.new_line end
				Result := Clone(one_string)
debug("matisse") io.put_string("    try c_free_value") io.new_line end
				c_free_value
debug("matisse") io.put_string("    c_free_value done") io.new_line end
			elseif cvt_case = Mtasciistring then
debug("matisse") io.putstring("Mtasciistring = ") end
				!!one_string.make(0)
				one_string.from_c(c_get_string_value)
debug("matisse") io.put_string(one_string) io.new_line end
				Result := Clone(one_string)
				c_free_value
			elseif cvt_case = Mts32_list then
debug("matisse") io.putstring("Mts32_list = ") end
				!!one_list_integer.make
				list_count := dimension(one_object,0) 
				from count := 1  until count=list_count+1 loop one_list_integer.extend(c_ith_list_integer(count))
debug("matisse") io.put_integer(c_ith_list_integer(count)) io.put_string(", ") end
				one_list_integer.forth count := count + 1 end
debug("matisse") io.new_line end
				one_list_integer.start
				Result := deep_clone(one_list_integer)
				c_free_value
			elseif cvt_case = Mtdouble_list then
debug("matisse") io.putstring("Mtdouble_list = ") end
				!!one_list_double.make
				list_count := dimension(one_object,0) 
				from count := 1  until count=list_count+1 loop one_list_double.extend(c_ith_list_double(count))
debug("matisse") io.put_double(c_ith_list_double(count)) io.put_string(", ") end
				one_list_double.forth count := count + 1 end
debug("matisse") io.new_line end
				one_list_double.start
				Result := deep_clone(one_list_double)
				c_free_value
			elseif cvt_case = Mtfloat_list then
debug("matisse") io.putstring("Mtfloat_list = ") end
				!!one_list_float.make
				list_count := dimension(one_object,0) 
				from count := 1  until count=list_count+1 loop one_list_float.extend(c_ith_list_real(count))
debug("matisse") io.put_real(c_ith_list_real(count)) io.put_string(", ") end
				one_list_float.forth count := count + 1 end
debug("matisse") io.new_line end
				one_list_float.start
				Result := deep_clone(one_list_float)
				c_free_value
			elseif cvt_case = Mtstring_list or cvt_case = Mtasciistring_list then
debug("matisse") io.putstring("Mtstring_list/Mtasciistring_list = ") end
				!!one_list_string.make
				list_count := dimension(one_object,0) 
				from count := 1  until count=list_count+1 loop 
					!!one_string.make(0) one_string.from_c(c_ith_list_string(count))
debug("matisse") io.put_string(one_string) io.put_string(", ") end
					one_list_string.extend(one_string)
					one_list_string.forth count := count + 1 
				end
debug("matisse") io.new_line end
				one_list_string.start
				Result := deep_clone(one_list_string)
				c_free_value
			elseif cvt_case = Mts32_array then
debug("matisse") io.putstring("Mts32_array = ") end
				array_count := dimension(one_object,0) 
				!!one_array_integer.make(1,array_count)
				from count := 1  until count=array_count+1 loop one_array_integer.put(c_ith_list_integer(count),count) 
debug("matisse") io.put_integer(c_ith_list_integer(count)) io.put_string(", ") end
				count := count+1 end
debug("matisse") io.new_line end
				Result := deep_clone(one_array_integer)
				c_free_value
elseif cvt_case = Mtu8_array then
debug("matisse") io.putstring("Mtu8_array = ") end
	array_count := dimension(one_object,0) 
--	!!one_array_character.make(1,array_count)
	!!one_array_boolean.make(1,array_count)
	from count := 1  until count=array_count+1 loop 
--		one_array_character.put(c_ith_list_character(count),count) 
		if c_ith_list_character(count) = 't' then
			one_array_boolean.put(True,count)
		else
			one_array_boolean.put(False,count)
		end
debug("matisse") io.put_character(c_ith_list_character(count)) io.put_string(", ") end
	count := count+1 end
debug("matisse") io.new_line end
--	Result := deep_clone(one_array_character)
	Result := deep_clone(one_array_boolean)
	c_free_value
			elseif cvt_case = Mtdouble_array then
debug("matisse") io.putstring("Mtdouble_array = ") end
				array_count := dimension(one_object,0) 
				!!one_array_double.make(1,array_count)
				from count := 1  until count=array_count+1 loop one_array_double.put(c_ith_list_double(count),count) 
debug("matisse") io.put_double(c_ith_list_double(count)) io.put_string(", ") end
				count := count+1 end
debug("matisse") io.new_line end
				Result := deep_clone(one_array_double)
				c_free_value
			elseif cvt_case = Mtfloat_array then
debug("matisse") io.putstring("Mtfloat_array = ") end
				array_count := dimension(one_object,0) 
				!!one_array_real.make(1,array_count)
				from count := 1  until count=array_count+1 loop one_array_real.put(c_ith_list_real(count),count) 
debug("matisse") io.put_double(c_ith_list_double(count)) io.put_string(", ") end
				count := count+1 end
debug("matisse") io.new_line end
				Result := deep_clone(one_array_real)
				c_free_value
			elseif cvt_case = Mtstring_array or cvt_case = Mtasciistring_array then
debug("matisse") io.putstring("Mtstring_array/Mtsasciistring_array = ") end
				array_count := dimension(one_object,0) 
				!!one_array_string.make(1,array_count)
				from count := 1  until count=array_count+1 loop 
if c_ith_list_string(count) /= default_pointer then
					!!one_string.make(0)
					one_string.from_c(c_ith_list_string(count))
-- kludge for Void string members
if not one_string.is_equal(Void_string) then
					one_array_string.put(one_string,count)
end
end
debug("matisse") io.put_string(one_string) io.put_string(", ") end
					count := count+1 
				end
debug("matisse") io.new_line end
				Result := deep_clone(one_array_string)
				c_free_value
			else
debug("matisse") io.putstring("OTHER TYPE - NOT AVAILABLE%N") end
				-- Other types not available
			end -- if
		end -- value

feature -- Status Report

	is_ok(one_object : MT_OBJECT) : BOOLEAN is
		-- Check if attribute is correct in 'one_object'
		do
			c_check_attribute(aid,one_object.oid)
		end -- check

	name : STRING is
		-- Name in Matisse
		do
			!!Result.make(0) Result.from_c(c_object_name(aid))
		end -- name

	type : INTEGER is
		-- Attribute type in Matisse ( see MATISSE_CONST )
		do
			Result := c_type_value(aid)
		end -- type

	type_to_string : STRING is
		-- String form of type
		local
			atype : INTEGER
		do
			atype := type
			!!Result.make(0)
			if atype = Mtnil then
				Result := "MTNIL"
			elseif atype = Mts32 then
				Result := "MTS32"
			elseif atype = Mtdouble then
				Result := "MTDOUBLE"
			elseif atype = Mtfloat then
				Result := "MTFLOAT"
			elseif atype = Mtchar then
				Result := "MTCHAR"
			elseif atype = Mtasciichar then
				Result := "MTASCIICHAR"
			elseif atype = Mtstring then
				Result := "MTSTRING"
			elseif atype = Mtasciistring then
				Result := "MTASCIISTRING"
			elseif atype = Mts32_list then
				Result := "MTS32_LIST"
			elseif atype = Mtdouble_list then
				Result := "MTDOUBLE_LIST"
			elseif atype = Mtfloat_list then
				Result := "MTFLOAT_LIST"
			elseif atype = Mtstring_list then
				Result := "MTSTRING_LIST"
			elseif atype = Mtasciistring_list then
				Result := "MTASCIISTRING_LIST"
elseif atype = Mtu8_array then
	Result := "MTU8_ARRAY"
			elseif atype = Mts32_array then
				Result := "MTS32_ARRAY"
			elseif atype = Mtdouble_array then
				Result := "MTDOUBLE_ARRAY"
			elseif atype = Mtfloat_array then
				Result := "MTFLOAT_ARRAY"
			elseif atype = Mtstring_array  then
				Result := "MTSTRING_ARRAY"
			elseif atype = Mtasciistring_array then
				Result := "MTASCIISTRING_ARRAY"
			else
				-- Other types not available
			end -- if
		end -- type_to_string


	is_predefined_msp : BOOLEAN is
		-- Is it standard ?
		local
			one_object : MT_OBJECT
		do
			!!one_object.make(Current.aid)
			Result := one_object.is_predefined_msp	
		end -- is_predefined_msp


feature -- Element Change

	set_value(one_object : MT_OBJECT;atype : INTEGER;new_value : ANY) is
		-- Set value 
		require
			a_matisse_type : 
			atype=Mtnil or atype=Mts32 or atype=Mtdouble or atype=Mtfloat or atype=Mtchar or atype=Mtasciichar or atype=Mtstring or atype=Mtasciistring
			or atype=Mts32_list or atype=Mtdouble_list or atype=Mtfloat_list or atype=Mtstring_list or atype=Mtasciistring_list 
			or atype=Mts32_array or atype=Mtdouble_array or atype=Mtfloat_array or atype=Mtstring_array or atype=Mtasciistring_array
or atype=Mtu8_array
		local
			one_integer : INTEGER_REF
			one_double : DOUBLE_REF
			one_real : REAL
			one_real_ref:REAL_REF
			one_char : CHARACTER_REF
			one_string : STRING
			c_one_string : ANY
			one_list_integer : LINKED_LIST[INTEGER]
			one_list_double : LINKED_LIST[DOUBLE]
			one_list_float : LINKED_LIST[REAL]
			one_list_string : LINKED_LIST[STRING]
one_array_character : ARRAY[CHARACTER]
			one_array_integer : ARRAY[INTEGER]
			one_array_double : ARRAY[DOUBLE]
			one_array_real : ARRAY[REAL]
			one_array_string : ARRAY[STRING]
			one_array_pointer : ARRAY[POINTER]
			is_gc_on : BOOLEAN
			i:INTEGER
		do
			if atype = Mtnil then
			elseif atype = Mts32 then
				one_integer ?= new_value
				check one_integer /= Void end
				c_set_value_integer(one_object.oid,aid,Mts32,one_integer.item,0) 
			elseif atype = Mtdouble then
				one_double ?= new_value
				check one_double /= Void end
				c_set_value_double(one_object.oid,aid,Mtdouble,one_double.item,0) 
			elseif atype = Mtfloat then
				one_double ?= new_value
				if one_double=Void then
					one_real_ref ?= new_value
					check one_real_ref /= Void end
					one_real := one_real_ref.item
				else
					one_real := one_double.item.truncated_to_real
				end -- if
				c_set_value_real(one_object.oid,aid,Mtfloat,one_real,0) 
			elseif atype = Mtchar then
				one_char ?= new_value
				check one_char /= Void end
				c_set_value_char(one_object.oid,aid,Mtchar,one_char.item,0) 
			elseif atype = Mtasciichar then
				one_char ?= new_value
				check one_char /= Void and then one_char.code <= 127 end
				c_set_value_char(one_object.oid,aid,Mtasciichar,one_char.item,0) 
			elseif atype = Mtstring then
 				one_string ?= new_value
				check one_string /= Void end 
				c_one_string := one_string.to_c
				c_set_value_string(one_object.oid,aid,Mtstring,$c_one_string,0) 
			elseif atype = Mtasciistring then
				one_string ?= new_value
				check one_string /= Void end 
				c_one_string := one_string.to_c
				c_set_value_string(one_object.oid,aid,Mtstring,$c_one_string,0) 
			elseif atype = Mts32_list then
				one_list_integer ?= new_value
				check one_list_integer /= Void end
				!!one_array_integer.make(1,one_list_integer.count)  
				from one_list_integer.start i:= 1 until one_list_integer.off loop
					one_array_integer.force(one_list_integer.item,i)
					i:= i + 1
					one_list_integer.forth 
				end
				c_set_value_array_numeric(one_object.oid,aid,atype,$one_array_integer,1) 
			elseif atype = Mtdouble_list then
				one_list_double ?= new_value
				check one_list_double /= Void end
				!!one_array_double.make(1,one_list_double.count)  
				from one_list_double.start i:= 1 until one_list_double.off loop
					one_array_double.force(one_list_double.item,i)
					i:= i + 1
					one_list_double.forth
				end
				c_set_value_array_numeric(one_object.oid,aid,atype,$one_array_double,1) 
			elseif atype = Mtfloat_list then
				one_list_float ?= new_value
				check one_list_float /= Void end
				!!one_array_real.make(1,one_list_float.count)  
				from one_list_float.start i:= 1 until one_list_float.off loop
					one_array_real.force(one_list_float.item,i)
					i:= i + 1
					one_list_float.forth
				end
				c_set_value_array_numeric(one_object.oid,aid,atype,$one_array_real,1) 
			elseif atype = Mtstring_list or atype = Mtasciistring_list then
				is_gc_on := collecting
				collection_off
				one_list_string ?= new_value
				check one_list_string /= Void end
				!!one_array_pointer.make(1,one_list_string.count)  
				from one_list_string.start i:= 1 until one_list_string.off loop
					c_one_string := one_list_string.item.to_c
					one_array_pointer.force($c_one_string,i)
					i:= i + 1
					one_list_string.forth
				end
				c_set_value_array_numeric(one_object.oid,aid,atype,$one_array_pointer,1) 
				if is_gc_on then collection_on end
elseif atype = Mtu8_array then
	one_array_character ?= new_value
	check one_array_character /= Void end 
	c_set_value_array_numeric(one_object.oid,aid,atype,$one_array_character,1) 
			elseif atype = Mts32_array then
				one_array_integer ?= new_value
				check one_array_integer /= Void end 
				c_set_value_array_numeric(one_object.oid,aid,atype,$one_array_integer,1) 
			elseif atype = Mtdouble_array then
				one_array_double ?= new_value
				check one_array_double /= Void end 
				c_set_value_array_numeric(one_object.oid,aid,atype,$one_array_double,1) 
			elseif atype = Mtfloat_array then
				one_array_real ?= new_value
				check one_array_real /= Void end 
				c_set_value_array_numeric(one_object.oid,aid,atype,$one_array_real,1) 
			elseif atype = Mtstring_array or atype = Mtasciistring_array then
				is_gc_on := collecting
				collection_off
				one_array_string ?= new_value
				check one_array_string /= Void end 
				!!one_array_pointer.make(one_array_string.lower,one_array_string.upper)
				from i:= one_array_string.lower until i=one_array_string.upper+1 loop
if one_array_string.item(i) /= Void then
					c_one_string := one_array_string.item(i).to_c
					one_array_pointer.put($c_one_string,i)
else
-- kludge for Void string members
    	c_one_string := Void_string.to_c
	one_array_pointer.put($c_one_string,i)
end
					i:= i+1
				end
				c_set_value_array_numeric(one_object.oid,aid,atype,$one_array_pointer,1) 
				if is_gc_on then collection_on end
			else
				-- Other types not available
			end
		end -- set_value

Void_string:STRING is 
do
	Result := clone("Void")
end

end -- class MT_ATTRIBUTE
