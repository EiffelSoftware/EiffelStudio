class
	FOO

create
	make

convert
	make ({STRING})

feature {NONE} -- Initialization

	make (s: STRING)
			-- Initialize `Current'.
		do
			string := s	
		end

feature -- Status

	string: STRING

end
