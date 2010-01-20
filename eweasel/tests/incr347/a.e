class A

create
	make

feature -- Initialisation

	make
		local
			b: B
		do
			create b
			test (b.value)
		end

feature {NONE} -- Implementation

	test (value: C)
		do
		end

end
