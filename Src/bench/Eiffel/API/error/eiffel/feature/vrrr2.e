
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

	build_explain is
		do
			put_string ("Kind of routine: ");
			if is_deferred then
				put_string ("deferred%N")
			else
				put_string ("external%N")
			end;
		end;

end 
