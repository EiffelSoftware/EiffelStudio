class BIN_FREE_B 

inherit

	BINARY_B
	
feature

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
		ensure then
			False
		end; -- operator_constant

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			-- Do nothing
		end;

end
