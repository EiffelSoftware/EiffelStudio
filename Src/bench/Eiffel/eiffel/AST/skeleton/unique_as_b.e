indexing

	description: "Description of a unique value. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class UNIQUE_AS_B

inherit

	UNIQUE_AS;
	ATOMIC_AS_B
		undefine
			is_unique
		redefine
			type_check
		end

feature

	type_check is
			-- Type check a unique type
		do
			context.put (Integer_type);
		end;

end -- class UNIQUE_AS_B
