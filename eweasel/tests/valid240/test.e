
class TEST

create
	make

feature

	make
		local
			t: TEST
		do
			create x
			t := Current
			x := t
		end

	x: TEST1

end
