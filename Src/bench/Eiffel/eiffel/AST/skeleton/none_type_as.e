indexing
	description: "Node for NONE type. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class NONE_TYPE_AS

inherit
	BASIC_TYPE

create
	initialize

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_none_type_as (Current)
		end

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := null_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := null_location
		end

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): NONE_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		once
			Result := actual_type
		end

	actual_type: NONE_A is
			-- Actual integer type
		once
			create Result
		end

	dump: STRING is "NONE"
			-- Dumped trace

end -- class NONE_TYPE_AS
