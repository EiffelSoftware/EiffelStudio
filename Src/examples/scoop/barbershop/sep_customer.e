class SEP_CUSTOMER

create
	make

feature
	customer : attached separate CUSTOMER

	make (c : attached separate CUSTOMER)
		do
			customer := c
		ensure
			customer = c
		end

end
