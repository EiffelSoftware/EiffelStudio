class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			k, n: INTEGER
			r, f: REAL_64
		do
			k := if False then 47 else n end 
			r := if False then f else 2.1 end
		end

end
