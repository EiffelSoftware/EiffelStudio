class UN_OLD_AS

inherit

	UNARY_AS
		redefine
			operator_is_keyword, simple_format
		end;

feature -- Type check

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		once
		end; -- prefix_feature_name

	operator_name: STRING is "old";
	
	operator_is_keyword: BOOLEAN is true;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.begin;
			expr.simple_format (ctxt);
			ctxt.need_dot;
			ctxt.prepare_for_prefix ("_prefix_old");
			ctxt.put_current_feature;
			ctxt.commit;
		end;

end -- class UN_OLD_AS
