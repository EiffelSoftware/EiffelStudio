class TEST
create
	make
feature
	make
		do
			d := c	
			if a /= b then
				io.put_string ("We have a serious problem here%N")
			end
			if d /= b then
				io.put_string ("We have a serious problem here%N")
			end
		end

	a: STRING
		do
			Result := c
		end

	b: STRING
		local
			mem: MEMORY
		do
			create mem
			mem.full_collect
			Result := c
		end

	c: STRING = "ABC"

	d: STRING

end
