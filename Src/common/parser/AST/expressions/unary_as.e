indexing
	description: 
		"AST representation of unary expression."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	UNARY_AS
	
inherit
	EXPR_AS

	SYNTAX_STRINGS
		export
			{NONE} all
		undefine
			is_equal
		end

feature {AST_FACTORY} -- Initialization

	initialize (e: like expr) is
			-- Create a new UNARY AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
		ensure
			expr_set: expr = e
		end

feature -- Attributes

	expr: EXPR_AS
			-- Expression

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		deferred
		end

	operator_name: STRING is
		deferred
		end
	
	operator_is_special: BOOLEAN is
		do
			Result := true
		end
	
	operator_is_keyword: BOOLEAN is 
		do
			Result := false
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.prepare_for_prefix (prefix_feature_name);
--			ctxt.put_prefix_feature;
--			ctxt.put_space;
--			expr.simple_format (ctxt);
--		end

feature {UNARY_AS} -- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end

end -- class UNARY_AS
