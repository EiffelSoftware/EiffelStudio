class TEST

inherit
	A
	B
		undefine
			f
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
