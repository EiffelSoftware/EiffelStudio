class TEST

create
	make

feature {NONE} -- Creation

        make
		local
			sep_a: separate A
		do
			create sep_a.make	
		end

end
