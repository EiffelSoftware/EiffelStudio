-- Counter

class COUNTER

feature

	value: INTEGER;
			-- Counter value

	next: INTEGER is
			-- Next value
		do
			value := value + 1;
			Result := value;
		end;

	reset is
			-- Reset the counter
		do
			value := 0;
		end;

end
