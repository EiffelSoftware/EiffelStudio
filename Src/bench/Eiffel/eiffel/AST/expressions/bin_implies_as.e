indexing
	description: "AST representation of binary `implies' operation."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_IMPLIES_AS

inherit
	BINARY_AS
		redefine
			byte_node
		end

	PREFIX_INFIX_NAMES

create
	initialize

feature -- Byte code

	byte_node: EXPR_B is
			-- Associated byte node
		local
			access_line: ACCESS_LINE
			call_access_b: CALL_ACCESS_B
			l_info: CONVERSION_INFO
			l_node: EXPR_B
			l_bool_val: VALUE_I
			l_binary_node: B_IMPLIES_B
		do
			if parameters_convert_info /= Void then
				l_info := parameters_convert_info.item (0)
			end
			if l_info /= Void then
				l_node := l_info.byte_node (left.byte_node)
			else
				l_node := left.byte_node
			end
			
			l_bool_val := l_node.evaluate
			if l_bool_val.is_boolean and then not l_bool_val.boolean_value then
					 -- Expression can be simplified into a Boolean constant
				 create {BOOL_CONST_B} Result.make (True)
				 
					 -- Compute right byte node and update AST_CONTEXT to
					 -- ensure consistency of AST_CONTEXT which will be
					 -- messed up if we don't do it.
				 l_node := right.byte_node
				 context.access_line.forth
			else
				l_binary_node := byte_anchor

					-- We cannot simplify Current, generate a B_IMPLIES_B instance.
				l_binary_node.set_left (l_node)
				
				if parameters_convert_info /= Void then
					l_info := parameters_convert_info.item (1)
				end
				if l_info /= Void then
					l_binary_node.set_right (l_info.byte_node (right.byte_node))
				else
					l_binary_node.set_right (right.byte_node)
				end
	
				access_line := context.access_line
				call_access_b ?= access_line.access
				l_binary_node.init (call_access_b)
				l_binary_node.set_attachment (attachment.type_i)
				access_line.forth
				Result := l_binary_node
			end
		end

feature -- Properties

	byte_anchor: B_IMPLIES_B is
			-- Byte code type
		do
			create Result
		end

	infix_function_name: STRING is
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name)
		end

	op_name: STRING is "implies"
			-- Name without the infix keyword.

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_implies_as (Current)
		end

end -- class BIN_IMPLIES_AS
