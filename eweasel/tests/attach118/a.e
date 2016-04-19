class A [G -> ANY]

create
	make

convert
	make ({G}),
	item: {G}

feature {NONE} -- Creation

	make (value: G)
		do
			item := value
		end

feature -- Access

	item: G

end