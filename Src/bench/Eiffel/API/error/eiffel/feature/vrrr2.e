
class VRRR2 

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode
		end;

feature 

	code: STRING is "VRRR";
			-- Error code

	subcode: INTEGER is 2;

	is_deferred: BOOLEAN;

	set_is_deferred (b: BOOLEAN) is
		do
			is_deferred := b;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Kind of routine: ");
			if is_deferred then
				ow.put_string ("deferred%N")
			else
				ow.put_string ("external%N")
			end;
		end;

end 
