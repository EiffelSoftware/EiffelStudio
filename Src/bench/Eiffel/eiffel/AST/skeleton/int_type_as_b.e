-- Node for type INTEGER

class INT_TYPE_AS

inherit

	BASIC_TYPE

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): INTEGER_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		once
			Result := actual_type;
		end;

	dump: STRING is "INTEGER";
			-- Dumped trace

	actual_type: INTEGER_A is
			-- Actual integer type
		once
			!!Result
		end;

end
