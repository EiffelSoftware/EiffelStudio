-- Error object sent by the compiler to the workbench

class ERROR_STONE

inherit

	EIFFEL_ENV;
	FILED_STONE
		redefine
			help_text
		end

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

	stone_type: INTEGER is do Result := Explain_type end;

	stone_name: STRING is do Result := l_Explain end;

	help_text: STRING is
			-- Content of the file where the help is
		do
			Result := origin_text
		end;

	file_name: STRING is
			-- File where the help is
		do
			!!Result.make (50);
			Result.append (help_path);
			Result.append (code)
		end;

	set_file_name (s: STRING) is do end;
			-- Do nothing

	click_list: ARRAY [CLICK_STONE] is do end;

	signature: STRING is do Result := code end;

	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
			-- No
		do
			-- Do nothing
		end

end
