indexing

	description: 
		"Error when there is twice or more a feature name %
		%in an undefining clause.";
	date: "$Date$";
	revision: "$Revision $"

class VDUS4 

inherit

	VDRS3
		redefine
			code, subcode, build_explain
		end
	
feature -- Properties

	code: STRING is "VDUS";
			-- Error code

	subcode: INTEGER is 4;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Duplicate name: ");
			ow.put_string (feature_name);
			ow.put_string ("%NIn Undefine clause for parent: ");
			ow.put_string (parent_name);
			ow.new_line;
		end;

end -- class VDUS4
