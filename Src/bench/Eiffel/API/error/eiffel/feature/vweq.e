indexing

	description: 
		"Error for invalid equality.";
	date: "$Date$";
	revision: "$Revision $"

class VWEQ 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature -- Properties

	left_type: TYPE_A;
			-- Left type of the equality

	right_type: TYPE_A;
			-- Right type of the equality

	code: STRING is "VWEQ";
			-- Error code

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		do
			ow.put_string ("Left-hand type: ");
			left_type.append_to (ow);
			ow.put_string ("%NRight-hand type: ");
			right_type.append_to (ow);
			ow.new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_right_type (t: TYPE_A) is
		do
			right_type := t;
		end;

	set_left_type (t: TYPE_A) is
		do
			left_type := t;
		end;

end -- class VWEQ
