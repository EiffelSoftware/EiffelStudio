class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			a: A [C]
			s: detachable STRING
		do
			s := a.foo
		end
		
end
