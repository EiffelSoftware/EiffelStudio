indexing

	Product: EiffelStore
	Database: Matisse

class DB_REPOSITORY_MAT

inherit

	DB_REPOSITORY_I

	EXCEPTIONS
		rename
			class_name as exceptions_class_name
		export {NONE} all
		end

	DB_STATUS_USE
		export {NONE} all
		end

	ACTION
		redefine
			execute
		end

	EXT_INTERNAL
		export {NONE} all
		end

	BASIC_ROUTINES
		export {NONE} all
		end

	MATISSE_CONST
		export {NONE} all
		end

creation -- Creation procedure

	make

feature -- Initialization

	make is
		-- Do nothing
        	do			
		end -- make

	load is
		-- Obtain definition of the repository `repository_name' in DB schema.
		require else
			repository_name_exists: repository_name /= Void
		do
			!!implementation.make(repository_name)
			if not(is_ok) then implementation := Void end
		end -- load

feature -- Access

	repository_name: STRING 
            -- Repository name corresponding to class name in DB schema

	dimension: INTEGER is
		-- Number of attributes
		require else
			repository_exists: exists
		local
			rep_attributes : ARRAY[MT_ATTRIBUTE]
		do
			rep_attributes := implementation.attributes
			Result := rep_attributes.count
		end -- dimension

	column_name (i: INTEGER): STRING is
		-- Name of i-th column of table-like repository
		require else
			repository_exists: exists
			good_position: 0 < i and i <= dimension
		local
			rep_attributes : ARRAY[MT_ATTRIBUTE]
		do
			rep_attributes := implementation.attributes
			Result := rep_attributes.item(i).name
		end -- column_name

feature -- Status report

	exists: BOOLEAN is
		-- Does repository `repository_name' exist?
		do
			Result := (implementation/=Void)
		end -- exists

	conforms (obj: ANY): BOOLEAN is
            -- Is loaded repository structure compatible
            -- with `object', namely with same type name and
            -- mapping of all repository column names and types
            -- with object attribute names and types ?
			-- No list or array checking
		require else
			obj_exists: obj /= Void
			-- IMPORTANT : no_attribute_void : none of the attributes of 'obj' should be void
		local
			c_attributes : ARRAY[MT_ATTRIBUTE]
			attribute_found : BOOLEAN
			f_name : STRING
			i,j,ft,attribute_type : INTEGER
			type_a,one_attribute : MT_ATTRIBUTE
			type_o : MT_OBJECT
		do
			if field_count (obj) /= dimension then
				Result := false
			else
				c_attributes := implementation.attributes
				from
					i := 1
					Result := true
				until
					i > field_count (obj)
				loop
					f_name := field_name(i,obj)
					from
						j:= c_attributes.lower
						attribute_found := false
					until
						(j=c_attributes.upper+1) or (attribute_found)
					loop
						attribute_found := f_name.is_equal(c_attributes.item(j).name)
						j:=j+1
					end
					if attribute_found then
						ft := field_type (i, obj) 
						attribute_type := c_attributes.item(j-1).type
						inspect ft
						when Integer_type then
							Result := (attribute_type = Mts32) 
						when Real_type then
							Result := (attribute_type = Mtfloat)
						when Double_type then
							Result := (attribute_type = Mtdouble)
						when Character_type then
							Result := (attribute_type = Mtchar) or (attribute_type = Mtasciichar)
						else
							if class_name(field(i,obj)).is_equal("STRING")  then
								Result := (attribute_type = Mtstring) or  (attribute_type = Mtasciistring)
							else
								Result := False
							end 
						 end-- inspect
						if Result = False then i:= field_count(obj) end
					else
						i:= field_count(obj)
						Result := False
					end
					i := i + 1
				end -- loop
			end -- if
		end -- conforms

feature -- Status setting

	change_name (new_name: STRING) is
		-- Set `repository_name' with `new_name'.
		require else
			rep_exists: new_name /= Void
			rep_not_empty : not new_name.empty
		do 
			repository_name := new_name
			implementation := Void
		end -- change_name

	allocate (obj: ANY; rep: STRING) is
		-- Do nothing
		require else
			rep /= Void
			obj /= Void
		do
		end -- allocate

feature -- Basic operations

	generate_class is
		-- Generate an Eiffel class according to the data
		-- description loaded.
		local
			buffer : STRING
			c_attributes : ARRAY[MT_ATTRIBUTE]
			i,attribute_type : INTEGER
		do
			!!buffer.make(512)
			 buffer.wipe_out
			buffer.append (repository_name)
			buffer.to_upper
			io.putstring ("class ")
			io.putstring (buffer)
			io.putstring ("%N%Nfeature%N%N")
			from
				i:=1
				c_attributes := implementation.attributes
			until
				i>dimension
			loop
				io.putchar ('%T')
				io.putstring(c_attributes.item(i).name) io.putstring(" : ") 
				attribute_type := c_attributes.item(i).type
				if attribute_type = Mts32 then
					io.putstring("INTEGER")
				elseif attribute_type = Mtdouble then
					io.putstring("DOUBLE")
				elseif attribute_type = Mtfloat then
					io.putstring("REAL")
				elseif attribute_type = Mtchar or attribute_type = Mtasciichar then
					io.putstring("CHARACTER")
				elseif attribute_type = Mtstring or attribute_type = Mtasciistring then
					io.putstring("STRING")
				elseif attribute_type = Mtstring_list then
					io.putstring("LINKED_LIST[STRING]")
				elseif attribute_type = Mts32_list then
					io.putstring("LINKED_LIST[INTEGER]")
				elseif attribute_type = Mtdouble_list then
					io.putstring("LINKED_LIST[DOUBLE]")
				elseif attribute_type = Mtfloat_list then
					io.putstring("LINKED_LIST[REAL]")
				elseif attribute_type = Mtstring_array then
					io.putstring("ARRAY[STRING]")
				elseif attribute_type = Mts32_array then
					io.putstring("ARRAY[INTEGER]")
				elseif attribute_type = Mtdouble_array then
					io.putstring("ARRAY[DOUBLE]")
				elseif attribute_type = Mtfloat_array then
					io.putstring("ARRAY[REAL]")
				else
					io.putstring("UNKOWN_TYPE")
				end 
				io.putstring("%N%N")
				i:= i + 1
			end -- loop
			io.putstring ("end -- class ")
			io.putstring (buffer)
			io.new_line
		end -- generate_class

	execute is
            -- Implement an ACTION operation
		do
		end -- execute

feature {DB_STORE_MAT} -- Implementation

	implementation : MT_CLASS

end -- class DB_REPOSITORY_MAT

