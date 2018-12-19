class TEST

inherit
	B
	C
		redefine
			f
		end

create
	make

feature {NONE} -- Creation

	make
		do
		end

end
