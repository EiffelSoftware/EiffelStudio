class ARRAY_AS

inherit

	ATOMIC_AS
		redefine
			string_value, simple_format
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

feature -- Simple formatting

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_text_item (ti_L_array);
			ctxt.set_separator (ti_Comma);
			ctxt.space_between_tokens;
			expressions.simple_format (ctxt);
			ctxt.put_text_item (ti_R_array);
			ctxt.commit
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

end -- class ARRAY_AS
