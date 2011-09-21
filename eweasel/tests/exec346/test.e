class TEST
create
	make

feature {NONE} -- Initialization

	make
		local
			p: POINTER
		do
			io.put_boolean (p.is_default_pointer)
			io.put_new_line
			p := p + 1
			io.put_boolean (p.is_default_pointer)
			io.put_new_line
		end

end
