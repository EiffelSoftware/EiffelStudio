class ADDRESS_CURRENT_AS

inherit

	EXPR_AS
		redefine
			simple_format
		end;

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
			ctxt.put_text_item (ti_Dollar);
			ctxt.put_string ("Current");
		end;

end -- class ADDRESS_CURRENT_AS
