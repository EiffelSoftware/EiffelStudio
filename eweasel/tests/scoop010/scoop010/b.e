class B 

create
	make

feature {NONE} -- Creation

        make (sep_a: separate A)
		do
			sep_a.print_message
		end
end
