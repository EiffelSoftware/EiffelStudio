class A

create
	make_with

feature {NONE} -- Creation

	make_with (value: INTEGER_32)
		do
			i1 := value
			i2 := value * 2
		end

feature -- Access

	i1, i2: INTEGER_32

end
