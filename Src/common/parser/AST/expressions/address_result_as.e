class ADDRESS_RESULT_AS

inherit

	EXPR_AS

feature -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item_without_tabs (ti_Dollar);
			ctxt.put_text_item_without_tabs (ti_Result)
		end;

end -- class ADDRESS_RESULT_AS
