indexing

	description: "Node for `like Current' type. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class LIKE_CUR_AS_B

inherit

	LIKE_CUR_AS
		undefine
			is_deep_equal, same_as
		end;

	TYPE_B
		undefine
			has_like, simple_format
		end;

feature

	actual_type: TYPE_A is
			-- Useless
		do
			-- Do nothing
		ensure then
			False
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_CURRENT is
		   -- Calcutate the effective type
		do
			!!Result;
			Result.set_actual_type (feat_table.associated_class.actual_type);
		end;
		
end -- class LIKE_CUR_AS_B
