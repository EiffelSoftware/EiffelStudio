class SEP_CUSTOMER

create
	make

feature
	customer : separate CUSTOMER

	make (c : separate CUSTOMER)
		do
			customer := c
		ensure
			customer = c
		end

end
