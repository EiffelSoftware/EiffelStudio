class TEST

create
	make

feature
	
	make is
		local
			a: attached ANY
			t: detachable TEST
		do
			a := Current
			if a = t then
				t := Current
			end
		end

end
