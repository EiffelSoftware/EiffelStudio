class BIN_EQ_AS

inherit

	BINARY_AS
		redefine
			type_check, byte_node, operator_is_keyword,
			operator_is_special, operator_name, replicate
		end

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
		end; -- infix_function_name

feature -- Type check, byte code and dead code removal

	type_check is
			-- type check on an equality test
		local
			left_type, right_type: TYPE_A;
			vweq: VWEQ;
		do
				-- First type check the left member
			left.type_check;
			left_type := context.item;

				-- Then type check the right member
			right.type_check;
			right_type := context.item;

				-- Check id `left_type' conform to `right_type' and if
				-- `right_type' conform to `left_type'.
			if not ( 	left_type.conform_to (right_type.actual_type)
						or else
						right_type.conform_to (left_type.actual_type)
					)
			then
				!!vweq;
				context.init_error (vweq);
				vweq.set_type1 (left_type);
				vweq.set_type2 (right_type);
				vweq.set_node (Current);
				Error_handler.insert_error (vweq);
			end;

				-- Update the type stack
			context.pop (2);
			context.put (Boolean_type);
		end;

	byte_node: like byte_anchor is
			-- Associated byte code
		do
			Result := byte_anchor;
			Result.set_left (left.byte_node);
			Result.set_right (right.byte_node);
		end;
	
	byte_anchor: BIN_EQUAL_B is
			-- Byte code type
		do
			!BIN_EQ_B! Result;
		end;

	operator_name: STRING is
		do
			Result := constant_name;
		end;
	
	operator_is_keyword: BOOLEAN is false;
	
	operator_is_special: BOOLEAN is true;
	
feature {}
	
	constant_name: STRING is "_infix_=";

feature -- Replication

	replicate (ctxt: REP_CONTEXT): BINARY_AS is
			-- Adapt to replication.
		do
			Result := twin;
			Result.set_left (left.replicate (ctxt));
			Result.set_right (right.replicate (ctxt.new_ctxt));
		end;
 
end
