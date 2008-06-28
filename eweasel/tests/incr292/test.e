class TEST
create
	make

feature {NONE}

	make
		local
			c: C
		do
			create c
			if c.name /= Void then
			end
		end

end
