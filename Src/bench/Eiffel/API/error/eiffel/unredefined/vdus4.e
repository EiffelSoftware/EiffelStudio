-- Error when there is twice or more a feature name in an undefining clause

class VDUS4 

inherit

	VDRS3
		redefine
			code, subcode, build_explain
		end
	
feature 

	code: STRING is "VDUS";
			-- Error code

	subcode: INTEGER is 4;

	build_explain is
		do
			put_string ("Duplicate name: ");
			put_string (feature_name);
			put_string ("%NIn Undefine clause for parent: ");
			put_string (parent_name);
			new_line;
		end;

end 
