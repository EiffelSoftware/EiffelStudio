indexing

	description:
			"Abstract description of an Eiffel prefixed feature name. %
			%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class PREFIX_AS_B

inherit

	PREFIX_AS
		rename
			fix_operator as old_fix_operator
		undefine
			internal_name, infix "<", 
			main_feature_format, temp_name
		end;

	INFIX_AS_B
		undefine
			Fix_notation, is_infix, is_prefix
		select
			fix_operator
		end

feature

end -- class PREFIX_AS_B
