indexing
	description: "Free unary expression description. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class
	UN_FREE_AS

inherit
	UNARY_AS
		rename
			initialize as initialize_unary_as
		redefine
			is_equivalent, prefix_feature_name
		end

	PREFIX_INFIX_NAMES

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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_un_free_as (Current)
		end

feature -- Attributes

	op_name: ID_AS
			-- Operator name

feature -- Properties

	prefix_feature_name: STRING is
			-- Internal name
		do
			Result := prefix_feature_name_with_symbol (op_name)
		end

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

feature {UNARY_AS} -- Replication

	set_prefix_feature_name (p: like prefix_feature_name) is
		do
			create op_name.initialize (extract_symbol_from_prefix (p))
		end

end -- class UN_FREE_AS
