indexing

	description: 
		"Error for not supported construction.";
	date: "$Date$";
	revision: "$Revision $"

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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Error message: ");
			ow.put_string (message);
			ow.new_line;
		end

end -- class NOT_SUPPORTED
