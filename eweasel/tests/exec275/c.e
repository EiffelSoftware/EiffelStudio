class C

inherit

	A [INTEGER]
		rename
			h as g
		undefine
			f
		end

	B

create
	make

feature {NONE} -- Creation

	make is
		do
			a := 1
		end

end