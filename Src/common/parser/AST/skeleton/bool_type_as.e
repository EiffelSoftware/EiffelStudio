-- Node for BOOLEAN type

class BOOL_TYPE_AS

inherit

	BASIC_TYPE

feature


	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): BOOLEAN_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		once
			Result := actual_type;
		end;

	dump: STRING is "BOOLEAN";
			-- Dumped trace

	actual_type: BOOLEAN_A is
			-- Actual boolean type
		once
			!!Result
		end;

end
