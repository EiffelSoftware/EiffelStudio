indexing

	description: 
		"AST representation of free unary expression.";
	date: "$Date$";
	revision: "$Revision$"

class UN_FREE_AS

inherit

	UNARY_AS
		rename
			initialize as initialize_unary_as
		redefine
			set, is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (op: like op_name; e: like expr) is
			-- Create a new UN_FREE AST node.
		require
			op_not_void: op /= Void
			e_not_void: e /= Void
		do
			op_name := op
			expr := e
		ensure
			op_name_set: op_name = op
			expr_set: expr = e
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			op_name ?= yacc_arg (0);
			expr ?= yacc_arg (1);
		ensure then
			expr_exists: expr /= Void;
			op_name_exists: op_name /= Void;
		end;

feature -- Properties

	op_name: ID_AS;
			-- Operator name

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

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (op_name, other.op_name) and then
				equivalent (expr, other.expr)
		end

feature {UNARY_AS}	-- Replication

	set_prefix_feature_name (p: like prefix_feature_name) is
		do
			!!op_name.make (p.count);
			op_name.append (clone (p));
			op_name.tail (op_name.count - 8)
				-- 8 is "_prefix_".count
		end;

end -- class UN_FREE_AS
