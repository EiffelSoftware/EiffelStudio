indexing

	description: "Abstract node produce by yacc.";
	date: "$Date$";
	revision: "$Revision$"

deferred class AST_EIFFEL

inherit

	AST_YACC;
	SHARED_ERROR_HANDLER;
	SHARED_TEXT_ITEMS

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text according to context.
		deferred
		end;

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

	position: INTEGER is
			-- position of the item in text
		do
			Result := -1;
				-- treated as unknown
		end;

end -- class AST_EIFFEL
