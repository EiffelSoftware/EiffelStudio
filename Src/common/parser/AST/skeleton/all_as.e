class ALL_AS

inherit

	FEATURE_SET_AS

feature -- Initialization

	set is
			-- Yacc initialization
		do
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_All_keyword);
		end;

end -- class ALL_AS
