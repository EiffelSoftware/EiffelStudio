indexing

	description: 
		"AST representation of an Eiffel function pointer for Result types.";
	date: "$Date$";
	revision: "$Revision $"

class ADDRESS_RESULT_AS

inherit

	EXPR_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item_without_tabs (ti_Dollar);
			ctxt.put_text_item_without_tabs (ti_Result)
		end;

end -- class ADDRESS_RESULT_AS
