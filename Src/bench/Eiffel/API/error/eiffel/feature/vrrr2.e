indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class VRRR2 

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode
		end;

feature -- Properties

	code: STRING is "VRRR";
			-- Error code

	subcode: INTEGER is 2;

	is_deferred: BOOLEAN;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Kind of routine: ");
			if is_deferred then
				ow.put_string ("deferred%N")
			else
				ow.put_string ("external%N")
			end;
		end;

feature {COMPILER_EXPORTER}

	set_is_deferred (b: BOOLEAN) is
		do
			is_deferred := b;
		end;

end -- class VRRR2
