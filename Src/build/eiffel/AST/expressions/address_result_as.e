class ADDRESS_RESULT_AS

inherit

	EXPR_AS
		redefine
			simple_format
		end

feature

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Dollar);
			ctxt.put_string ("Result");
			ctxt.always_succeed;
		end;
end
