indexing

	description: 
		"AST representation of retry instruction";
	date: "$Date$";
	revision: "$Revision$"

class RETRY_AS

inherit

	INSTRUCTION_AS

feature {AST_FACTORY} -- Initialization

	initialize (l: INTEGER) is
			-- Create a new RETRY AST node.
		do
			line_number := l
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			line_number := yacc_line_number
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
			ctxt.put_breakable;
			ctxt.put_text_item (ti_Retry_keyword);
		end;

end -- class RETRY_AS
