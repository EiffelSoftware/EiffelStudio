-- Abstract class for expression nodes

deferred class EXPR_AS

inherit

	AST_EIFFEL

feature

	text_string: STRING is
			-- Text representation of Current
		do
			Result := "gogo"
		end;

end
