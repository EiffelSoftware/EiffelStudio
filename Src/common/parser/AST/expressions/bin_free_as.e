indexing

	description: 
		"AST representation of a free binary expression.";
	date: "$Date$";
	revision: "$Revision$"

class BIN_FREE_AS

inherit

	BINARY_AS
		rename
			initialize as initialize_binary_as
		redefine
			set, operator_is_keyword, is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (l: like left; op: like op_name; r: like right) is
			-- Create a new BIN_FREE AST node.
		require
			l_not_void: l /= Void
			op_not_void: op /= Void
			r_not_void: r /= Void
		do
			left := l
			op_name := op
			right := r
		ensure
			left_set: left = l
			op_name_set: op_name = op
			right_set: right = r
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			left ?= yacc_arg (0);
			op_name ?= yacc_arg (1);
			right ?= yacc_arg (2);
		ensure then
			left_exists: left /= Void;
			right_exists: right /= Void;
			operator_exists: op_name /= Void;
		end;

feature -- Properties

	op_name: ID_AS;
			-- Free operator name

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		do
			!!Result.make (7 + op_name.count);
			Result.append (Internal_infix);
			Result.append (op_name);
		end;

	Internal_infix: STRING is "_infix_";
			-- Internal prefix name for feature

	operator_is_keyword: BOOLEAN is false;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (op_name, other.op_name) and then
				equivalent (left, other.left) and then
				equivalent (right, other.right)
		end

feature {BINARY_AS}

	set_infix_function_name (name: like op_name) is
		do
			op_name := clone (name)
			op_name.tail (op_name.count - 7);
			-- 7 = "_infix_".count
		end;

end -- class BIN_FREE_AS
