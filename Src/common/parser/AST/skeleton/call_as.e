-- Abstract description ao an EIffel call

deferred class CALL_AS

inherit

	AST_EIFFEL	
		undefine
			byte_node
		end

feature

	byte_node: CALL_B is
		deferred
		end;

end
