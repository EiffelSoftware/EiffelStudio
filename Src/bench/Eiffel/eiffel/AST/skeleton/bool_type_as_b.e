indexing

	description: "Node for BOOLEAN type. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class BOOL_TYPE_AS_B

inherit

	BOOL_TYPE_AS
		undefine
			same_as, associated_eiffel_class,
			append_to
		end;

	BASIC_TYPE_B

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): BOOLEAN_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		once
			Result := actual_type;
		end;

	actual_type: BOOLEAN_A is
			-- Actual boolean type
		once
			!!Result
		end;

end -- class BOOL_TYPE_AS_B
