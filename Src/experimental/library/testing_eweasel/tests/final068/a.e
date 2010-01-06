class A [G]

create
	make

feature {NONE} -- Creation

	 make
		do
			g
		end

feature {NONE} -- Tests

	f (i: INTEGER): G
		do
			if i > 0 then
				Result := f (i - 1)
			end
		end

	g
		local
			x: G
		do
			if f (100) = x then
				io.put_string ("Test: OK")
			else
				io.put_string ("Test: FAILED")
			end
			io.put_new_line
		end

end
