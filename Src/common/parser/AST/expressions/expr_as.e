-- Abstract class for expression nodes

deferred class EXPR_AS

inherit

	AST_EIFFEL
		redefine
			byte_node
		end

feature

	byte_node: EXPR_B is
			-- Byte code type
		do
		ensure then
			False
		end;

	text_string: STRING is
			-- Text representation of Current
		do
			Result := "gogo"
		end;

end
