-- Node for type INTEGER

class NONE_TYPE_AS

inherit

	BASIC_TYPE
		redefine format
	end

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): NONE_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		once
			Result := actual_type;
		end;

	dump: STRING is "NONE";
			-- Dumped trace

	actual_type: NONE_A is
			-- Actual integer type
		once
			!!Result;
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_string ("none");
			ctxt.always_succeed;
		end;

end
