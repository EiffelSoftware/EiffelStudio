-- Error object sent by the compiler to the workbench

class ERROR_STONE

inherit

	EIFFEL_ENV;
	FILED_STONE
		redefine
			help_text
		end;
	INTERFACE_W

creation

	make

feature

	make (an_errori: ERROR) is
		do
			error_i := an_errori
		end;
 
	error_i: ERROR;

feature

	code: STRING is
			-- Code error
		do
			Result := error_i.code
		end;

	header: STRING is 
		do 
			Result := code;
			if Result = Void then
				!!Result.make (0)
			end;
		end;

	stone_type: INTEGER is do Result := Explain_type end;

	stone_name: STRING is do Result := l_Explain end;

	help_text: STRING is
			-- Content of the file where the help is
		do
			Result := origin_text;
			if (Result = Void) then
				Result := l_No_help_available
			end;
		end;

	file_name: STRING is
			-- File where the help is
		local
			fn: FILE_NAME
		do
			!! fn.make_from_string (help_path);
			fn.set_file_name (code);
			Result := fn
		end;

	set_file_name (s: STRING) is do end;
			-- Do nothing

	click_list: ARRAY [CLICK_STONE] is do end;

	signature: STRING is do Result := code end;

	icon_name: STRING is
		do
			Result := code;
			if Result = Void then
				!!Result.make (0)
			end;
		end;

	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
			-- No
		do
			-- Do nothing
		end

end
