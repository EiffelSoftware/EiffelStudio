class ARRAY_AS

inherit

	ATOMIC_AS
		redefine
			simple_format, string_value
		end

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS];
			-- Expression list symbolizing the manifest array

feature -- Initialization

	set is
			-- Yacc initialization
		do
			expressions ?= yacc_arg (0);
			if expressions = Void then
				-- Create empty list
				!!expressions.make (0)
			end
		ensure then
			expressions_exists: expressions /= Void;
		end;

	simple_format(ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_text_item (ti_L_array);
			ctxt.set_separator (ti_Comma);
			ctxt.abort_on_failure;
			ctxt.space_between_tokens;
			expressions.simple_format (ctxt);
			if ctxt.last_was_printed then
				ctxt.put_text_item (ti_R_array);
				ctxt.commit
			end;
		end;	

feature {ARRAY_AS}	-- Replication

	set_expressions (e: like expressions) is
		require
			valid_arg: e /= Void
		do
			expressions := e
		end;

feature -- Case storage

	string_value: STRING is
		do
			Result := "<< >>"
		end;

end
