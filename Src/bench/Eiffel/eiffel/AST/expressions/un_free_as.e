indexing
	description: "Free unary expression description. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class UN_FREE_AS

inherit
	UNARY_AS
		redefine
			byte_node,
			set, is_equivalent
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			op_name ?= yacc_arg (0)
			expr ?= yacc_arg (1)
		ensure then
			expr_exists: expr /= Void
			op_name_exists: op_name /= Void
		end

feature -- Attributes

	op_name: ID_AS
			-- Operator name

feature -- Properties

	prefix_feature_name: STRING is
			-- Internal name
		do
			!! Result.make (7 + op_name.count)
			Result.append (Internal_prefix)
			Result.append (op_name)
		end

	Internal_prefix: STRING is "_prefix_"
			-- Prefix string for internal name

	operator_name: STRING is
		do
			Result := op_name
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (op_name, other.op_name) and then
				equivalent (expr, other.expr)
		end

feature -- Type check

	byte_node: UN_FREE_B is
			-- Associated byte code
		local
			access_line: ACCESS_LINE
			feature_b: FEATURE_B
		do
			!! Result
			Result.set_expr (expr.byte_node)

			access_line := context.access_line
			feature_b ?= access_line.access
			Result.init (feature_b)
			access_line.forth
		end

feature {UNARY_AS}	-- Replication

	set_prefix_feature_name (p: like prefix_feature_name) is
		do
			!! op_name.make (p.count)
			op_name.append (clone (p))
			op_name.tail (op_name.count - 8)
				-- 8 is "_prefix_".count
		end

end -- class UN_FREE_AS
