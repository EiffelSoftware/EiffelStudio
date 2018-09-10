class B_OVERFLOW

feature

	overflow_integer_addition (a, b: INTEGER): INTEGER
		do
			Result := a + b
		end

	no_overflow_integer_addition (a, b: INTEGER): INTEGER
		require
			a + b <= {INTEGER}.max_value
		do
			Result := a + b
		end

	overflow_integer_subtraction (a, b: INTEGER): INTEGER
		do
			Result := a - b
		end

	no_overflow_integer_subtraction (a, b: INTEGER): INTEGER
		require
			a - b >= {INTEGER}.min_value
		do
			Result := a - b
		end

	overflow_natural_addition (a, b: NATURAL): NATURAL
		do
			Result := a + b
		end

	no_overflow_natural_addition (a, b: NATURAL): NATURAL
		require
			a + b <= {NATURAL}.max_value
		do
			Result := a + b
		end

	overflow_natural_subtraction (a, b: NATURAL): NATURAL
		do
			Result := a - b
		end

	no_overflow_natural_subtraction (a, b: NATURAL): NATURAL
		require
			a - b >= {NATURAL}.min_value
		do
			Result := a - b
		end

end
