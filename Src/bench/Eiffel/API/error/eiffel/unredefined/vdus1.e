indexing

	description: 
		"Error when a feature name in an undefining clause is not %
		%a final name of the associated parent.";
	date: "$Date$";
	revision: "$Revision $"

class VDUS1 

inherit

	VDRS1
		redefine
			code, build_explain
		end
	
feature -- Properties

	code: STRING is "VDUS";
			-- Error code

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Invalid feature name: ");
			ow.put_string (feature_name);
			ow.put_string ("%NIn Undefine clause for parent: ");
			parent.append_name (ow);
			ow.new_line;
		end;

end -- class VDUS1
