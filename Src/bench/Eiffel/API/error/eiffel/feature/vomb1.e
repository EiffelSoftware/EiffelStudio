indexing

	description: 
		"Inspect expression is not of type INTEGER or CHARACTER.";
	date: "$Date$";
	revision: "$Revision $"

class VOMB1 

inherit

	VOMB
		redefine
			subcode, build_explain
		end;

feature -- Properties

	subcode: INTEGER is
		do
			Result := 1;
		end;

	type: TYPE_A;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Type: ");
			type.append_to (ow);
			ow.new_line;	
		end;

feature {COMPILER_EXPORTER}

	set_type (t: TYPE_A) is
		do
			type := t;
		end;

end -- class VOMB1
