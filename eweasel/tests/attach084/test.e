class TEST

create
	make

feature

	make
			-- Run test.
		local
			s: STRING
		do
			s := "STRING"
			print ("s" + s + "%N")
		end

end

