-- Error when a deferred or an external feature has a rescue clause

class VXRC 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;

feature 

	code: STRING is "VXRC";
			-- Error code

	is_deferred: BOOLEAN;

	set_deferred (b: BOOLEAN) is
		do
			is_deferred := b
		end;

	build_explain is
		do
			if is_deferred then
				put_string ("Kind of routine: deferred%N");
			else
				put_string ("Kind of routine: external%N");
			end;
		end;

end 
