indexing
	description: "Node for BOOLEAN type. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class
	BOOL_TYPE_AS

inherit
	BASIC_TYPE

feature -- Access

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): BOOLEAN_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		once
			Result := actual_type
		end

	actual_type: BOOLEAN_A is
			-- Actual boolean type
		once
			create Result
		end

feature -- Debug

	dump: STRING is "BOOLEAN"
			-- Dumped trace

end -- class BOOL_TYPE_AS
