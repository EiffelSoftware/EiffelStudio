indexing

	description: "Free unary expression description";
	date: "$Date$";
	revision: "$Revision$"

class UN_FREE_AS

inherit

	UNARY_AS
		redefine
			set
		end

feature -- Attributes

	op_name: ID_AS;
			-- Operator name

feature -- Initialization

	set is
			-- Yacc initialization
		do
			op_name ?= yacc_arg (0);
			expr ?= yacc_arg (1);
		ensure then
			expr_exists: expr /= Void;
			op_name_exists: op_name /= Void;
		end;

feature -- Type check

	prefix_feature_name: STRING is
			-- Internal name
		do
			!!Result.make (7 + op_name.count);
			Result.append (Internal_prefix);
			Result.append (op_name);
		end;

	Internal_prefix: STRING is "_prefix_";
			-- Prefix string for internal name

	operator_name: STRING is
		do
			Result := op_name;
		end;

feature {UNARY_AS}	-- Replication

	set_prefix_feature_name (p: like prefix_feature_name) is
		do
			!!op_name.make (p.count);
			op_name.append (clone (p));
			op_name.tail (op_name.count - 8)
				-- 8 is "_prefix_".count
		end;

end -- class UN_FREE_AS
