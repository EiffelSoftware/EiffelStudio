class BIN_FREE_B 

inherit

	BINARY_B

feature -- Status

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			-- Do nothing
		end

feature -- IL code generation

	il_operator_constant: INTEGER is
			-- IL code constant associated to current binary
			-- operation
		do
			check False end
		end

feature -- Byte code generation

	operator_constant: CHARACTER is
			-- Byte code constant associated to current binary
			-- operation
		do
		ensure then
			False
		end

end
