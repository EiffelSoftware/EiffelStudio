indexing

	description: 
		"AST representation of manifest tuple.";
	date: "$Date$";
	revision: "$Revision $"

class TUPLE_AS

inherit

	ATOMIC_AS
		redefine
			is_equivalent
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			expressions ?= yacc_arg (0);
			if expressions = Void then
					-- Create empty list
				!! expressions.make_filled (0)
			end
		ensure then
			expressions_exists: expressions /= Void;
		end;

feature -- Properties

	expressions: EIFFEL_LIST [EXPR_AS];
			-- Expression list symbolizing the manifest tuple

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expressions, other.expressions)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_L_array);
			ctxt.set_separator (ti_Comma);
			ctxt.set_space_between_tokens;
			ctxt.format_ast (expressions);
			ctxt.put_text_item_without_tabs (ti_R_array);
		end;

	string_value: STRING is "";

feature {TUPLE_AS}	-- Replication

	set_expressions (e: like expressions) is
		require
			valid_arg: e /= Void
		do
			expressions := e
		end;

end -- class TUPLE_AS

