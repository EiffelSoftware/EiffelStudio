indexing

	description: 
		"Abstract syntax tree node.";
	date: "$Date$";
	revision: "$Revision$"

deferred class AST_EIFFEL

inherit

	AST_YACC;
	SHARED_ERROR_HANDLER;
	SHARED_TEXT_ITEMS

feature -- Access

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		do
		end

feature {AST_EIFFEL, COMPILER_EXPORTER} -- Output

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
