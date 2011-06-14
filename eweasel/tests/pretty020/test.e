class
	TEST

create
	make

feature -- Make


	make
		local
			x: INTEGER
		do
			Current[ 1 , 2 , 3 , 4 ]:=5
			x := Current[ 1 , 2 , 3 , 4 ]
		end

	item alias "[]" (i, j, k, l: INTEGER):INTEGER assign put
		do
		end

	put (v: INTEGER; i, j, k, l: INTEGER)
		do
		end

end
