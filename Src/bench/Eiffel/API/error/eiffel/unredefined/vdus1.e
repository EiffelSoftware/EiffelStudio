-- Error when a feature name in an undefining clause is not a final name
-- of the associated parent

class VDUS1 

inherit

	VDRS1
		redefine
			code, build_explain
		end
	
feature 

	code: STRING is "VDUS";
			-- Error code

	build_explain is
		do
			put_string ("Invalid feature name: ");
			put_string (feature_name);
			put_string ("%NIn Undefine clause for parent: ");
			parent.append_clickable_name (error_window);
			new_line;
		end;

end 
