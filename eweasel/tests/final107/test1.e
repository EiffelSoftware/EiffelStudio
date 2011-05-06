
class TEST1 [G]

create
	make

feature

	make
		local
			a: ANY
		do
			a := internal.dup (x)
		end

	x: G
		do
		end

	internal: TEST2
	
end
