indexing

	description: 
		"AST representation of an `all' structure.";
	date: "$Date$";
	revision: "$Revision $"

class ALL_AS

inherit

	FEATURE_SET_AS
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	 initialize is
			-- Create a new ALL AST node.
		do
			-- Do nothing.
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
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
			ctxt.put_text_item (ti_All_keyword);
		end;

end -- class ALL_AS
