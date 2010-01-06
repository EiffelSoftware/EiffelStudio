class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			b: BOOLEAN
			c: CHARACTER
			i: INTEGER
		do
			from
				c := '%/0/'
			until
				c >= '%/127/'
			loop
				i := 0
				inspect c
				when '%/0/' .. '%/50/' then
					i := 1
				when
					'%/54/', '%/56/', '%/58/', '%/60/', '%/62/'
				then
					i := 2
				else
					i := 3
				end
				if c  <= '%/50/' then
					b := i = 1
				elseif '%/54/' <= c and c <= '%/62/' and c.code \\ 2 = 0 then
					b := i = 2
				else
					b := i = 3
				end
				if not b then
					io.put_string ("Failed at c=%"%%/")
					io.put_integer (c.code)
					io.put_string ("/%"")
					io.put_new_line
				end
				c := c + 1
			end
		end

end