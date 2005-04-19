indexing
	description: "Notion of counter."
	date: "$Date$"
	revision: "$Revision: "

class COUNTER

feature -- Access

	value: INTEGER
			-- Counter value

	next: INTEGER is
			-- Next value
		do
			value := value + 1
			Result := value
		end

feature -- Settings

	reset is
			-- Reset the counter
		do
			value := 0
		end

	set_value (val: INTEGER) is
			-- Assign `val' to `value'.
		do
			value := val
		end

end
