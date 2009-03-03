class
	HELLO_WORLD

inherit
	SERVLET

create
	make

feature-- Access

	my_var: STRING

feature-- Implementation

	handle_request (request: REQUEST)
		local
			my_var: STRING
		do
		end

end
