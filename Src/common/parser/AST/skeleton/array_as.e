indexing
	description: 
		"AST representation of manifest array."
	date: "$Date$"
	revision: "$Revision $"

class
	ARRAY_AS

inherit
	ATOMIC_AS
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (exp: like expressions) is
			-- Create a new Manifest ARRAY AST node.
		require
			exp_not_void: exp /= Void
		do
			expressions := exp
		ensure
			expressions_set: expressions = exp
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_array_as (Current)
		end

feature -- Attributes

	expressions: EIFFEL_LIST [EXPR_AS];
			-- Expression list symbolizing the manifest array

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expressions, other.expressions)
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_text_item (ti_L_array);
--			ctxt.set_separator (ti_Comma);
--			ctxt.set_space_between_tokens;
--			ctxt.format_ast (expressions);
--			ctxt.put_text_item_without_tabs (ti_R_array);
--		end

	string_value: STRING is ""

feature {ARRAY_AS}	-- Replication

	set_expressions (e: like expressions) is
		require
			valid_arg: e /= Void
		do
			expressions := e
		end

end -- class ARRAY_AS
