class UN_OLD_AS

inherit

	UNARY_AS
		redefine
			simple_format, operator_is_keyword
		end

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
			ctxt.put_text_item (ti_Old_keyword);
			ctxt.put_space;
			ctxt.format_ast (expr);
		end;

end -- class UN_OLD_AS
