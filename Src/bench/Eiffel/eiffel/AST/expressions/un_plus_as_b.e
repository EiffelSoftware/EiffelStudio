class UN_PLUS_AS

inherit

	UNARY_AS
		redefine
			byte_node
		end

feature -- Type check

	prefix_feature_name: STRING is
			-- Internal name of the prefixed feature
		once
			Result := "_prefix_plus";
		end;

feature -- Byte node

	byte_node: UN_PLUS_B is
			-- Associated byte code
		local
			access_line: ACCESS_LINE;
			feature_b: FEATURE_B;
		do
			!!Result;
			Result.set_expr (expr.byte_node);

			access_line := context.access_line;
			feature_b ?= access_line.access;
			Result.init (feature_b);
			access_line.forth;
		end;

end
