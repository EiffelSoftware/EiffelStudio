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

create
	initialize

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

				-- Check if `left_type' conforms to `right_type' or if
				-- `right_type' conforms to `left_type'.
			if
				not (left_type.conform_to (right_type.actual_type) or else
				right_type.conform_to (left_type.actual_type))
			then
				if right_type.convert_to (context.current_class, left_type.actual_type) then
					last_argument_conversion_info := context.last_conversion_info
					if last_argument_conversion_info.has_depend_unit then
						context.supplier_ids.extend (last_argument_conversion_info.depend_unit)
					end
				else
					if left_type.convert_to (context.current_class, right_type.actual_type) then
						last_target_conversion_info := context.last_conversion_info
						if last_target_conversion_info.has_depend_unit then
							context.supplier_ids.extend (last_target_conversion_info.depend_unit)
						end
					else
						create vweq
						context.init_error (vweq)
						vweq.set_left_type (left_type)
						vweq.set_right_type (right_type)
						vweq.set_location (operator_location)
						Error_handler.insert_error (vweq)
					end
				end
			end

				-- Update the type stack
			context.pop (2)
			context.put (Boolean_type)
		end

	byte_node: BINARY_B is
			-- Associated byte code
		do
			Result := byte_anchor
			if last_target_conversion_info /= Void then
				Result.set_left (last_target_conversion_info.byte_node (left.byte_node))
			else
				Result.set_left (left.byte_node)
			end
			if last_argument_conversion_info /= Void then
				Result.set_right (last_argument_conversion_info.byte_node (right.byte_node))
			else
				Result.set_right (right.byte_node)
			end
		end
	
	byte_anchor: BIN_EQUAL_B is
			-- Byte code type
		do
			create {BIN_EQ_B} Result
		end
 
end -- class BIN_EQ_AS
