indexing
	description: "Free binary expression description. Version for Bench"
	date: "$Date$"
	revision: "$Revision$"

class BIN_FREE_AS

inherit
	BINARY_AS
		redefine
			set, operator_is_keyword, is_equivalent
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			left ?= yacc_arg (0)
			op_name ?= yacc_arg (1)
			right ?= yacc_arg (2)
		ensure then
			left_exists: left /= Void
			right_exists: right /= Void
			operator_exists: op_name /= Void
		end

feature -- Attributes

	op_name: ID_AS
			-- Free operator name

feature -- Properties

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		do
			!! Result.make (7 + op_name.count)
			Result.append (Internal_infix)
			Result.append (op_name)
		end

	Internal_infix: STRING is "_infix_"
			-- Internal prefix name for feature

	operator_is_keyword: BOOLEAN is False

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (op_name, other.op_name) and then
				equivalent (left, other.left) and then
				equivalent (right, other.right)
		end

feature -- Byte Node

	byte_anchor: BIN_FREE_B is
			-- Byte code type
		do
			!! Result
		end

feature {BINARY_AS}

	set_infix_function_name (name: ID_AS) is
		do
			op_name := clone (name)
			op_name.tail (op_name.count - 7)
			-- 7 = "_infix_".count
		end

end -- class BIN_FREE_AS
