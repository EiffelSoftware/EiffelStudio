class TEST

create
	make

feature

	make
		local
			i: INTEGER
		do
			bar (Void).make_from_array (Void)		-- Comment out this line to fix the bug.

			across
				<<1, 2, 3>> as c_i
			loop
				i := c_i.item					-- Error here.
			end
		end

	bar(arg: STRING):  ARRAY[ANY]			-- Change ANY to STRING to fix the bug.
		do
		end

end
