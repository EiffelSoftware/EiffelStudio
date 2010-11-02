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
				("string") as c
			loop
				i := i + 1
			end
		end

end
