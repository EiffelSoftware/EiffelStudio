indexing
	description: "Free binary expression description. Version for Bench"
	date: "$Date$"
	revision: "$Revision$"

class BIN_FREE_AS

inherit
	BINARY_AS
		rename
			initialize as initialize_binary_as
		redefine
			is_equivalent
		end

	PREFIX_INFIX_NAMES

create
	initialize

feature {NONE} -- Initialization

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

feature -- Attributes

	op_name: ID_AS
			-- Free operator name

feature -- Properties

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		do
			Result := infix_feature_name_with_symbol (op_name)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (op_name, other.op_name) and then
				equivalent (left, other.left) and then
				equivalent (right, other.right)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_free_as (Current)
		end

feature -- Byte Node

	byte_anchor: BIN_FREE_B is
			-- Byte code type
		do
			create Result
		end

feature {BINARY_AS}

	set_infix_function_name (name: ID_AS) is
		do
			create op_name.initialize (extract_symbol_from_infix (name))
		end

end -- class BIN_FREE_AS
