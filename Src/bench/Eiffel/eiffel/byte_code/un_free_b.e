class UN_FREE_B 

inherit

	UNARY_B
	

feature -- IL code generation

	il_operator_constant: INTEGER is
		do
			check False end
		end

feature -- Byte code generation

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
			check False end
		end

end
