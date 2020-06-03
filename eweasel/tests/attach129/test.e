class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test code.
		do
			print (s.count)
		end

feature {NONE} -- Test

	s: STRING
			-- An attribute with non-empty body.
		attribute
			Result := Void
		end -- Error: VEVI

end
