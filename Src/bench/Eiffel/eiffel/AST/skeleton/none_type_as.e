indexing
	description: "Node for NONE type. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class NONE_TYPE_AS

inherit
	BASIC_TYPE
		redefine
			format
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
			!! Result
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_string ("NONE")
		end

	dump: STRING is "NONE"
			-- Dumped trace

end -- class NONE_TYPE_AS
