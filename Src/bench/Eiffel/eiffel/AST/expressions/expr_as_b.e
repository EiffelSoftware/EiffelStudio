-- Abstract class for expression nodes

deferred class EXPR_AS

inherit

	AST_EIFFEL
		undefine
			byte_node
		end

feature

	byte_node: EXPR_B is
			-- Byte code type
		deferred
		end;

	text_string: STRING is
			-- Text representation of Current
		do
			Result := "gogo"
		end;

end
