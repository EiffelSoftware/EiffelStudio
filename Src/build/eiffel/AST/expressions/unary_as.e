
-- Abstract class for unary expression

deferred class UNARY_AS
	
inherit

	EXPR_AS
		redefine
			simple_format
		end

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

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.set_insertion_point;
			expr.simple_format (ctxt);
			if ctxt.last_was_printed then
				ctxt.need_dot;
				ctxt.prepare_for_prefix (prefix_feature_name);
				ctxt.put_current_feature;
				if ctxt.last_was_printed then
					ctxt.commit
				end
			end
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

feature {UNARY_AS}	-- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end;

end
