indexing
	description: "Node for type REAL. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class REAL_TYPE_AS

inherit
	BASIC_TYPE

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): REAL_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		once
			Result := actual_type
		end

	actual_type: REAL_A is
			-- Actual real type
		once
			!! Result
		end

	dump: STRING is "REAL"
			-- Dumped trace

end -- class REAL_TYPE_AS
