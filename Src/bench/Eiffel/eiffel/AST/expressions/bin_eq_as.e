indexing
	description: "AST representation of binary `=' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_EQ_AS

inherit
	BINARY_AS
		redefine
			type_check, byte_node
		end

	SHARED_TYPES

	PREFIX_INFIX_NAMES

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_eq_as (Current)
		end

feature -- Type check, byte code and dead code removal

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is
			-- Name without the infix keyword.
		once
			Result := "="
		end

	type_check is
			-- type check on an equality test
		local
			left_type, right_type: TYPE_A
			vweq: VWEQ
		do
				-- First type check the left member
			left.type_check
			left_type := context.item

				-- Then type check the right member
			right.type_check
			right_type := context.item

				-- Check id `left_type' conform to `right_type' and if
				-- `right_type' conform to `left_type'.
			if not (left_type.conform_to (right_type.actual_type)
					or else right_type.conform_to (left_type.actual_type))
			then
				create vweq
				context.init_error (vweq)
				vweq.set_left_type (left_type)
				vweq.set_right_type (right_type)
				Error_handler.insert_error (vweq)
			end

				-- Update the type stack
			context.pop (2)
			context.put (Boolean_type)
		end

	byte_node: like byte_anchor is
			-- Associated byte code
		do
			Result := byte_anchor
			Result.set_left (left.byte_node)
			Result.set_right (right.byte_node)
		end
	
	byte_anchor: BIN_EQUAL_B is
			-- Byte code type
		do
			create {BIN_EQ_B} Result
		end
 
end -- class BIN_EQ_AS
