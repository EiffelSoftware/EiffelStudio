class
	TEST

create
	make

feature -- Initialization

	make is
			-- Tests
		local
		do
			if {l_s: STRING} f then
				print (l_s.count)
			end

			if {l_s: INTEGER_8} f then
				print (l_s)
			end

			if {l_s: INTEGER_16} f then
				print (l_s)
			end

			if {l_s: INTEGER_32} f then
				print (l_s)
			end

			if {l_s: INTEGER_64} f then
				print (l_s)
			end

			if {l_s: NATURAL_8} f then
				print (l_s)
			end

			if {l_s: NATURAL_16} f then
				print (l_s)
			end

			if {l_s: NATURAL_32} f then
				print (l_s)
			end

			if {l_s: NATURAL_64} f then
				print (l_s)
			end

			print ("%N")
		end


	f: ANY
		do
			Result := "STRING"
		end

end
