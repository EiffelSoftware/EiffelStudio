class ALL_AS

inherit

	FEATURE_SET_AS
		redefine
			simple_format
		end

feature -- Initialization

	set is
			-- Yacc initialization
		do
		end;

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_All_keyword);
			ctxt.always_succeed;
		end;

end
