indexing

	description: "Node for NONE type. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class NONE_TYPE_AS_B

inherit

	NONE_TYPE_AS
		undefine
			is_deep_equal, same_as
		end;

	BASIC_TYPE_B
		undefine
			simple_format
		redefine 
			format
		end

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): NONE_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		once
			Result := actual_type;
		end;

	actual_type: NONE_A is
			-- Actual integer type
		once
			!!Result;
		end;

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text
		do
			ctxt.put_string ("NONE");
			ctxt.always_succeed;
		end;

end -- class NONE_TYPE_AS_B
