indexing

	description: 
		"Error when a deferred or an external feature has a rescue clause.";
	date: "$Date$";
	revision: "$Revision $"

class VXRC 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end;

feature -- Properties

	code: STRING is "VXRC";
			-- Error code

	is_deferred: BOOLEAN;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			if is_deferred then
				ow.put_string ("Kind of routine: deferred%N");
			else
				ow.put_string ("Kind of routine: external%N");
			end;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_deferred (b: BOOLEAN) is
		do
			is_deferred := b
		end;

end -- class VXRC
