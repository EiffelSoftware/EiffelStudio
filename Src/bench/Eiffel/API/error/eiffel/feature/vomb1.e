-- Inspect expression is not of type INTEGER or CHARACTER

class VOMB1 

inherit

	VOMB
		redefine
			subcode, build_explain
		end;

feature

	subcode: INTEGER is
		do
			Result := 1;
		end;

	type: TYPE_A;

	set_type (t: TYPE_A) is
		do
			type := t;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Type: ");
			type.append_to (ow);
			ow.new_line;	
		end;

end
