class UN_FREE_B 

inherit

	UNARY_B
	
feature

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
		ensure then
			False
		end;

end
