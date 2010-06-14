class A

feature

	foo: A
		do
			create Result
		end

	bat: like Current
		do
			create Result
		end

end