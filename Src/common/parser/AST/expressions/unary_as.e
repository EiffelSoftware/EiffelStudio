indexing

	description: "Abstract class for unary expression";
	date: "$Date$";
	revision: "$Revision$"

deferred class UNARY_AS
	
inherit

	EXPR_AS

feature -- Attributes

	expr: EXPR_AS;
			-- Expression

feature -- Initialization

	set is
			-- Yacc initialization
		do
			expr ?= yacc_arg (0);
		ensure then
			expr_exists: expr /= Void;
		end;

feature 

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		deferred
		end;

	operator_name: STRING is
		deferred
		end;
	
	operator_is_special: BOOLEAN is
		do
			Result := true;
		end;
	
	operator_is_keyword: BOOLEAN is 
		do
			Result := false;
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_prefix (prefix_feature_name);
			ctxt.put_prefix_feature;
			ctxt.put_space;
			expr.simple_format (ctxt);
		end;

feature {UNARY_AS} -- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end;

end -- class UNARY_AS
