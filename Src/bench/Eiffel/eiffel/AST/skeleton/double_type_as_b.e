-- Node for DOUBLE type

class DOUBLE_TYPE_AS

inherit

	BASIC_TYPE

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): DOUBLE_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		once
			Result := actual_type;
		end;

	actual_type: DOUBLE_A is
			-- Double actual type
		once
			!!Result;
		end;

	dump: STRING is "DOUBLE";
			-- Dumped trace

end
