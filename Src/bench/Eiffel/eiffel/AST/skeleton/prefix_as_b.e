indexing

	description:
			"Abstract description of an Eiffel prefixed feature name. %
			%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class PREFIX_AS_B

inherit

	PREFIX_AS
		undefine
			internal_name, infix "<", 
			temp_name
		redefine
			fix_operator
		end;

	INFIX_AS_B
		undefine
			Fix_notation, is_infix, is_prefix
		redefine
			fix_operator
		end

feature -- Property

	fix_operator: STRING_AS_B

end -- class PREFIX_AS_B
