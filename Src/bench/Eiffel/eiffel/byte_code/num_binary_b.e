-- Binary expression byte code for a possible numeric expression

deferred class NUM_BINARY_B

inherit
	BINARY_B

feature

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := real_type (left.type).is_numeric
		end

end
