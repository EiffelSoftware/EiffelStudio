-- Binary expression byte code for a possible boolean expression

deferred class BOOL_BINARY_B 

inherit

	BINARY_B
	
feature 

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := context.real_type (left.type).is_boolean;
		end;

end
