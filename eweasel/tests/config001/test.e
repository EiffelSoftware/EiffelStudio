class TEST

create
	make

feature 

	make is
		local
			a: A
		do
			print ("Start%N")
			create a
			a.foo
			print ("End%N")
		end
end
