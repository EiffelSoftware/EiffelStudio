-- Error for not supported construction

class NOT_SUPPORTED 

obsolete "The language (as defined in ETL) should be fully supported"

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature 

	message: STRING;

	set_message (i: STRING) is
		do
			message := i;
		end;

	code: STRING is "NOT_SUPPORTED";
			-- Error code

	build_explain is
		do
			put_string ("Error message: ");
			put_string (message);
			new_line;
		end

end
