class
	TEST
create
	make

feature -- Initialization

	make is
		do
			io.put_double (Current^2)
			io.put_new_line
			io.put_double (Current^9)
			io.put_new_line
			io.put_double (Current^10.0)
			io.put_new_line
		end

	infix "^" (p: DOUBLE): DOUBLE is
		do
			Result := p
		end
end
