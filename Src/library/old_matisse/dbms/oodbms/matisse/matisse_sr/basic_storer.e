deferred class BASIC_STORER 

	inherit

		GENERAL 
			export {NONE} all;{ANY} Default_pointer
		end

		FILE_STORER    

feature {NONE} -- Initialization

	make(arg_size : INTEGER) is
		local 
			special_size : INTEGER
		do
			if arg_size < default_size  then special_size := Default_size else special_size := arg_size  end
			!!implementation.make_area(special_size)
			size := special_size
			index := 0
			area := implementation.area
		end 

feature -- Element Change

	put_char,putchar(one_char : CHARACTER) is
		-- Add one character
		do
			if index=size then index := index-1 dump_to_file end 
			put_char_in_special_char(pointer_on_special_item_char(index,$area),one_char)
			index := index + 1
			if index=size then index := index-1 dump_to_file end 
		end -- putchar

	putint,put_int(one_integer:INTEGER) is
		-- Add one integer
		do
			put_char(c_index(one_integer,3))
 			put_char(c_index(one_integer,2))
			put_char(c_index(one_integer,1))
			put_char(c_index(one_integer,0))
		end

	putreference,put_reference( one_pointer : POINTER ) is
		-- Add one reference
		do
			put_char(c_index_ref(one_pointer,3))
			put_char(c_index_ref(one_pointer,2))
			put_char(c_index_ref(one_pointer,1))
			put_char(c_index_ref(one_pointer,0))
		end

	putobject,put_object( one_object : ANY ) is
		-- Add one object
		require else
			one_object_not_void : one_object /= Void
		local
			one_int,i : INTEGER
		do
			putreference($one_object) 
			putint(c_object_flags($one_object))
			if c_is_special_object($one_object) then
				putint(c_size_of_normal_flag($one_object))
				put($one_object,c_size_of_special($one_object))
			else
 				put($one_object,c_size_of_normal($one_object))
			end 
		end -- putobject

	put( p : POINTER ; s : INTEGER) is
		-- Put entity refered to by 'p' of size 's' in area and dump it to file when necessary.
		require
			p_not_default : p /= Default_pointer
			s_positive : s > 0
		local 
			i : INTEGER
		do
			if (index + s) >= implementation.area.count then
				from 
					i := 0
				until
					i=s
				loop
					put_char_in_special_char(pointer_on_special_item_char(index,$area),c_i_th(p,i-1))
					if index = size-1 then  dump_to_file else index:=index+1 end 
 					i:=i+1 
 				end -- loop
 			else
				from 
					i := 0
 				until
					i=s
				loop
					put_char_in_special_char(pointer_on_special_item_char(index,$area),c_i_th(p,i))
					i:=i+1
					index:=index+1
 				end  -- loop
			end -- if
		ensure
			-- Implementation now has entity refered to by 'p' of size 's' 
		end -- put

	dump_to_file is
		-- Append buffer content to file.
		require
			file_not_void : media /= Void
		local
			i : INTEGER
		do
			-- Append size of area. This size must fit into two characters (basic store file format).
			index := index + 1
			media.putchar(c_index(index,1)) media.putchar(c_index(index,0)) index := index-1
			-- Append each element of area.         
			from 
				i := 0
			until 
				i = index+1
			loop
				media.putchar(implementation.area.item(i)) 
				i := i +1
			end -- loop
			-- Reset index to head of area.
			index := 0
		end -- dump_to_file

	flush is
		-- Append to file all data remaining in area.
		do
			if index /= 0 then index := index-1 dump_to_file  end 
		end -- flush

feature -- Access

	max_d_type : INTEGER is 0 -- Not used

end -- class BASIC_STORER
