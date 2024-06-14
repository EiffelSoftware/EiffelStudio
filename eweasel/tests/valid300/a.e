class
	A

create
	make

feature {NONE} -- Initialization

	make (n: like name)
			-- Initialize `Current'.
		do
			name := n
		end

feature -- Access

	name: STRING

	code: STRING
	    do
	        Result := name.as_lower
	    end

	to_string: STRING
		do
			Result := name
	    end

end
