indexing

	description: 
		"AST representation of an Eiffel function pointer for Current.";
	date: "$Date$";
	revision: "$Revision $"

class ADDRESS_CURRENT_AS

inherit

	EXPR_AS

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new ADDRESS_CURRENT AST node.
		do
			-- Do nothing.
		end

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
			ctxt.put_text_item_without_tabs (ti_Current)
		end;

end -- class ADDRESS_CURRENT_AS
