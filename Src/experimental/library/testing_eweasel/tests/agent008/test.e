class TEST
create
	make

feature {NONE}

	make
		local
			a: ANY
		do
			a := agent {TUPLE [s: TEST]}.s
			io.put_string (a.generating_type)
			io.put_new_line
		end

end
