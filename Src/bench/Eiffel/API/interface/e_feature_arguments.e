indexing

	description: 
		"Representation of feature arguments.";
	date: "$Date$";
	revision: "$Revision $"

class E_FEATURE_ARGUMENTS

inherit
	FIXED_LIST [TYPE_A]
		rename
			put_i_th as list_put_i_th
		export
			{NONE} list_put_i_th
		redefine
			make
		end

creation
	make

feature -- initialization

	make (n: INTEGER) is
			-- Replace `make' by `make_filled' from FIXED_LIST in order
			-- to minimize the change on the compiler due to the new FIXED_LIST
		do
			make_filled (n)
		end

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

feature -- Element change

	put_i_th (type: TYPE_A; i: INTEGER) is
			-- Put `type' at `i' position.
		require
			valid_type: type /= Void
		do
			list_put_i_th (type, i)
		end;

end -- class E_FEATURE_ARGUMENTS
