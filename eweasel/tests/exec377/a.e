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

	name: detachable STRING

	code: STRING
	    do
	    	if attached name as n then
	        	Result := n.as_lower
	        else
	        	Result := "?"
	    	end
	    end

	to_string: STRING
		do
	    	if attached name as n then
	        	Result := n
	        else
	        	Result := "?"
	    	end
	    end

invariant
end
