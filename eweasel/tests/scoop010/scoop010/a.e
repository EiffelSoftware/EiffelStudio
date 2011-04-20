class A

create
	make

feature {NONE} -- Creation

	make
		local
			sep_b: separate B
		do
			create sep_b.make (Current)
		end

feature -- Access

	print_message
		do
			print ("done%N")
		end

end
