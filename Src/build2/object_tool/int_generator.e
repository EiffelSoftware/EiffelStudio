class INT_GENERATOR 

	--| FIXME inherited form Build "as is".
	
feature 

	value: INTEGER;
			-- Generated integer value

	next is
			-- Set `value' to the next unique integer.
		do
			value := value + 1
		end;

	reset is
			-- Set `value' to its default value.
		do
			value := 0
		end;

	set (i: INTEGER) is
			-- Set `value' to `i'.
		do
			value := i
		end;

end
