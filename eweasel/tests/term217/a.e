class A [G]

create
	make

feature {NONE} -- Creation

	make (value: G)
		local
			tuple: TUPLE [value: G]
		do
			tuple := [value]
			tuple.value := value
		end

end