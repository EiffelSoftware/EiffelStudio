indexing

	description: "Node for type INTEGER. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INT_TYPE_AS

inherit
	BASIC_TYPE

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): INTEGER_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		once
			Result := actual_type
		end

	actual_type: INTEGER_A is
			-- Actual integer type
		once
			!! Result
		end

	dump: STRING is "INTEGER"
			-- Dumped trace

end -- class INT_TYPE_AS
