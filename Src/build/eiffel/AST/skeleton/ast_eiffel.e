-- Abstract node produce by yacc

deferred class AST_EIFFEL

inherit

	AST_YACC;
	SHARED_ERROR_HANDLER;
	SHARED_TEXT_ITEMS

feature {SERVER} -- Identity

	is_feature_obj: BOOLEAN is
			-- Is the current object an instance of FEATURE_AS ?
		do
			-- Do nothing
		end;

	is_invariant_obj: BOOLEAN is
			-- Is the current object an instance of INVARIANT_AS ?
		do
			-- Do nothing
		end;

feature -- formatter

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text according to context.
		do
			-- Do nothing

			-- should do nothing. Now put AST class name
			ctxt.put_string (generator);
		end;
		
	position: INTEGER is
			-- position of the item in text
		do
			Result := -1;
				-- treated as unknown
		end;

end
