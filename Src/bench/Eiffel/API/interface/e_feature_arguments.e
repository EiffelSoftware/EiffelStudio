indexing

	description: 
		"Representation of feature arguments.";
	date: "$Date$";
	revision: "$Revision $"

class E_FEATURE_ARGUMENTS

inherit

	FIXED_LIST [TYPE_A]

creation

	make

feature -- Property

	argument_names: FIXED_LIST [STRING];
			-- Argument names

feature -- Setting

	set_argument_names (n: like argument_names) is
			-- Set `argument_names' to `n'.
		require
			valid_n: n /= Void
		do
			argument_names := n	
		ensure
			set: argument_names = n
		end;

end -- class E_FEATURE_ARGUMENTS
