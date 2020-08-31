class A

create
	make

feature {NONE} -- Creation

	make
		do
			x := o
			o.put_string ("Test 1: OK")
			o.put_new_line
		end

feature -- Output

	x: attached like io

	o: attached like io
		local
			r: like io
		do
			r := io
			check r /= Void end
			Result := r
		end

end