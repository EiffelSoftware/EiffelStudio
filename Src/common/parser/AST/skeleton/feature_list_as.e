class FEATURE_LIST_AS

inherit

	FEATURE_SET_AS

feature -- Attributes

	features: EIFFEL_LIST [FEATURE_NAME];
			-- List of feature names

feature -- Initialization

	set is
			-- Yacc initialization
		do
			features ?= yacc_arg (0);
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.set_separator (ti_Comma);
			ctxt.set_space_between_tokens;
			features.simple_format (ctxt);
		end;

end -- class FEATURE_LIST_AS
