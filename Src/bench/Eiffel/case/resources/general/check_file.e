indexing
	
	description:"class responsible for checking that everything is %
				% alright with a file"
	author:pascalf
	goals: "protection when eiffel user want to load/save... a file"
	components: EiffelCase 	
	status:""
	date:""
	revision:""

class CHECK_FILE 
	
creation 
	make

feature -- creation
	
	make is
	do
		set_error ( FALSE )
	end

feature -- execution

	check_load ( f : FILE; is_plain : BOOLEAN ): STRING is
	do
		!! Result.make (20)
		if f.exists then
			if f.is_directory then Result := "The entered file is a directory" end
			if not f.is_readable then Result := "The entered file is not readable" end
			if not f.is_owner then Result := "There is a problem of access right " end
			if is_plain and then not f.is_plain then Result := "The file is not a plain file" end
			if Result.count >0 then set_error(TRUE) end	
		else
			Result := "No such file or directory"
		end
		if Result.count >0 then set_error ( TRUE ) end
	end

	check_save ( f: FILE ; is_plain: BOOLEAN ): STRING is
	do
		!! Result.make ( 20)
		if f.exists then
			if not f.is_owner then
				Result := "There is a problem of access right"
			end
			if f.is_directory then Result := "The entered file is a directory" end
			if is_plain and then not f.is_plain then Result := "The file is not a plain file" end
			if not f.is_writable then 
				Result :="The file is not writable"
			end
		else
				Result := "No such file or directory"
		end
		if Result.count >0 then set_error ( TRUE ) end
	end

feature  -- implementation

	has_error : BOOLEAN

	set_error ( b :BOOLEAN ) is 
	do
		has_error := b
	end

end -- class check_file	