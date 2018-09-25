class TEST

create
       make

feature {NONE} -- Creation

        make
		local
			i: INTEGER
		do
			i :=
			across
				("string") is c
			loop
				i := i + 1
			end
		end

end
