indexing

	description: 
		"List of feature names.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_LIST_AS

inherit

	FEATURE_SET_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			features ?= yacc_arg (0);
		end;

feature -- Properties

	features: EIFFEL_LIST [FEATURE_NAME];
			-- List of feature names

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.set_separator (ti_Comma);
			ctxt.set_space_between_tokens;
			features.simple_format (ctxt);
		end;

end -- class FEATURE_LIST_AS
