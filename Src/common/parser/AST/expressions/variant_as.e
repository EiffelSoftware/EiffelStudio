-- Description of variant loop

class VARIANT_AS

inherit

	TAGGED_AS
		redefine
			expression_type, make_error, byte_node
		end

feature

	byte_node: VARIANT_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_tag (tag);
			Result.set_expr (expr.byte_node);
		end;

	expression_type: TYPE_A is
			-- Type expression
		once
			Result := Integer_type;
		end;

	make_error (t: TYPE_A) is
			-- Raise error
		local
			vave: VAVE;
		do
			!!vave;
			context.init_error (vave);
			vave.set_type (t);
			Error_handler.insert_error (vave);
		end;

end
