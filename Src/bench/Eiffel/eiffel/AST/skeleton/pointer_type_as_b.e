indexing

	description: "Node for type POINTER. Version for Bench.";
	date: "Date: $";
	revision: "Revision: $"

class POINTER_TYPE_AS_B

inherit

	POINTER_TYPE_AS
		undefine
			same_as, associated_eiffel_class,
			append_to
		end;

	BASIC_TYPE_B

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): POINTER_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		once
			Result := actual_type;
		end;

	actual_type: POINTER_A is
			-- Actual pointer type
		once
			!!Result
		end;

end -- class POINTER_TYPE_AS_B
