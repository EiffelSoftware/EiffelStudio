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
		end

creation
	make, make_filled

feature -- Property

	argument_names: LIST [STRING];
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
